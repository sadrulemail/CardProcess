using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Xml;
using System.Globalization;
using Ionic.Zip;

public partial class NPSB_Upload : System.Web.UI.Page
{
    //string UploadTempFile;
    //string UploadTempFolder;

    protected void Page_Load(object sender, EventArgs e)
    {        
        TrustControl1.getUserRoles();
        //if (TrustControl1.isRole("ADMIN"))
        //{
        //    if (Session["DEPTID"].ToString() != "7")    //Not IT & Cards
        //    {
        //        Response.Write("No Permission.<br><br><a href=''>Home</a>");
        //        Response.End();
        //    }
        //}
        if (!Directory.Exists(Server.MapPath("Upload")))
        {
            Directory.CreateDirectory(Server.MapPath("Upload"));
        }
        //UploadTempFile = Server.MapPath("Upload/" + Session["EMPID"].ToString() + "_" + Session.SessionID + ".xml");
        //UploadTempFolder = Path.Combine(Path.GetDirectoryName(UploadTempFile), Session.SessionID);

        if (!IsPostBack)
        {
            //CleanDatabase();
            //try
            //{
            //    Directory.Delete(UploadTempFolder, true);
            //}
            //catch (Exception) { }           

            Random R = new Random(DateTime.Now.Millisecond +
                            DateTime.Now.Second * 1000 +
                            DateTime.Now.Minute * 60000 +
                            DateTime.Now.Hour * 3600000);

            HidPageID.Value = string.Format("{0}{1}", Session.SessionID, R.Next());
            HidUploadTempFolder.Value = Server.MapPath("Upload/" + Session["EMPID"].ToString() + "_" + HidPageID.Value);
            {
                CleanDatabase();
            }

            DeleteOldUploadedFiles();
        }
        Session["SESSIONID"] = Session.SessionID;

        this.Title = "NPSB File Upload";
    }

    private void CleanDatabase()
    {
        //RunNonQuery("EXEC sp_CIB_DeleteTemp '" + Session.SessionID + "'", "Report_DBConnectionString", CommandType.Text);
    }

    protected void FileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        Session["FILENAME"] = FileUpload1.FileName.Trim();
        //lblUploadStatus.Text = "Uploaded File: " + FileUpload1.FileName;
        if (Directory.Exists(HidUploadTempFolder.Value))
            Directory.Delete(HidUploadTempFolder.Value, true);

        Directory.CreateDirectory(HidUploadTempFolder.Value);
        string Filename = HidUploadTempFolder.Value + "//" + FileUpload1.FileName;

        FileUpload1.SaveAs(Filename);
        FileInfo FI = new FileInfo(Filename);

        if (FI.Extension.ToString().ToLower() == ".zip")
        {
            ZipFile zf = new ZipFile(Filename);
            zf.ExtractAll(HidUploadTempFolder.Value, ExtractExistingFileAction.OverwriteSilently);
            zf.Dispose();

            File.Delete(Filename);
        }

