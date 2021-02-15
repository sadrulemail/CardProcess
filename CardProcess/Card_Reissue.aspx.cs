﻿using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public partial class Card_Reissue : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //test
        Page.Form.Attributes.Add("enctype", "multipart/form-data");
        TrustControl1.getUserRoles();
        //if (TrustControl1.getUserRoles() != "ADMIN")
        //{
        //    if (Session["DEPTID"].ToString() != "7" && Session["DEPTID"].ToString() != "90" &&  Session["DEPTID"].ToString() != "35")    //Not IT & Cards
        //    {
        //        Response.Write("No Permission.<br><br><a href=''>Home</a>");
        //        Response.End();
        //    }
        //}
        if (!Directory.Exists(Server.MapPath("Upload")))
        {
            Directory.CreateDirectory(Server.MapPath("Upload"));
        }
        //UploadTempFile = Server.MapPath("Upload/" + Session.SessionID + ".txt");

        if (!IsPostBack)
        {
            Random R = new Random(DateTime.Now.Millisecond +
                            DateTime.Now.Second * 1000 +
                            DateTime.Now.Minute * 60000 +
                            DateTime.Now.Hour * 3600000);

            HidPageID.Value = string.Format("{0}_{1}", Session.SessionID, R.Next());
            HidUploadTempFile.Value = Server.MapPath("Upload/" + Session["EMPID"].ToString() + "_Reissue_" + HidPageID.Value + ".txt");

            Panel2.Visible = false;
            CleanDatabase();
        }
        //Session["SessionID"] = Session.SessionID;

        Title = "Card Reissue Upload";
    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        string ID = e.CommandArgument.ToString();
        string Msg = "";
        bool done = false;
        string Query = "s_SMS_Send_Auto_Reissue_Card";

        if (e.CommandName == "SMSSend")
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["CardDataConnectionString"].ConnectionString;


                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@ID", System.Data.SqlDbType.VarChar, 8000).Value = ID;                    
                    cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();                   

                    SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                    SQL_Msg.Direction = ParameterDirection.InputOutput;
                    SQL_Msg.Value = Msg;
                    cmd.Parameters.Add(SQL_Msg);

                    SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    SQL_Done.Direction = ParameterDirection.InputOutput;
                    SQL_Done.Value = done;
                    cmd.Parameters.Add(SQL_Done);
                    cmd.CommandTimeout = 0;
                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();

                    done = (bool)SQL_Done.Value;
                    Msg = string.Format("{0}", SQL_Msg.Value);
                    GridView2.DataBind();
                }
            }
            if (done)
            {
                TrustControl1.ClientMsg(Msg);
                GridView2.DataBind();
            }

        }
        
        
    }

    private void CleanDatabase()
    {
        RunNonQuery("EXEC sp_DeleteTempReissue '" + HidPageID.Value + "'", "CardDataConnectionString", CommandType.Text);
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
        CleanDatabase();

        //lblUploadStatus.Text += "<br>" + FileName;
        try
        {
            StringBuilder sb;
            StreamReader reader = new StreamReader(FileName);
            sb = new StringBuilder();
            string Line = string.Empty;
            int TotalRows = 0;

            while (reader.Peek() >= 0)
            {
                Line = reader.ReadLine();
                if (Line.StartsWith("|"))
                {
                    string[] words = Line.Split("|".ToCharArray());
                    try
                    {
                        int i1 = int.Parse(words[1].Trim());
                        string AccountNo = words[5].Trim();
                        string CardNo = words[2].Trim();
                        string ITCLID = words[1].Trim();
                        string NameOnCard = words[4].Trim();
                        string Status = words[8].Trim();

                        //if (AccountNo == "0029-0310010464")
                        //{
                        //}

                        if (Status.ToUpper() != "GIVEN") continue;

                        ObjectDataSource1.InsertParameters["Account"].DefaultValue = AccountNo;
                        ObjectDataSource1.InsertParameters["CardNumber"].DefaultValue = CardNo;
                        ObjectDataSource1.InsertParameters["ITCLID"].DefaultValue = ITCLID;
                        ObjectDataSource1.InsertParameters["NameOnCard"].DefaultValue =
                            NameOnCard.Length > 19 ? NameOnCard.Substring(0, 19) : NameOnCard;
                        ObjectDataSource1.InsertParameters["Status"].DefaultValue = Status;
                        ObjectDataSource1.InsertParameters["SessionID"].DefaultValue = HidPageID.Value;
                        ObjectDataSource1.InsertParameters["InsertDT"].DefaultValue = DateTime.Now.ToString();
                        ObjectDataSource1.Insert();
                        TotalRows++;
                    }
                    catch (Exception ex) { }
                }
            }
            reader.Close();
            lblStatus.Text = "Total Rows: <b>" + TotalRows.ToString() + "</b>";
            cmdUpdate.Visible = TotalRows > 0;
            cmdUploadAgain.Visible = TotalRows == 0;
        }
        catch (Exception) { }

        Panel2.Visible = true;
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

    protected void cmdUpdate_Click(object sender, EventArgs e)
    {
        DateTime DT;
        try
        {
            DT = DateTime.ParseExact(txtDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
        }
        catch (Exception)
        {
            TrustControl1.ClientMsg("Enter correct date.");
            return;
        }

        RunNonQuery(string.Format("EXEC sp_Card_Reissue_Insert '{0}', '{1}', '{2:MM/dd/yyyy}'",
            HidPageID.Value, Session["EMPID"], DT),
            "CardDataConnectionString", CommandType.Text);
        Panel2.Visible = false;        
        TrustControl1.ClientMsg("Saved in Card Reissue List.");
        GridView2.DataBind();
        GridView1.Visible = false;
        CleanDatabase();
        cmdUploadAgain.Visible = true;
    }

    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

    }


    protected void ObjectDataSource1_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
    {

    }


    protected void cmdClearData_Click(object sender, EventArgs e)
    {
        CleanDatabase();
    }
    protected void cmdUploadAgain_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Card_Reissue.aspx", true);
    }    
}