using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Xml;
using System.Globalization;

public partial class npsb_itcl_DisputeCheck : System.Web.UI.Page
{
    string UploadTempFile;

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        if (!TrustControl1.isRole("ADMIN"))
        {
            if (Session["DEPTID"].ToString() != "7")    //Not IT & Cards
            {
                Response.Write("No Permission.<br><br><a href=''>Home</a>");
                Response.End();
            }
        }
        if (!Directory.Exists(Server.MapPath("Upload")))
        {
            Directory.CreateDirectory(Server.MapPath("Upload"));
        }

        if (!IsPostBack)
        {
            GenerateUploadFileName();

            Session["UploadTempFile"] = UploadTempFile;

            try
            {

                string[] FileNames = Directory.GetFiles(Path.GetDirectoryName(UploadTempFile));
                foreach (string FN in FileNames)
                {
                    FileInfo FI = new FileInfo(FN);
                    if (FI.CreationTime.AddHours(1) < DateTime.Now)
                        try
                        {
                            File.Delete(FI.FullName);
                        }
                        catch (Exception) { }
                }
            }
            catch (Exception) { }
            //Panel2.Visible = false;
            //RunNonQuery("DELETE FROM TempCardEmail WHERE EmpID = '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);

            Random R = new Random(DateTime.Now.Millisecond +
                                DateTime.Now.Second * 1000 +
                                DateTime.Now.Minute * 60000 +
                                DateTime.Now.Hour * 3600000);

            HidPageID.Value = string.Format("{0}{1}", Session.SessionID, R.Next());
            HidUploadTempFolder.Value = Server.MapPath("Upload/" + Session["EMPID"].ToString() + "_" + HidPageID.Value);
            {
                //CleanDatabase();
            }

            //DeleteOldUploadedFiles();


        }

