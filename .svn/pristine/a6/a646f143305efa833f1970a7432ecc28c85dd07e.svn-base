using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public partial class Upload_Email : System.Web.UI.Page
{
    string UploadTempFile;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (TrustControl1.getUserRoles() != "ADMIN")
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
        UploadTempFile = Server.MapPath("Upload/" + Session["EMPID"].ToString() + "_Upload_Email");

        if (!IsPostBack)
        {
            Panel2.Visible = false;
            RunNonQuery("DELETE FROM TempCardEmail WHERE EmpID = '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);
        }
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
        ParseFile(UploadTempFile);
        GridView1.DataBind();
        if (GridView1.Rows.Count == 0)
        {
            cmdUpdate.Visible = false;
            lblStatus.Text = "No Email Found.";
        }
        else
        {
            lblStatus.Text = "Total Email Found: " + GridView1.Rows.Count.ToString();
        }
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

    private void ParseFile(string FileName)
    {
        RunNonQuery("DELETE FROM TempCardEmail WHERE EmpID = '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);

        //lblUploadStatus.Text += "<br>" + FileName;
        try
        {
            StringBuilder sb;
            StreamReader reader = new StreamReader(FileName);
            sb = new StringBuilder();
            string Line = string.Empty;
            int CardNumberCol = -1;
            int Email1Col = -1;

            while (reader.Peek() >= 0)
            {
                Line = reader.ReadLine();
                if (Line.StartsWith("|"))
                {                    
                    string[] words = Line.Split("|".ToCharArray());                    
                    
                    if (Line.StartsWith("|CLIENT_ID"))
                    {
                        for (int i = 0; i < words.Length; i++)
                            words[i] = words[i].Trim().ToUpper();

                        CardNumberCol = Array.IndexOf(words, "CARD NO");
                        Email1Col = Array.IndexOf(words, "E-MAIL");
                    }


                    try
                    {
                        int Client_ID = int.Parse(words[1].Trim());                        
                        string CardNumber = words[CardNumberCol].Trim();
                        string Email1 = words[Email1Col].Trim().ToLower();
                        

                        if (TrustControl1.isEmailAddress(Email1))
                        {
                            ObjectDataSource1.InsertParameters["Client_ID"].DefaultValue = Client_ID.ToString();
                            ObjectDataSource1.InsertParameters["CardNumber"].DefaultValue = CardNumber;
                            ObjectDataSource1.InsertParameters["Email1"].DefaultValue = Email1;
                            ObjectDataSource1.InsertParameters["EmpID"].DefaultValue = Session["EMPID"].ToString();                            

                            ObjectDataSource1.Insert();
                        }
                    }
                    catch (Exception) { }
                }
            }
            reader.Close();
        }
        catch (Exception) { }

        Panel2.Visible = true;
    }

    protected void cmdUpdate_Click(object sender, EventArgs e)
    {
        RunNonQuery("exec sp_sp_CardProcess_Update_CardEmail_from_TempCardEmail  '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);
        cmdUpdate.Enabled = false;
        TrustControl1.ClientMsg("Updated Successfully.");
    }

    protected void cmdEmailBulkSave_Click(object sender, EventArgs e)
    {
        string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["Report_DBConnectionString"].ConnectionString;
        SqlConnection oConn = new SqlConnection(oConnString);
        if (oConn.State == ConnectionState.Closed) oConn.Open();

        SqlCommand oCommand = new SqlCommand("sp_Emails_Add", oConn);
        oCommand.CommandType = CommandType.StoredProcedure;

        SqlParameter sql_Emails = new SqlParameter("Emails", SqlDbType.VarChar);
        sql_Emails.Value = txtEmails.Text.Replace("\n", ",");


        SqlParameter sql_TotalFound = new SqlParameter("@TotalFound", SqlDbType.Int);
        sql_TotalFound.Direction = ParameterDirection.Output;

        SqlParameter sql_TotalInsert = new SqlParameter("@TotalInsert", SqlDbType.Int);
        sql_TotalInsert.Direction = ParameterDirection.Output;

        oCommand.Parameters.Add(sql_Emails);
        oCommand.Parameters.Add(sql_TotalFound);
        oCommand.Parameters.Add(sql_TotalInsert);
        oCommand.Parameters.AddWithValue("@GroupID", dboGroup.SelectedItem.Value);


        oCommand.ExecuteNonQuery();

        lblBulkStatus.Text = string.Format("<br />Email Found: <b>{0}</b><br />Total Saved: <b>{1}</b>"
            , sql_TotalFound.Value
            , sql_TotalInsert.Value);        
    }
}