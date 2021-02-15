using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;
using OfficeOpenXml;
using System.Web;

public partial class CardMobileEmailAddressParse : System.Web.UI.Page
{


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


            SetDate_Today();
            RefreshControls();



            HidPageID.Value = string.Format("{0}_{1}", Session.SessionID, R.Next());
            HidUploadTempFile.Value = Server.MapPath("Upload/" + Session["EMPID"].ToString() + "_CardMobileEmailAddressParse_" + HidPageID.Value + ".txt");


            CleanDatabase();
        }
        //Session["SessionID"] = Session.SessionID;

        Title = "Card Mobile & Email Address Parse";
    }
    private void SetDate_Today()
    {
        TextBox1.Text = DateTime.Now.ToString("dd/MM/yyyy");
        TextBox2.Text = DateTime.Now.ToString("dd/MM/yyyy");
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RefreshControls();
    }
    private void RefreshControls()
    {
        DateTime T = DateTime.Now.Date;
        DateTime S = T;
        DateTime E = T;

        if (DropDownList1.SelectedItem.Value == "Custom Range")
        {
            DropDownList1.BackColor = System.Drawing.Color.Transparent;
            TextBox1.Enabled = true;
            TextBox2.Enabled = true;
        }
        else
        {
            DropDownList1.BackColor = System.Drawing.Color.Yellow;

            switch (DropDownList1.SelectedItem.Value)
            {
                case "Today":
                    SetDate_Today();
                    break;
                case "Yesterday":
                    S = T.AddDays(-1);
                    E = T.AddDays(-1);
                    break;
                case "This Week":
                    S = T.AddDays(-int.Parse(T.DayOfWeek.ToString("d")));
                    E = T;
                    break;
                case "Last Week":
                    S = T.AddDays(-7 - int.Parse(T.DayOfWeek.ToString("d")));
                    E = S.AddDays(6);
                    break;
                case "This Month":
                    S = T.AddDays(-T.Day + 1);
                    E = T;
                    break;
                case "Last Month":
                    S = (T.AddDays(-T.Day + 1)).AddMonths(-1);
                    E = T.AddDays(-T.Day);
                    break;
                case "This Year":
                    S = T.AddDays(-T.DayOfYear + 1);
                    E = T;
                    break;
                case "Show All":
                    S = new DateTime(1900, 1, 1);
                    E = S;
                    break;
            }

            if (S == new DateTime(1900, 1, 1))
            {
                TextBox1.Text = "";
                TextBox2.Text = "";
            }
            else
            {
                TextBox1.Text = S.ToString("dd/MM/yyyy");
                TextBox2.Text = E.ToString("dd/MM/yyyy");
            }

            RefreshLabel();

            GridView1.DataBind();

            TextBox1.Enabled = false;
            TextBox2.Enabled = false;
        }
    }
    private void RefreshLabel()
    {

    }
    private void CleanDatabase()
    {
        //RunNonQuery("EXEC sp_DeleteTempReissue '" + HidPageID.Value + "'", "CardDataConnectionString", CommandType.Text);
    }
    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

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
    bool IsValidEmail(string strIn)
    {
        // Return true if strIn is in valid e-mail format.
        return Regex.IsMatch(strIn, @"^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");
    }
    private void ParseFile(string FileName)
    {

        DataTable dt_mtr = new DataTable();
        dt_mtr.Columns.Add("SessionID", typeof(string));
        dt_mtr.Columns.Add("ClientID", typeof(string));
        dt_mtr.Columns.Add("CardHolderName", typeof(string));
        dt_mtr.Columns.Add("CardNumber", typeof(string));
        dt_mtr.Columns.Add("Mobile", typeof(string));
        dt_mtr.Columns.Add("Email", typeof(string));
     
        string ClientID;
        string CardHolderName;
        string CardNumber;
        string Mobile;
        string Email;

        string[] lines = System.IO.File.ReadAllLines(FileName);

        string[] filter_line = null;

        foreach (string line in lines)
        {
            var cols = line.Split('|');
            if (cols.Length >= 17)
            {
                Int32 dt;
                if (Int32.TryParse(cols[1].Trim().ToString(), out dt))
                {
                    ClientID = cols[1].Trim().ToString();
                    CardHolderName = cols[2].Trim().ToString();
                    CardNumber = cols[3].Trim().ToString();
                    Mobile = cols[10].Trim().ToString();
                    Email = IsValidEmail(cols[16].Trim().ToString())? cols[16].Trim().ToString():"";
                    

                    dt_mtr.Rows.Add(HidPageID.Value, ClientID, CardHolderName,
                            CardNumber, Mobile, Email);
                }
            }
        }

        if (dt_mtr.Rows.Count > 0)
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
                    bulkCopy.DestinationTableName = "TempCardMobileEmailAddress";
                    bulkCopy.WriteToServer(dt_mtr);

                }
            }
            btn_reconciliation_save.Visible = true;
            cmdUploadAgain.Visible = true;
        }
        GridView1.DataBind();
       


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

    protected void cmdUploadAgain_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/CardMobileEmailAddressParse.aspx", true);
    }

    protected void ReconciliationSave(object sender, EventArgs e)
    {
        string Msg = "";
        try
        {
            GridView1.Visible = false;
            
            string constr = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ToString();
            using ( SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("s_CardMobileEmailAddress_insert", con))
                {
                    //SqlDataAdapter adapt = new SqlDataAdapter("s_ReconciliationUpload_insert", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter session_id = new SqlParameter("SessionID", SqlDbType.VarChar, 500);
                    session_id.Value = HidPageID.Value;

                    SqlParameter sql_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    sql_Done.Direction = ParameterDirection.InputOutput;
                    sql_Done.Value = false;

                    SqlParameter sql_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                    sql_Msg.Direction = ParameterDirection.InputOutput;
                    sql_Msg.Value = Msg;

                    //SqlParameter sql_Batch = new SqlParameter("@BatchNo", SqlDbType.BigInt);
                    //sql_Batch.Direction = ParameterDirection.InputOutput;
                    //sql_Batch.Value = 0;

                    cmd.Parameters.Add(session_id);
                    cmd.Parameters.Add(sql_Done);
                    cmd.Parameters.Add(sql_Msg);
                    cmd.Parameters.AddWithValue("Emp", Session["EMpID"].ToString());
                    if (con.State == ConnectionState.Closed)
                        con.Open();

                    cmd.ExecuteNonQuery();
                    bool Done = (bool)sql_Done.Value;
                    Msg = string.Format("{0}", sql_Msg.Value);


                    if (Done)
                    {
                        TrustControl1.ClientMsg(Msg);
                        btn_reconciliation_save.Visible = false;                      
                       
                    }
                    else
                    {
                        TrustControl1.ClientMsg(Msg);
                        btn_reconciliation_save.Visible = false;
                    }
                }
            }
            GridView2.DataBind();
        }
        catch (Exception ex) { TrustControl1.ClientMsg(ex.Message); }

    }

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GridView2.SelectedRow;
        //Label lblSL = (Label)row.FindControl("lblSL");
        //hidSlNo.Value = lblSL.Text;
        string s = row.Cells[0].Text;

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
            Panel3.Visible = true;
        }
        //else if (tabContainer.ActiveTabIndex == 1)
        //    GridView1.DataBind();
    }


    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblmsg.Visible = e.AffectedRows > 0;
        lblmsg.Text = "Total Record(s):<b>" + e.AffectedRows.ToString() + "</b>";
    }

   
    private Int32 checkValue(string Value)
    {
        if (Value == "&nbsp;")
            return 0;
        else
            return Int32.Parse(Value);

    }


    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       
            
    }
}

