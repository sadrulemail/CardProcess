using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public partial class Forwarding2 : System.Web.UI.Page
{
    string UploadTempFile;    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (TrustControl1.getUserRoles() != "ADMIN")
        {
            //if (Session["DEPTID"].ToString() != "7")    //Not IT & Cards
            //{
            //    Response.Write("No Permission.<br><br><a href=''>Home</a>");
            //    Response.End();
            //}
        }
        if (!Directory.Exists(Server.MapPath("Upload")))
        {
            Directory.CreateDirectory(Server.MapPath("Upload"));
        }
        UploadTempFile = Server.MapPath("Upload/" + Session["EMPID"].ToString() + "_Forwarding2.txt");

        if (!IsPostBack)
        {
            Panel2.Visible = false;

            Random R = new Random(DateTime.Now.Millisecond +
                            DateTime.Now.Second * 1000 +
                            DateTime.Now.Minute * 60000 +
                            DateTime.Now.Hour * 3600000);

            HidPageID.Value = string.Format("{0}_{1}", Session.SessionID, R.Next());
            HidUploadTempFile.Value = Server.MapPath("Upload/" + Session["EMPID"].ToString() + "_TempFwd_" + HidPageID.Value + ".txt");

            Panel2.Visible = false;
            CleanDatabase();
        }

        Title = "Forwarding Letters & Card Mailers";

       
    }
    private void CleanDatabase()
    {
        RunNonQuery("exec dbo.s_TempForwarding_Delete '" + HidPageID.Value + "'", "CardDataConnectionString", CommandType.Text);
    }
    protected void FileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        Session["FILENAME"] = FileUpload1.FileName.Trim();
        //lblUploadStatus.Text = "Uploaded File: " + FileUpload1.FileName;
        if (File.Exists(UploadTempFile))
            File.Delete(UploadTempFile);
        FileUpload1.SaveAs(UploadTempFile);
    }
    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

    }
    protected void cmdCheck_Click(object sender, EventArgs e)
    {
        Panel1.Visible = false;
        ParseFile(UploadTempFile, CardType.Debit);
        hidCardType.Value = CardType.Debit.ToString();
        //GridView1.DataBind();
        //GridViewDeliveryBranchCodeMissing.DataBind();
        //if (GridView1.Rows.Count == 0)
        //{
        //    cmdUpdate.Visible = false;
        //    lblStatus.Text = "No Embossed Card Found.";
        //}
        //else
        //{
        //    //RunNonQuery("EXEC sp_Update_CardNumber_from_TempForwarding '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);    
        //}
    }
    private void RunNonQuery(string Query, string ConnectionStringsName, CommandType commandType)
    {
        string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings[ConnectionStringsName].ConnectionString;
        SqlConnection oConn = new SqlConnection(oConnString);

        SqlCommand oCommand = new SqlCommand(Query, oConn);
        oCommand.CommandTimeout = 0;
        oCommand.CommandType = commandType;
        if (oConn.State == ConnectionState.Closed)
            oConn.Open();
        oCommand.ExecuteNonQuery();
    }
    private void ParseFile(string FileName, CardType cardType)
    {
        CleanDatabase();

        DataTable DT = new DataTable();


        DataColumn dc_CardNo = new DataColumn();
        dc_CardNo.ColumnName = "CardNo";
        dc_CardNo.DataType = typeof(string);
        DT.Columns.Add(dc_CardNo);

        //DT.Columns.Add("CardNo", typeof(string));
        DT.Columns.Add("CustomerName", typeof(string));
        //DT.Columns.Add("AccountNo", typeof(string));

        DataColumn dc_AccountNo = new DataColumn();
        dc_AccountNo.ColumnName = "AccountNo";
        dc_AccountNo.DataType = typeof(string);
        DT.Columns.Add(dc_AccountNo);

        DT.Columns.Add("DeleveryBranch", typeof(Int32));
        DT.Columns.Add("CardStatus", typeof(string));
        DT.Columns.Add("EmpID", typeof(string));
        DT.Columns.Add("ITCLID", typeof(string));
        DT.Columns.Add("CreateDT", typeof(DateTime));
        DT.Columns.Add("DeliveryOverwrite", typeof(Int32));
        DT.Columns.Add("DeliveryRef", typeof(string));
        DT.Columns.Add("CustomerAddress", typeof(string));
        DT.Columns.Add("SessionID", typeof(string));
        DT.Columns.Add("NameOnCard", typeof(string));

        DT.PrimaryKey = new DataColumn[] { dc_CardNo, dc_AccountNo };

        //RunNonQuery("DELETE FROM TempForwarding WHERE EmpID = '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);

        //lblUploadStatus.Text += "<br>" + FileName;
        try
        {
            StringBuilder sb;
            StreamReader reader = new StreamReader(FileName);
            sb = new StringBuilder();
            string Line = string.Empty;

            while (reader.Peek() >= 0)
            {
                Line = reader.ReadLine();
                if (Line.StartsWith("|"))
                {
                    //ITCL Piped File
                    string[] words = Line.Split("|".ToCharArray());
                    try
                    {
                        int i1 = int.Parse(words[1].Trim());
                        string CardNo = words[4].Trim();
                        string CustomerName = words[2].Trim();
                        string AccountNo = words[8].Trim();
                        string CardStatus = words[7].Trim();         
                        int? DeleveryBranch = null;
                        string NameOnCard = words[3].Trim();
                        int ITCLID = int.Parse(words[1].Trim());
                        DateTime CreateDT = DateTime.Parse(words[10].Trim());

                        if (cardType == CardType.Debit)
                            DeleveryBranch = int.Parse((AccountNo.Split("-".ToCharArray()))[0]);    //Branch Code from A/C

                        if (cardType == CardType.Credit && AccountNo.Contains("-"))
                            continue;
                            
                        string CustomerAddress = words[9].Trim();
                        int? DeliveryOverwrite = null;

                        try
                        {
                            if (words[13].Trim() != "")
                                DeliveryOverwrite = int.Parse(words[13].Trim());

                            if (cardType == CardType.Credit)
                                DeleveryBranch = DeliveryOverwrite;
                        }
                        catch (Exception) { }

                        if (CardStatus == "Embossed")
                        {
                            DT.Rows.Add(
                                CardNo.Trim(),
                                CustomerName.Trim(),
                                AccountNo.Trim(),
                                DeleveryBranch,
                                CardStatus.Trim(),
                                Session["EMPID"].ToString(),
                                ITCLID,
                                CreateDT,
                                DeliveryOverwrite,
                                "",
                                CustomerAddress.Replace(" ,", ",").Replace(",", ", ").Replace("  ", " "),
                                HidPageID.Value,
                                NameOnCard.Trim()
                                );

                            //ObjectDataSource1.InsertParameters["AccountNo"].DefaultValue = AccountNo.Trim();
                            //ObjectDataSource1.InsertParameters["CardNo"].DefaultValue = CardNo.Trim();
                            //ObjectDataSource1.InsertParameters["CustomerName"].DefaultValue = CustomerName.Trim();
                            //ObjectDataSource1.InsertParameters["EmpID"].DefaultValue = Session["EMPID"].ToString();
                            //ObjectDataSource1.InsertParameters["DeleveryBranch"].DefaultValue = DeleveryBranch.ToString();
                            //ObjectDataSource1.InsertParameters["CardStatus"].DefaultValue = CardStatus.Trim();
                            //ObjectDataSource1.InsertParameters["ITCLID"].DefaultValue = words[1].Trim();
                            //ObjectDataSource1.InsertParameters["CreateDT"].DefaultValue = words[10].Trim();
                            //ObjectDataSource1.InsertParameters["DeliveryOverwrite"].DefaultValue = DeliveryOverwrite.ToString();
                            //ObjectDataSource1.InsertParameters["CustomerAddress"].DefaultValue = CustomerAddress.Replace(" ,", ",").Replace(",", ", ").Replace("  ", " ");
                            //ObjectDataSource1.InsertParameters["SessionID"].DefaultValue = HidPageID.Value;
                            //ObjectDataSource1.InsertParameters["NameOnCard"].DefaultValue = NameOnCard;

                            //ObjectDataSource1.Insert();
                        }
                    }
                    catch (Exception ex) { }
                }
                else
                {
                    //ITCL Flat File
                    try
                    {
                        int CustID = int.Parse(Line.Substring(0, 10));
                        string CustomerName = Line.Substring(10, 40).Trim();
                        string CardNo = Line.Substring(72, 20).Trim();
                        string AccountNo = Line.Substring(122, 20).Trim();
                        string CustomerAddress = Line.Substring(142, 81).Trim();
                        string CardStatus = Line.Substring(112, 10);
                        int? DeliveryOverwrite = null;
                        int? DeleveryBranch = null;
                        if (cardType == CardType.Debit)
                            DeleveryBranch = int.Parse((AccountNo.Split("-".ToCharArray()))[0]);
                        if (cardType == CardType.Credit && AccountNo.Contains("-"))
                            continue;
                        try
                        {
                            if (Line.Substring(233, Line.Length - 233).Trim() != "")
                            {
                                DeliveryOverwrite = int.Parse(Line.Substring(233, Line.Length - 233));
                                //CardStatus = "OVERWRITE";
                                if (cardType == CardType.Credit)
                                    DeleveryBranch = DeliveryOverwrite;
                            }
                        }
                        catch (Exception) { }

                        //ObjectDataSource1.InsertParameters["AccountNo"].DefaultValue = AccountNo.Trim();
                        //ObjectDataSource1.InsertParameters["CardNo"].DefaultValue = CardNo.Trim();
                        //ObjectDataSource1.InsertParameters["CustomerName"].DefaultValue = CustomerName.Trim();
                        //ObjectDataSource1.InsertParameters["EmpID"].DefaultValue = Session["EMPID"].ToString();
                        //ObjectDataSource1.InsertParameters["DeleveryBranch"].DefaultValue = DeleveryBranch.ToString();
                        //ObjectDataSource1.InsertParameters["CardStatus"].DefaultValue = CardStatus.Trim();
                        //ObjectDataSource1.InsertParameters["ITCLID"].DefaultValue = CustID.ToString();
                        //ObjectDataSource1.InsertParameters["CreateDT"].DefaultValue = Line.Substring(223, 9);
                        //ObjectDataSource1.InsertParameters["DeliveryOverwrite"].DefaultValue = DeliveryOverwrite.ToString();
                        //ObjectDataSource1.InsertParameters["CustomerAddress"].DefaultValue = CustomerAddress.Replace(" ,", ",").Replace(",", ", ").Replace("  ", " ");
                        //ObjectDataSource1.InsertParameters["SessionID"].DefaultValue = HidPageID.Value;

                        //ObjectDataSource1.Insert();
                    }
                    catch (Exception) { }
                }
            }
            reader.Close();


            if (DT.Rows.Count > 0)
            {
                string connString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

                // open the destination data
                using (SqlConnection destinationConnection = new SqlConnection(connString))
                {
                    // open the connection

                    destinationConnection.Open();
                    using (SqlBulkCopy bulkCopy =
                         new SqlBulkCopy(destinationConnection.ConnectionString,
                                SqlBulkCopyOptions.TableLock))
                    {
                        bulkCopy.BulkCopyTimeout = 0;
                        bulkCopy.DestinationTableName = "TempForwarding";
                        bulkCopy.WriteToServer(DT);

                    }
                }

            }

            GridView1.DataBind();


            //Update DeliveryToBranch
            //RunNonQuery("s_TempForwarding_Update '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);
        }
        catch (Exception) { }

        Panel2.Visible = true;
    }

    protected void cmdUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            //RunNonQuery("EXEC sp_Update_CardNumber_from_TempForwarding '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);
            cmdUpdate.Visible = false;
            //PanelDeliveryBranchCodeMissing.Visible = false;
            GridView1.Visible = false;

        }
        catch (Exception ex)
        {
            TrustControl1.ClientMsg(ex.Message);
            return;
        }

        int Batch = 0;

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_Save_and_Generate_Forwarding_Letters";

            conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["CardDataConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand(Query, conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter Sql_Batch = new SqlParameter("@Batch", SqlDbType.Int);
                Sql_Batch.Direction = ParameterDirection.InputOutput;
                Sql_Batch.Value = Batch;
                cmd.Parameters.Add(Sql_Batch);

                cmd.Parameters.AddWithValue("@EmpID", Session["EMPID"].ToString());
                cmd.Parameters.AddWithValue("@SessionID", HidPageID.Value);
                cmd.Parameters.AddWithValue("@CardType", hidCardType.Value);

                cmd.Connection = conn;
                if (conn.State == ConnectionState.Closed) conn.Open();

                cmd.CommandTimeout = 0;
                cmd.ExecuteNonQuery();

                Batch = (int)Sql_Batch.Value;
            }

        }

        

        lblStatus.Text = string.Format("Forwarding Generated. Download: <a href='Forwarding.aspx?batch={0}&cardtype={1}'>Batch {0}</a>", Batch, hidCardType.Value);
            
            //Response.Redirect(string.Format("Forwarding.aspx?batch=&date=&cardtype={0}&temp={1}", 
            //    Session["cardtype"], 
            //    Session["EMPID"]),                 
            //    true);
        GridView2.DataBind();
    }
    protected void cmdCheckCreditCard_Click(object sender, EventArgs e)
    {
        Panel1.Visible = false;
        ParseFile(UploadTempFile, CardType.Credit);
        hidCardType.Value = CardType.Credit.ToString();
        GridView1.DataBind();
        if (GridView1.Rows.Count == 0)
        {
            cmdUpdate.Visible = false;
            lblStatus.Text = "No Embossed Card Found.";
        }
        else
        {
            //RunNonQuery("EXEC sp_Update_CardNumber_from_TempForwarding '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);
            lblStatus.Text = "Total Card Found: " + GridView1.Rows.Count.ToString();
        }
    }

    enum CardType
    {
        Credit,Debit
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //PanelDeliveryBranchCodeMissing.Visible = e.AffectedRows > 0;
    }
    protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //DataTable dt = (DataTable)e.ReturnValue;
        try
        {
            lblStatus.Text = string.Format("Total Card Found: {0}", e.AffectedRows);
        }
        catch (Exception) { lblStatus.Text = "No Data Found."; }
    }

    protected void SqlDataSourceForwardingLog_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        TrustControl1.ClientMsg(e.Command.Parameters["@Msg"].Value.ToString());
    }
}