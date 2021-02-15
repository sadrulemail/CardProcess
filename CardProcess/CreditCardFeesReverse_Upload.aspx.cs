using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

public partial class CreditCardFeesReverse_Upload : System.Web.UI.Page
{

    decimal trans = 0;
    decimal comm = 0;
    decimal payment = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.Attributes.Add("enctype", "multipart/form-data");
        TrustControl1.getUserRoles();

        
        if (!Directory.Exists(Server.MapPath("Upload")))
        {
            Directory.CreateDirectory(Server.MapPath("Upload"));
        }
       

        if (!IsPostBack)
        {
            Random R = new Random(DateTime.Now.Millisecond +
                            DateTime.Now.Second * 1000 +
                            DateTime.Now.Minute * 60000 +
                            DateTime.Now.Hour * 3600000);

            
             
            


            HidPageID.Value = string.Format("{0}_{1}", Session.SessionID, R.Next());
            HidUploadTempFile.Value = Server.MapPath("Upload/" + Session["EMPID"].ToString() + "_CreditCardFeesReverse_" + HidPageID.Value + ".txt");

            
            CleanDatabase();
        }
        //Session["SessionID"] = Session.SessionID;

        Title = "Credit Card Fees Reverse Upload";
    }
   
   
   
    private void RefreshLabel()
    {

    }
    private void CleanDatabase()
    {
        //RunNonQuery("EXEC sp_DeleteTempReissue '" + HidPageID.Value + "'", "CardDataConnectionString", CommandType.Text);
    }

    protected void FileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        Session["FILENAME"] = FileUpload1.FileName.Trim();
        //lblUploadStatus.Text = "Uploaded File: " + FileUpload1.FileName;
        if (File.Exists(HidUploadTempFile.Value))
            File.Delete(HidUploadTempFile.Value);
        FileUpload1.SaveAs(HidUploadTempFile.Value);
        File.SetCreationTime(HidUploadTempFile.Value, DateTime.Now);
    }

    private void DeleteOldUploadedFiles()
    {
        string[] Files = Directory.GetFiles(Server.MapPath("Upload/"));
        foreach (string FileName in Files)
            if (File.GetCreationTime(FileName) < DateTime.Now.AddHours(-1) || FileName.Contains(Session.SessionID))
                File.Delete(FileName);
    }
    
    protected void cmdCheck_Click(object sender, EventArgs e)
    {
        Panel1.Visible = false;
        ParseFile(HidUploadTempFile.Value);
        DeleteOldUploadedFiles();


    }

    private void ParseFile(string FileName)
    {

        string Curr_CODE = ddlFileType.SelectedValue;

        //if (trans_cat == "On-Us")
        //{
        DataTable dt_mtr = new DataTable();
            dt_mtr.Columns.Add("session_id", typeof(string));
            dt_mtr.Columns.Add("posting_date", typeof(DateTime));
            dt_mtr.Columns.Add("CARD_HOLDER_NAME", typeof(string));
            dt_mtr.Columns.Add("card_no", typeof(string));
            dt_mtr.Columns.Add("BRANCH_CODE", typeof(string));
            dt_mtr.Columns.Add("ACCOUNT_NO", typeof(string));
            dt_mtr.Columns.Add("CARD_STATUS", typeof(string));
            dt_mtr.Columns.Add("CREATED_DATE", typeof(DateTime));
            dt_mtr.Columns.Add("EXPIRY_DATE", typeof(DateTime));
            dt_mtr.Columns.Add("NO_OF_POS_TXN", typeof(decimal));
            dt_mtr.Columns.Add("CARD_FEE_AMT", typeof(decimal));
            dt_mtr.Columns.Add("insert_by", typeof(string));
            dt_mtr.Columns.Add("Curr_CODE", typeof(string));
            //dt_mtr.Columns.Add("end_date", typeof(DateTime));



            string[] lines = System.IO.File.ReadAllLines(FileName);

            string[] filter_line = null;

            foreach (string line in lines)
            {
           //var cols = line.Split('|');
            var cols = line.Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries); 

        //test
        //string input = "abc][rfd][5][,][.";
        //string[] parts1 = line.Split(new string[] { "][" }, StringSplitOptions.None);

        //string[] parts11 = line.Split(new string[] { "  " }, StringSplitOptions.RemoveEmptyEntries);
        //string[] parts2 = System.Text.RegularExpressions.Regex.Split(line, @"  ");


        //end test

        DateTime dt;
            if (cols.Length > 2)
            {
                if (DateTime.TryParse(cols[0].Trim().ToString(), out dt))
                {
                    //filter_line.add
                    //var colss = line.Split(new string[] { "|" }, StringSplitOptions.None);
                    try
                    {
                        dt_mtr.Rows.Add(HidPageID.Value, cols[0].Trim(), cols[1].Trim(),
                                cols[2].Trim(), cols[3].Trim(), cols[4].Trim(), cols[5].Trim(),
                                cols[6].Trim(), cols[7].Trim(), cols[8].Trim(), cols[9].Trim(),
                                Session["EMPID"].ToString(), Curr_CODE);
                    }
                    catch (Exception ex) { TrustControl1.ClientMsg(ex.Message); }
                }
            }            
            }

            if (dt_mtr.Rows.Count > 0)
            {
                string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
            // open the destination data
            using (SqlConnection destinationConnection = new SqlConnection(oConnString))
            {
                // open the connection
                destinationConnection.Open();
                using (SqlBulkCopy bulkCopy =
                     new SqlBulkCopy(destinationConnection.ConnectionString,
                            SqlBulkCopyOptions.TableLock))
                {
                    bulkCopy.BulkCopyTimeout = 0;
                    bulkCopy.DestinationTableName = "TempCreditCardFeesReverseUpload";
                    bulkCopy.WriteToServer(dt_mtr);

                }
            }
            GridView1.DataBind();
            btn_save.Visible = true;
            }
            else
                TrustControl1.ClientMsg("Data Not Found");
       
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



    protected void cmdClearData_Click(object sender, EventArgs e)
    {
        CleanDatabase();
    }

    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

    }

    protected void cmdUploadAgain_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/CreditCardFeesReverse_Upload.aspx", true);
    }

    protected void DataSave(object sender, EventArgs e)
    {
        try
        {
            GridView1.Visible = false;
            string constr = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("s_CreditCardFeesReverseUpload_insert", con))
                {
                    //SqlDataAdapter adapt = new SqlDataAdapter("s_ReconciliationUpload_insert", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter sql_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    sql_Done.Direction = ParameterDirection.InputOutput;
                    sql_Done.Value = false;

                    SqlParameter sql_Batch = new SqlParameter("@BatchNo", SqlDbType.BigInt);
                    sql_Batch.Direction = ParameterDirection.InputOutput;
                    sql_Batch.Value = 0;

                    cmd.Parameters.AddWithValue("@session_id", HidPageID.Value);
                    
                    cmd.Parameters.Add(sql_Done);
                    
                    cmd.Parameters.Add(sql_Batch);
                    //cmd.Parameters.AddWithValue("@Remarks",txtRemarks.Text.Trim().ToString());

                    if (con.State == ConnectionState.Closed)
                        con.Open();

                    cmd.ExecuteNonQuery();
                    bool Done = (bool)sql_Done.Value;
                    Int32 Batch = Convert.ToInt32(sql_Batch.Value);
                    Response.Redirect("./CreditCardFeesReverse_Upload.aspx");
                    }
                }
            
            GridView2.DataBind();

        }
        catch (Exception ex) { TrustControl1.ClientMsg(ex.Message); }
        //Response.Redirect("ReconciliationFile_Upload.aspx");
    }
    
  
    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GridView2.SelectedRow;
        //Label lblSL = (Label)row.FindControl("lblSL");
        //hidSlNo.Value = lblSL.Text;
        string s = row.Cells[0].Text;
        
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        //GridView1.SelectedIndex = GridView1.SelectedRow;// +1;
        
    }
    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
       // GridView1.PageIndex = e.NewSelectedIndex;
        //GridView1.DataBind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView2.DataBind();

    }
    protected void SqlDataSourceDataUploadLog_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        TrustControl1.ClientMsg(string.Format("{0}", Msg));
        GridView2.DataBind();
    }
    protected void tabContainer_ActiveTabChanged(object sender, EventArgs e)
    {
        if (tabContainer.ActiveTabIndex == 1)
        {
            GridView2.DataBind();
           // Panel3.Visible = true;
        }
        //else if (tabContainer.ActiveTabIndex == 1)
        //    GridView1.DataBind();
    }
    protected void SqlDataSource3_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        
    }
}