        Title = "Dispute Check";
    }

    private void GenerateUploadFileName()
    {
        string FileName = Session["EMPID"].ToString() + "_Up_Dispute_" + string.Format("{0:ddMMyyHHmmss}", DateTime.Now);
        UploadTempFile = Server.MapPath("Upload/" + FileName);
    }

    protected void FileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        Session["FILENAME"] = FileUpload1.FileName.Trim();
        //lblUploadStatus.Text = "Uploaded File: " + FileUpload1.FileName;
        if (File.Exists(UploadTempFile))
            File.Delete(UploadTempFile);
        FileUpload1.SaveAs(Session["UploadTempFile"].ToString());
    }

    private int RunNonQuery(string Query, string ConnectionStringsName, CommandType commandType)
    {
        string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings[ConnectionStringsName].ConnectionString;
        SqlConnection oConn = new SqlConnection(oConnString);

        SqlCommand oCommand = new SqlCommand(Query, oConn);
        oCommand.CommandType = commandType;
        if (oConn.State == ConnectionState.Closed)
            oConn.Open();
        return oCommand.ExecuteNonQuery();
    }

    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

    }

    protected void cmdCheck_Click(object sender, EventArgs e)
    {
        ParseFile(Session["UploadTempFile"].ToString(), cmbType.SelectedItem.Value);
        GenerateUploadFileName();
        cmbType.SelectedIndex = 0;
    }

    protected void cmdClear_Click(object sender, EventArgs e)
    {
        cmbType.SelectedIndex = 0;
        int Rows = RunNonQuery("DELETE FROM Temp_NPSB_ITCL_DisputeData WHERE EmpID = '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);
        TrustControl1.ClientMsg("All Data Deleted (" + Rows + " Rows)");
    }

    private static string DoubleToLongString(double x)
    {
        int shift = (int)Math.Log10(x);
        if (Math.Abs(shift) <= 2)
        {
            return x.ToString();
        }

        if (shift < 0)
        {
            double y = x * Math.Pow(10, -shift);
            return "0.".PadRight(-shift + 2, '0') + y.ToString().Substring(2);
        }
        else
        {
            double y = x * Math.Pow(10, 2 - shift);
            return y + "".PadRight(shift - 2, '0');
        }
    }

    private void ParseFile(string FileName, string Type)
    {

        if (Type == "NPSB")
        {
            string XmlFileContent = File.ReadAllText(FileName);
            //XmlFileContent = XmlFileContent.Replace("xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"", "").Replace("xmlns=\"http://tempuri.org/sdnList.xsd\"", "");


            XmlDocument xDoc = new XmlDocument();
            xDoc.LoadXml(XmlFileContent);

            XmlNodeList xNodeList = xDoc.SelectNodes("DocFile/child::node()");

            //string SDNMainID = string.Empty;
            //int SDNID = 0;

            //FileInfo FI = new FileInfo(FileName);
            //string _FileName = FI.Name;
            string _FileName = "NPSB";

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
                            SqlDataAdapter adapt = new SqlDataAdapter("s_NPSB_ITCL_Dispute_UploadData", con);
                            adapt.SelectCommand.CommandType = CommandType.StoredProcedure;                            
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_RRN", SqlDbType.VarChar, 30)).Value = Parm_RRN.Trim();                            
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@LocalDt", SqlDbType.DateTime)).Value = LocalDt;
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@D_ContractNumber", SqlDbType.VarChar, 100)).Value = D_ContractNumber.Trim();
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@Trans_Amount", SqlDbType.VarChar, 100)).Value = Trans_Amount.Trim();

                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@Approval_Code", SqlDbType.VarChar, 100)).Value = Parm_AuthCode.Trim();
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@Terminal_Identifier", SqlDbType.VarChar, 100)).Value = ContractNumber.Trim();

                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@FileName", SqlDbType.VarChar, 255)).Value = _FileName.Trim();
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@EmpID", SqlDbType.VarChar, 20)).Value = Session["EMPID"].ToString();
                            //adapt.SelectCommand.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar, 100)).Value = HidPageID.Value;                            
                            DataTable dt = new DataTable();
                            adapt.Fill(dt);
                            

                        }
                        catch (Exception ex) { }
                        Parm_RRN = null; LocalDt = new DateTime(); D_ContractNumber = null; Trans_Amount = null; Parm_AuthCode = null; ContractNumber = null;

                    }   //Individual Doc End.......


                }  //DocList End............            
            }
            //FormatVersion = null; Sender = null; CreationDate = new DateTime(); CreationTime = null; FileSeqNumber = null; Receiver = null;

            //cmdSaveData.Visible = true;

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

        else if (Type == "NPSB_ITCL")
        {
            try
            {
                StringBuilder sb;
                StreamReader reader = new StreamReader(FileName);
                sb = new StringBuilder();
                string Line = string.Empty;
                string _FileName = "ITCL_NPSB";
                //int TotalRows = 0;
                DateTime Transaction_date = new DateTime();

                while (reader.Peek() >= 0)
                {
                    Line = reader.ReadLine();

                    if (Line.StartsWith("|0") || Line.StartsWith("|1") || Line.StartsWith("|2")) {
                        String L = Line;                        
                        string[] strArray = L.Split('|');                        
                        //Transaction_date = strArray[2].ToString();
                        Transaction_date = DateTime.Parse(strArray[2].ToString());
                        //Transaction_date = DateTime.strArray[2].ToString();
                        string Card_No = strArray[3].ToString();
                        //string Account_No = strArray[4].ToString();
                        string RRN = strArray[10].ToString();
                        string Terminal_Identifier = strArray[6].ToString();
                        string Approval_Code = strArray[11].ToString();

                        //string Transaction_Amount = strArray[12].ToString();
                        //Transaction_Amount = Transaction_Amount.Replace(",","");
                        string Transaction_Amount = strArray[12].ToString().Replace(",","");

                        try
                        {
                            string constr = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ToString();
                            SqlConnection con = new SqlConnection(constr);
                            SqlDataAdapter adapt = new SqlDataAdapter("s_NPSB_ITCL_Dispute_UploadData", con);
                            adapt.SelectCommand.CommandType = CommandType.StoredProcedure;
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@Parm_RRN", SqlDbType.VarChar, 30)).Value = RRN.Trim();
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@LocalDt", SqlDbType.DateTime)).Value = Transaction_date;
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@D_ContractNumber", SqlDbType.VarChar, 100)).Value = Card_No.Trim();
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@Trans_Amount", SqlDbType.VarChar, 100)).Value = Transaction_Amount.Trim();

                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@Terminal_Identifier", SqlDbType.VarChar, 100)).Value = Terminal_Identifier.Trim();
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@Approval_Code", SqlDbType.VarChar, 100)).Value = Approval_Code.Trim();

                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@FileName", SqlDbType.VarChar, 255)).Value = _FileName.Trim();
                            adapt.SelectCommand.Parameters.Add(new SqlParameter("@EmpID", SqlDbType.VarChar, 20)).Value = Session["EMPID"].ToString();
                            DataTable dt = new DataTable();
                            adapt.Fill(dt);


                        }
                        catch (Exception ex) { }
                        RRN = null; Transaction_date = new DateTime(); Card_No = null; Transaction_Amount = null; Terminal_Identifier = null; Approval_Code = null;

                    }
                    

                   
                }
                reader.Close();
                
            }
            catch (Exception) { }
        }

        //string Line = string.Empty;

        //StringBuilder sb;
        //StreamReader reader = new StreamReader(FileName);
        //sb = new StringBuilder();

        //bool ProceedLine = false;
        //bool ProceedLine1 = false;
        //string CardNo = string.Empty;
        //DateTime DT;
        //double Amount = 0;
        //string Status = string.Empty;
        //int RowCount = 0;
        //string TRNDATE = "";


        //{
        //    int LineNo = 0;

        //    while (!reader.EndOfStream)
        //    {
        //        try
        //        {
        //            Line = reader.ReadLine();
        //            LineNo++;

        //            if (LineNo == 6613)
        //            {
        //            }

        //            if (Type == "ITCL")
        //            {
        //                try
        //                {
        //                    DT = DateTime.ParseExact(Line.Substring(9, 17), "dd/MM/yy H:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
        //                    CardNo = (Line.Substring(93, 20)).Trim();
        //                    if (CardNo == "4181290000891457")
        //                    {
        //                    }
        //                    if ((Line.Substring(113, 14).Trim()) != "")
        //                    {
        //                        Amount = double.Parse(Line.Substring(113, 14));
        //                        Status = "CR";
        //                    }
        //                    else if ((Line.Substring(128, 14).Trim()) != "")
        //                    {
        //                        Amount = double.Parse(Line.Substring(128, 14));
        //                        Status = "DR";
        //                    }
        //                    if (Amount > 9)
        //                    {
        //                        InsertTempDisputeCheck(Type, Line, CardNo, DT, Amount, Status);
        //                        RowCount++;
        //                    }
        //                }
        //                catch (Exception ex) { }
        //            }
        //            else if (Type == "OMNIBUS")
        //            {
        //                if (Line.StartsWith("Issuer: QCASH") || Line.StartsWith("Issuer: 463767"))
        //                {
        //                    ProceedLine = !ProceedLine;
        //                }
        //                if (ProceedLine)
        //                {
        //                    if (Line.StartsWith("0200 WITHDRAWAL"))
        //                    {
        //                        CardNo = (Line.Substring(16, 20)).Trim();
        //                        Amount = double.Parse(Line.Substring(37, 16));
        //                        DT = DateTime.ParseExact(Line.Substring(54, 17), "MM/dd/yy H:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
        //                        Status = (Line.Substring(106, 12)).Trim();
        //                        if (Status == "OK" || Status == "ACQ REVERSAL")
        //                        {
        //                            InsertTempDisputeCheck(Type + " R_ON_US", Line, CardNo, DT, Amount, Status);
        //                            RowCount++;
        //                        }
        //                    }
        //                }
        //                if (Line.StartsWith("Acquirer: QCASH"))
        //                {
        //                    ProceedLine1 = !ProceedLine1;
        //                }
        //                if (ProceedLine1)
        //                {
        //                    if (Line.StartsWith("0200 WITHDRAWAL"))
        //                    {
        //                        CardNo = (Line.Substring(16, 20)).Trim();
        //                        Amount = double.Parse(Line.Substring(37, 16));
        //                        DT = DateTime.ParseExact(Line.Substring(54, 17), "MM/dd/yy H:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
        //                        Status = (Line.Substring(106, 12)).Trim();
        //                        if (Status == "OK")
        //                        {
        //                            InsertTempDisputeCheck(Type + " OFF_US", Line, CardNo, DT, Amount, Status);
        //                            RowCount++;
        //                        }
        //                    }
        //                }
        //            }
        //            else if (Type == "DBBL_TXT")
        //            {
        //                string[] words = Line.Trim().Split(' ');
        //                string DateTime1 = TRNDATE;

        //                try
        //                {
        //                    TRNDATE = string.Format("{0:dd-MMM-yy}", DateTime.ParseExact(words[1].Trim(),
        //                    "dd-MMM-yy",
        //                    System.Globalization.CultureInfo.InvariantCulture));
        //                    DateTime1 = TRNDATE;
        //                }
        //                catch (Exception) { }

        //                try
        //                {
        //                    int SL = int.Parse(words[0]);
        //                }
        //                catch (Exception) { continue; }


        //                DateTime1 += "-" + words[2].Trim().PadLeft(6, '0');
        //                DT = DateTime.ParseExact(DateTime1,
        //                    "dd-MMM-yy-HHmmss",
        //                    System.Globalization.CultureInfo.InvariantCulture);

        //                CardNo = words[3].Trim();                        
        //                Amount = double.Parse(words[words.Length - 2]);
        //                Status = "OK";
        //                InsertTempDisputeCheck("DBBL" + " R_ON_US", Line.Trim(), CardNo, DT, Amount, Status);
        //                RowCount++;


        //            }
        //            else if (Type == "DBBL_OLD")
        //            {
        //                string[] words = Line.Trim().Split(' ');
        //                string DateTime1 = TRNDATE;

        //                try
        //                {
        //                    TRNDATE = string.Format("{0:dd-MMM-yyyy}", DateTime.ParseExact(Line.Trim(),
        //                    "dd-MMM-yyyy",
        //                    System.Globalization.CultureInfo.InvariantCulture));
        //                    DateTime1 = TRNDATE;
        //                }
        //                catch (Exception) { }

        //                try
        //                {
        //                    int SL = int.Parse(words[0]);
        //                }
        //                catch (Exception) { continue; }


        //                DateTime1 += "-" + words[1].Trim().PadLeft(6, '0');
        //                DT = DateTime.ParseExact(DateTime1,
        //                    "dd-MMM-yyyy-HHmmss",
        //                    System.Globalization.CultureInfo.InvariantCulture);

        //                CardNo = words[2].Trim();                        
        //                Amount = double.Parse(words[words.Length - 2]);
        //                Status = "OK";
        //                InsertTempDisputeCheck("DBBL" + " R_ON_US", Line.Trim(), CardNo, DT, Amount, Status);
        //                RowCount++;


        //            }
        //            else if (Type == "DBBL")
        //            {
        //                string[] words = Line.Trim().Split(' ');
        //                string DateTime1 = "";

        //                try
        //                {
        //                    int SL = int.Parse(words[0]);
        //                }
        //                catch (Exception) { continue; }

        //                DateTime1 = words[1].Trim() + "-" + words[2].Trim().PadLeft(6, '0');
        //                DT = DateTime.ParseExact(DateTime1,
        //                    "dd-MMM-yy-HHmmss",
        //                    System.Globalization.CultureInfo.InvariantCulture);

        //                CardNo = words[3].Trim();                        
        //                Amount = double.Parse(words[words.Length - 2]);
        //                Status = "OK";
        //                InsertTempDisputeCheck(Type + " R_ON_US", Line.Trim(), CardNo, DT, Amount, Status);
        //                RowCount++;


        //            }
        //            else if (Type == "ATM")
        //            {
        //                DT = DateTime.ParseExact(Line.Substring(12, 9), "dd-MMM-yy", System.Globalization.CultureInfo.InvariantCulture);
        //                string PrevLine = Line;
        //                CardNo = Line.Substring(24, 20).Trim();
        //                Amount = double.Parse(Line.Substring(96, 12).Trim());
        //                Status = "OK";
        //                string Account = Line.Substring(44, 20).Trim();
        //                InsertTempDisputeCheck(Type + " ON_US", PrevLine, CardNo, DT, Amount, Status, Account);
        //                RowCount++;
        //            }
        //        }
        //        catch (Exception) { }
        //    }
        //    reader.Close();
        //}
        //TrustControl1.ClientMsg(RowCount.ToString() + " Rows Saved.");
        //try
        //{
        //    File.Delete(FileName);
        //}
        //catch (Exception) { }
    }

    private void InsertTempDisputeCheck(string Type, string Line, string CardNo, DateTime DT, double Amount, string Status)
    {
        InsertTempDisputeCheck(Type, Line, CardNo, DT, Amount, Status, "");
    }
    private void InsertTempDisputeCheck(string Type, string Line, string CardNo, DateTime DT, double Amount, string Status, string Account)
    {
        try
        {
            ObjectDataSource1.InsertParameters["CardNo"].DefaultValue = CardNo.ToString();
            ObjectDataSource1.InsertParameters["DT"].DefaultValue = DT.ToString();
            ObjectDataSource1.InsertParameters["Amount"].DefaultValue = Amount.ToString();
            ObjectDataSource1.InsertParameters["Status"].DefaultValue = Status.Trim();
            ObjectDataSource1.InsertParameters["Type"].DefaultValue = Type.Trim();
            ObjectDataSource1.InsertParameters["Line"].DefaultValue = Line.Trim();
            ObjectDataSource1.InsertParameters["EMPID"].DefaultValue = Session["EMPID"].ToString();
            ObjectDataSource1.InsertParameters["Account"].DefaultValue = Account.Trim();

            ObjectDataSource1.Insert();
        }
        catch (Exception) { }
    }
    protected void txtReportDate_TextChanged(object sender, EventArgs e)
    {

    }
    protected void cmdExport_Click(object sender, EventArgs e)
    {
        string attachment = "attachment; filename=" + lblReportStatus.Text.Trim() + ".txt";
        //TrustControl1.ClientMsg(GridView1.Rows[0].Cells[1].te()); return;
        //Response.ClearContent();
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.ClearHeaders();
        HttpContext.Current.Response.ClearContent();
        HttpContext.Current.Response.AddHeader("content-disposition", attachment);
        HttpContext.Current.Response.ContentType = "application/text";
        HttpContext.Current.Response.AddHeader("Pragma", "public");

        HttpContext.Current.Response.Write(getExportText());
        HttpContext.Current.Response.End();
    }
    protected void cmdExport2_Click(object sender, EventArgs e)
    {
        string attachment = "attachment; filename=" + lblReportStatus.Text.Trim() + ".txt";
        //TrustControl1.ClientMsg(GridView1.Rows[0].Cells[1].te()); return;
        //Response.ClearContent();
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.ClearHeaders();
        HttpContext.Current.Response.ClearContent();
        HttpContext.Current.Response.AddHeader("content-disposition", attachment);
        HttpContext.Current.Response.ContentType = "application/text";
        HttpContext.Current.Response.AddHeader("Pragma", "public");

        HttpContext.Current.Response.Write(getExportText2());
        HttpContext.Current.Response.End();
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        cmdExport.Visible = !(e.AffectedRows == 0);
        cmdExport2.Visible = !(e.AffectedRows == 0);
        lblGridStatus.Text = "Total Rows: <b>" + e.AffectedRows.ToString() + "</b>";
    }
    private string getExportText()
    {
        StringBuilder csv = new StringBuilder();
        DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            csv.Append(dv.Table.Rows[i][5]);
            csv.Append(Environment.NewLine);
        }
        return csv.ToString();
    }
    private string getExportText2()
    {
        StringBuilder csv = new StringBuilder();
        DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            csv.Append(dv.Table.Rows[i][1]);
            csv.Append(",");
            csv.Append(dv.Table.Rows[i][2] + ",");
            csv.Append(",");
            csv.Append(dv.Table.Rows[i][3]);
            csv.Append(Environment.NewLine);
        }
        return csv.ToString();
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        double Amount = 0;
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            Amount += double.Parse(GridView1.Rows[i].Cells[2].Text);
        }
        if (GridView1.Rows.Count > 0)
            GridView1.FooterRow.Cells[2].Text = string.Format("{0:N2}", Amount);
    }
    protected void cmdDuplicateCheck_Click(object sender, EventArgs e)
    {
        lblReportStatus.Text = txtReportDate.Text.Replace("/", "-");
        if (dboReportType.Text == "DBBL Dispute")
            SqlDataSource1.SelectCommand = "sp_ITCL_DBBL_Dispute";
        else if (dboReportType.Text == "OMNIBUS Dispute")
            SqlDataSource1.SelectCommand = "sp_ITCL_OMNIBUS_Dispute";
        GridView1.DataBind();
    }
}