        //File.SetCreationTime(UploadTempFile, DateTime.Now);
        //FileInfo FI = new FileInfo(UploadTempFile);
        
    }

    private void DeleteOldUploadedFiles()
    {
        string[] Files = Directory.GetFiles(Server.MapPath("Upload/"), "*.*", SearchOption.AllDirectories);
        foreach (string FileName in Files)
            if (File.GetCreationTime(FileName) < DateTime.Now.AddHours(-1) || FileName.Contains(Session.SessionID))
                File.Delete(FileName);
    }

    protected void cmdCheck_Click(object sender, EventArgs e)
    {
        Panel1.Visible = false;
        CleanDatabase();

        string[] Files = Directory.GetFiles(HidUploadTempFolder.Value, "*.xml", SearchOption.AllDirectories);

        foreach (string file in Files)
        {
            ParseFile(file);
            File.Delete(file);
        }

        Directory.Delete(HidUploadTempFolder.Value);

        NPSBListGrid.DataBind();
        GridView2.DataBind();
        
        DeleteOldUploadedFiles();
    }



    private void RunNonQuery(string Query, string ConnectionStringsName, CommandType commandType)
    {
        string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings[ConnectionStringsName].ConnectionString;
        SqlConnection oConn = new SqlConnection(oConnString);

        SqlCommand oCommand = new SqlCommand(Query, oConn);
        oCommand.CommandType = commandType;
        if (oConn.State == ConnectionState.Closed)
            oConn.Open();
        oCommand.ExecuteNonQuery();
    }    

    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

    }    

    protected void cmdClearData_Click(object sender, EventArgs e)
    {
        CleanDatabase();
    }

    protected void cmdSaveData_SaveData(object sender, EventArgs e)
    {
        string BatchNo = "";

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_NPSB_SaveUploadData";
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = Query;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add("@SessionID", System.Data.SqlDbType.VarChar).Value = HidPageID.Value;
                cmd.Parameters.Add("@InsertBy", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();

                SqlParameter Sql_BathcID = new SqlParameter("@BatchNo", SqlDbType.Int);
                Sql_BathcID.Direction = ParameterDirection.InputOutput;
                Sql_BathcID.Value = 0;
                cmd.Parameters.Add(Sql_BathcID);

                cmd.Connection = conn;
                conn.Open();

                if (conn.State == System.Data.ConnectionState.Closed) conn.Open();

                cmd.ExecuteNonQuery();

                BatchNo = string.Format("{0}", Sql_BathcID.Value);

                cmdSaveData.Visible = false;
                //GridView1.Visible = false;                
            }
        }
        GridView2.DataBind();

        TrustControl1.ClientMsg("Data Saved Successfully.");
    }    



    protected void ParseFile(string Filename)
    {

        string XmlFileContent = File.ReadAllText(Filename);
        //XmlFileContent = XmlFileContent.Replace("xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"", "").Replace("xmlns=\"http://tempuri.org/sdnList.xsd\"", "");
        
        
        XmlDocument xDoc = new XmlDocument();
        xDoc.LoadXml(XmlFileContent);

        XmlNodeList xNodeList = xDoc.SelectNodes("DocFile/child::node()");

        //string SDNMainID = string.Empty;
        //int SDNID = 0;

        FileInfo FI = new FileInfo(Filename);
        string _FileName = FI.Name;

        string FormatVersion = null;
        string Sender = null;
        DateTime CreationDate = new DateTime();
        string CreationTime = null;
        string FileSeqNumber = null;
        string Receiver = null;
        
        string MsgCode = null;
        string FinCategory = null;
        string RequestCategory = null;
        string ServiceClass = null;
        string TransTypeCode = null;
        string TransCondition = null;
        string Dispute_ReasonCode = null;
        string Dispute_ReasonDetails = null;

        string Parm = null;
        string ParmVal = null;
        string Parm_DRN = null;
        string Parm_SRN = null;
        string Parm_RRN = null;
        string Parm_AuthCode = null;
        string Parm_PrevDRN = null;
        string Parm_OrigDRN = null;
        string Parm_SummDRN = null;
        string Parm_IRN = null;
        string Parm_ARN = null;

        DateTime LocalDt = new DateTime();
        string NWDt = null;
        
        string SIC = null;
        string Country = null;
        string City = null;
        string MerchantName = null;
        string MerchantID = null;

        string ContractNumber = null;
        string MemberId = null;
        string Channel = null;

        string D_ContractNumber = null;
        string D_Relation = null;
        string D_MemberId = null;
        string CardExpiry = null;
        string D_Channel = null;

        string Trans_Currency = null;
        string Trans_Amount = null;
        string Parm_AUTH_MODE = null;
        string Parm_SRVC = null;
        string Parm_FX_RATE = null;
        string Parm_CARD_ABSENT = null;
        string Parm_BCURR = null;
        string Parm_SG = null;
        string Parm_NEXT_AMOUNT = null;
        string Parm_BRAND = null;
        string Parm_FIN_CURR = null;
        string Parm_SRC = null;
        string Parm_NEXT_CURR = null;
        string Parm_NEXT_CH = null;
        string Parm_PROC_CLASS = null;
        string Parm_RCAT = null;
        string Parm_WHAT_TRX = null;
        string Parm_AUTH_AMOUNT = null;
        string Parm_FIN_AMOUNT = null;

        string Bill_Currency = null;
        string Bill_Amount = null;
        string PhaseDate = null;
        string Recon_Currency = null;
        string Recon_Amount = null;


        foreach (XmlNode xNode in xNodeList)
        {
            if (xNode.Name == "FileHeader")
            {
                foreach (XmlNode xNode1 in xNode.ChildNodes)
                {
                    switch (xNode1.Name)
                    {
                        case "FormatVersion":
                            FormatVersion = xNode1.InnerText;
                            break;

                        case "Sender":
                            Sender = xNode1.InnerText;
                            break;

                        case "CreationDate":
                            CreationDate = DateTime.ParseExact(xNode1.InnerText, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                            break;

                        case "CreationTime":
                            CreationDate = CreationDate.AddHours(int.Parse(xNode1.InnerText.Trim().Split(':')[0]))
                                .AddMinutes(int.Parse(xNode1.InnerText.Trim().Split(':')[1]))
                                .AddSeconds(int.Parse(xNode1.InnerText.Trim().Split(':')[2]));
                            break;

                        case "FileSeqNumber":
                            FileSeqNumber = xNode1.InnerText;
                            break;

                        case "Receiver":
                            Receiver = xNode1.InnerText;
                            break;

                    }
                }
            }

            if (xNode.Name == "DocList")  //DocList Start............
            {
                foreach (XmlNode xNode1 in xNode.ChildNodes)  //Individual Doc start..........
                {
                    foreach (XmlNode xNode2 in xNode1.ChildNodes) //Doc Root Node start.......
                    {
                        if (xNode2.Name == "TransType")
                        {
                            foreach (XmlNode xNode3 in xNode2.ChildNodes)
                            {
                                if (xNode3.Name == "TransCode")
                                {
                                    foreach (XmlNode xNode4 in xNode3.ChildNodes)
                                    {
                                        switch (xNode4.Name)
                                        {
                                            case "MsgCode":
                                                MsgCode = xNode4.InnerText;
                                                break;

                                            case "FinCategory":
                                                FinCategory = xNode4.InnerText;
                                                break;

                                            case "RequestCategory":
                                                RequestCategory = xNode4.InnerText;
                                                break;

                                            case "ServiceClass":
                                                ServiceClass = xNode4.InnerText;
                                                break;

                                            case "TransTypeCode":
                                                TransTypeCode = xNode4.InnerText;
                                                break;
                                        }
                                    }
                                }
                                
                                else if (xNode3.Name == "TransCondition")
                                {
                                    TransCondition = xNode3.InnerText;
                                }

                                else if (xNode3.Name == "DisputeRules")
                                {
                                    foreach (XmlNode xNode4 in xNode3.ChildNodes)
                                    {
                                        switch (xNode4.Name)
                                        {
                                            case "ReasonCode":
                                                Dispute_ReasonCode = xNode4.InnerText;
                                                break;

                                            case "ReasonDetails":
                                                Dispute_ReasonDetails = xNode4.InnerText;
                                                break;
                                        }
                                    }
                                }

                            }
                        }

                        else if (xNode2.Name == "DocRefSet")
                        {
                            foreach (XmlNode xNode3 in xNode2.ChildNodes)
                            {
                                foreach (XmlNode xNode4 in xNode3.ChildNodes)
                                {
                                    switch (xNode4.Name)
                                    {
                                        case "ParmCode":
                                            Parm = xNode4.InnerText;
                                            break;

                                        case "Value":
                                            ParmVal = xNode4.InnerText;
                                            if (Parm == "DRN") { Parm_DRN = ParmVal; }
                                            if (Parm == "SRN") { Parm_SRN = ParmVal; }
                                            if (Parm == "RRN") { Parm_RRN = ParmVal; }
                                            if (Parm == "AuthCode") { Parm_AuthCode = ParmVal; }
                                            if (Parm == "PrevDRN") { Parm_PrevDRN = ParmVal; }
                                            if (Parm == "OrigDRN") { Parm_OrigDRN = ParmVal; }
                                            if (Parm == "SummDRN") { Parm_SummDRN = ParmVal; }
                                            if (Parm == "IRN") { Parm_IRN = ParmVal; }
                                            if (Parm == "ARN") { Parm_ARN = ParmVal; }
                                            break;
                                    }
                                }
                            }
                        }

                        else if (xNode2.Name == "LocalDt")
                        {
                            //LocalDt = DateTime.ParseExact(xNode2.InnerText, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                            LocalDt = DateTime.Parse(xNode2.InnerText);
                        }

                        else if (xNode2.Name == "NWDt")
                        {
                            //LocalDt.AddHours(int.Parse(xNode2.InnerText.Trim().Split(':')[0]))
                            //    .AddMinutes(int.Parse(xNode2.InnerText.Trim().Split(':')[1]))
                            //    .AddSeconds(int.Parse(xNode2.InnerText.Trim().Split(':')[2]));
                            NWDt = xNode2.InnerText;
                        }

                        else if (xNode2.Name == "SourceDtls")
                        {
                            foreach (XmlNode xNode3 in xNode2.ChildNodes)
                            {
                                switch (xNode3.Name)
                                {
                                    case "SIC":
                                        SIC = xNode3.InnerText;
                                        break;

                                    case "Country":
                                        Country = xNode3.InnerText;
                                        break;

                                    case "City":
                                        City = xNode3.InnerText;
                                        break;

                                    case "MerchantName":
                                        MerchantName = xNode3.InnerText;
                                        break;

                                    case "MerchantID":
                                        MerchantID = xNode3.InnerText;
                                        break;
                                }
                            }
                        }


                        else if (xNode2.Name == "Originator")
                        {
                            foreach (XmlNode xNode3 in xNode2.ChildNodes)
                            {
                                switch (xNode3.Name)
                                {
                                    case "ContractNumber":
                                        ContractNumber = xNode3.InnerText;
                                        break;

                                    case "MemberId":
                                        MemberId = xNode3.InnerText;
                                        break;

                                    case "Product":
                                        foreach (XmlNode xNode4 in xNode3.ChildNodes)
                                        {
                                            Channel = xNode4.InnerText;
                                        }
                                        break;
                                }
                            }
                        }


                        else if (xNode2.Name == "Destination")
                        {
                            foreach (XmlNode xNode3 in xNode2.ChildNodes)
                            {
                                switch (xNode3.Name)
                                {
                                    case "ContractNumber":
                                        D_ContractNumber = xNode3.InnerText;
                                        break;

                                    case "Relation":
                                        D_Relation = xNode3.InnerText;
                                        break;

                                    case "MemberId":
                                        D_MemberId = xNode3.InnerText;
                                        break;

                                    case "CardInfo":
                                        foreach (XmlNode xNode4 in xNode3.ChildNodes)
                                        {
                                            CardExpiry = xNode4.InnerText;
                                        }
                                        break;

                                    case "Product":
                                        foreach (XmlNode xNode4 in xNode3.ChildNodes)
                                        {
                                            D_Channel = xNode4.InnerText;
                                        }
                                        break;
                                }
                            }
                        }


                        else if (xNode2.Name == "Transaction")
                        {
                            foreach (XmlNode xNode3 in xNode2.ChildNodes)
                            {
                                switch (xNode3.Name)
                                {
                                    case "Currency":
                                        Trans_Currency = xNode3.InnerText;
                                        break;

                                    case "Amount":
                                        Trans_Amount = xNode3.InnerText;
                                        break;

                                    case "Extra":
                                        foreach (XmlNode xNode4 in xNode3.ChildNodes)
                                        {
                                            if (xNode4.Name == "AddData")
                                            {
                                                foreach (XmlNode xNode5 in xNode4.ChildNodes)
                                                {
                                                    foreach (XmlNode xNode6 in xNode5.ChildNodes)
                                                    {
                                                        switch (xNode6.Name)
                                                        {
                                                            case "ParmCode":
                                                                Parm = xNode6.InnerText;
                                                                break;

                                                            case "Value":
                                                                ParmVal = xNode6.InnerText;
                                                                if (Parm == "AUTH_MODE") { Parm_AUTH_MODE = ParmVal; }
                                                                if (Parm == "FX_RATE") { Parm_FX_RATE = ParmVal; }
                                                                if (Parm == "CARD_ABSENT") { Parm_CARD_ABSENT = ParmVal; }
                                                                if (Parm == "BCURR") { Parm_BCURR = ParmVal; }
                                                                if (Parm == "SRVC") { Parm_SRVC = ParmVal; }
                                                                if (Parm == "SG") { Parm_SG = ParmVal; }
                                                                if (Parm == "NEXT_AMOUNT") { Parm_NEXT_AMOUNT = ParmVal; }
                                                                if (Parm == "BRAND") { Parm_BRAND = ParmVal; }
                                                                if (Parm == "FIN_CURR") { Parm_FIN_CURR = ParmVal; }
                                                                if (Parm == "SRC") { Parm_SRC = ParmVal; }
                                                                if (Parm == "NEXT_CURR") { Parm_NEXT_CURR = ParmVal; }
                                                                if (Parm == "NEXT_CH") { Parm_NEXT_CH = ParmVal; }
                                                                if (Parm == "PROC_CLASS") { Parm_PROC_CLASS = ParmVal; }
                                                                if (Parm == "RCAT") { Parm_RCAT = ParmVal; }
                                                                if (Parm == "WHAT_TRX") { Parm_WHAT_TRX = ParmVal; }
                                                                if (Parm == "AUTH_AMOUNT") { Parm_AUTH_AMOUNT = ParmVal; }
                                                                if (Parm == "FIN_AMOUNT") { Parm_FIN_AMOUNT = ParmVal; }
                                                                break;
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        break;
                                }
                            }
                        }


                        else if (xNode2.Name == "Billing")
                        {
                            foreach (XmlNode xNode3 in xNode2.ChildNodes)
                            {
                                switch (xNode3.Name)
                                {
                                    case "Currency":
                                        Bill_Currency = xNode3.InnerText;
                                        break;

                                    case "Amount":
                                        Bill_Amount = xNode3.InnerText;
                                        break;

                                    case "PhaseDate":
                                        PhaseDate = xNode3.InnerText;
                                        break;
                                }
                            }
                        }



                        else if (xNode2.Name == "Reconciliation")
                        {
                            foreach (XmlNode xNode3 in xNode2.ChildNodes)
                            {
                                switch (xNode3.Name)
                                {
                                    case "Currency":
                                        Recon_Currency = xNode3.InnerText;
                                        break;

                                    case "Amount":
                                        Recon_Amount = xNode3.InnerText;
                                        break;
                                }
                            }
                        }




                    } // Doc Root Node End.........

                    try
                    {
                        string constr = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ToString();
                        SqlConnection con = new SqlConnection(constr);
                        SqlDataAdapter adapt = new SqlDataAdapter("s_NPSB_UploadData", con);
                        adapt.SelectCommand.CommandType = CommandType.StoredProcedure;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@FormatVersion", SqlDbType.VarChar, 30)).Value = FormatVersion;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Sender", SqlDbType.VarChar, 30)).Value = Sender;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@CreationDate", SqlDbType.DateTime)).Value = CreationDate;
                        //adapt.SelectCommand.Parameters.Add(new SqlParameter("@CreationTime", SqlDbType.VarChar, 30)).Value = CreationTime;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@FileSeqNumber", SqlDbType.VarChar, 30)).Value = FileSeqNumber;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Receiver", SqlDbType.VarChar, 30)).Value = Receiver;

                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@MsgCode", SqlDbType.VarChar, 30)).Value = MsgCode;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@FinCategory", SqlDbType.VarChar, 30)).Value = FinCategory;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@RequestCategory", SqlDbType.VarChar, 30)).Value = RequestCategory;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@ServiceClass", SqlDbType.VarChar, 30)).Value = ServiceClass;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@TransTypeCode", SqlDbType.VarChar, 30)).Value = TransTypeCode;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@TransCondition", SqlDbType.VarChar, 2000)).Value = TransCondition;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Dispute_ReasonCode", SqlDbType.VarChar, 2000)).Value = Dispute_ReasonCode;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Dispute_ReasonDetails", SqlDbType.VarChar, 2000)).Value = Dispute_ReasonDetails;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_DRN", SqlDbType.VarChar, 30)).Value = Parm_DRN;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_SRN", SqlDbType.VarChar, 30)).Value = Parm_SRN;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_RRN", SqlDbType.VarChar, 30)).Value = Parm_RRN;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_AuthCode", SqlDbType.VarChar, 30)).Value = Parm_AuthCode;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_PrevDRN", SqlDbType.VarChar, 30)).Value = Parm_PrevDRN;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_OrigDRN", SqlDbType.VarChar, 30)).Value = Parm_OrigDRN;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_SummDRN", SqlDbType.VarChar, 30)).Value = Parm_SummDRN;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_IRN", SqlDbType.VarChar, 30)).Value = Parm_IRN;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_ARN", SqlDbType.VarChar, 30)).Value = Parm_ARN;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@LocalDt", SqlDbType.DateTime)).Value = LocalDt;
                        //adapt.SelectCommand.Parameters.Add(new SqlParameter("@NWDt", SqlDbType.DateTime)).Value = NWDt;
                        
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@SIC", SqlDbType.VarChar, 30)).Value = SIC;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Country", SqlDbType.VarChar, 100)).Value = Country;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@City", SqlDbType.VarChar, 100)).Value = City;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@MerchantName", SqlDbType.VarChar, 100)).Value = MerchantName;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@MerchantID", SqlDbType.VarChar, 100)).Value = MerchantID;
                        
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@ContractNumber", SqlDbType.VarChar, 100)).Value = ContractNumber;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@MemberId", SqlDbType.VarChar, 100)).Value = MemberId;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Channel", SqlDbType.VarChar, 100)).Value = Channel;

                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@D_ContractNumber", SqlDbType.VarChar, 100)).Value = D_ContractNumber;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@D_Relation", SqlDbType.VarChar, 100)).Value = D_Relation;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@D_MemberId", SqlDbType.VarChar, 100)).Value = D_MemberId;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@CardExpiry", SqlDbType.VarChar, 100)).Value = CardExpiry;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@D_Channel", SqlDbType.VarChar, 100)).Value = D_Channel;

                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Trans_Currency", SqlDbType.VarChar, 100)).Value = Trans_Currency;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Trans_Amount", SqlDbType.VarChar, 100)).Value = Trans_Amount;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_AUTH_MODE", SqlDbType.VarChar, 100)).Value = Parm_AUTH_MODE;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_FX_RATE", SqlDbType.VarChar, 100)).Value = Parm_FX_RATE;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_CARD_ABSENT", SqlDbType.VarChar, 100)).Value = Parm_CARD_ABSENT;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_BCURR", SqlDbType.VarChar, 100)).Value = Parm_BCURR;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_SG", SqlDbType.VarChar, 100)).Value = Parm_SG;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_SRVC", SqlDbType.VarChar, 255)).Value = Parm_SRVC;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_NEXT_AMOUNT", SqlDbType.VarChar, 100)).Value = Parm_NEXT_AMOUNT;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_BRAND", SqlDbType.VarChar, 100)).Value = Parm_BRAND;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_FIN_CURR", SqlDbType.VarChar, 100)).Value = Parm_FIN_CURR;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_SRC", SqlDbType.VarChar, 100)).Value = Parm_SRC;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_NEXT_CURR", SqlDbType.VarChar, 100)).Value = Parm_NEXT_CURR;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_NEXT_CH", SqlDbType.VarChar, 100)).Value = Parm_NEXT_CH;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_PROC_CLASS", SqlDbType.VarChar, 100)).Value = Parm_PROC_CLASS;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_RCAT", SqlDbType.VarChar, 100)).Value = Parm_RCAT;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_WHAT_TRX", SqlDbType.VarChar, 100)).Value = Parm_WHAT_TRX;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_AUTH_AMOUNT", SqlDbType.VarChar, 100)).Value = Parm_AUTH_AMOUNT;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_FIN_AMOUNT", SqlDbType.VarChar, 100)).Value = Parm_FIN_AMOUNT;

                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Bill_Currency", SqlDbType.VarChar, 100)).Value = Bill_Currency;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Bill_Amount", SqlDbType.VarChar, 100)).Value = Bill_Amount;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@PhaseDate", SqlDbType.Date)).Value = PhaseDate;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Recon_Currency", SqlDbType.VarChar, 100)).Value = Recon_Currency;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@Recon_Amount", SqlDbType.VarChar, 100)).Value = Recon_Amount;
                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@FileName", SqlDbType.VarChar, 255)).Value = _FileName;

                        adapt.SelectCommand.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar, 100)).Value = HidPageID.Value;            
                        ////DataSet dt = new DataSet();
                        DataTable dt = new DataTable();
                        adapt.Fill(dt);
                        //SDNMainID = dt.Rows[0][0].ToString();
                        //SDNID = Convert.ToInt32(SDNMainID.Trim());

                    }
                    catch (Exception ex) { }                    
                    MsgCode = null; FinCategory = null; RequestCategory = null; ServiceClass = null; TransTypeCode = null; TransCondition=null;
                    Dispute_ReasonCode = null; Dispute_ReasonDetails = null;
                    Parm_DRN = null; Parm_SRN = null; Parm_RRN = null; Parm_AuthCode = null; Parm_PrevDRN = null; Parm_OrigDRN = null;
                    Parm_SummDRN = null; Parm_IRN = null; Parm_ARN = null;
                    LocalDt = new DateTime(); NWDt = null;SIC = null; Country = null; City = null; MerchantName = null; MerchantID = null;
                    ContractNumber = null; MemberId = null; Channel = null; D_ContractNumber = null; D_Relation = null; D_MemberId = null;
                    CardExpiry = null; D_Channel = null; Trans_Currency = null; Trans_Amount = null; Parm_AUTH_MODE = null; Parm_FX_RATE = null;
                    Parm_CARD_ABSENT = null; Parm_BCURR = null; Parm_SG = null; Parm_NEXT_AMOUNT = null; Parm_BRAND = null; Parm_FIN_CURR = null;
                    Parm_SRC = null; Parm_NEXT_CURR = null; Parm_NEXT_CH = null; Parm_PROC_CLASS = null; Parm_RCAT = null;
                    Parm_WHAT_TRX = null; Parm_AUTH_AMOUNT = null; Parm_FIN_AMOUNT = null; Bill_Currency = null;
                    Bill_Amount = null; PhaseDate = null; Recon_Currency = null; Recon_Amount = null; 

                }   //Individual Doc End.......


            }  //DocList End............            
        }
        FormatVersion = null; Sender = null; CreationDate = new DateTime(); CreationTime = null; FileSeqNumber = null; Receiver = null;

        cmdSaveData.Visible = true;

        //for log only.............
        //try
        //{
        //    GridView2.Visible = true;
        //    string constr = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ToString();
        //    SqlConnection con = new SqlConnection(constr);
        //    SqlDataAdapter adapt = new SqlDataAdapter("s_NPSB_UploadLog", con);
        //    adapt.SelectCommand.CommandType = CommandType.StoredProcedure;
        //    //adapt.SelectCommand.Parameters.Add(new SqlParameter("@BatchID", SqlDbType.VarChar, 10)).Value = batchNo;
        //    adapt.SelectCommand.Parameters.Add(new SqlParameter("@InsertBy", SqlDbType.VarChar, 10)).Value = Session["EMPID"];            
        //    DataSet dt = new DataSet();
        //    adapt.Fill(dt);          

        //}
        //catch (Exception ex) { }

    }



}