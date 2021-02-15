﻿using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public partial class Sattlement_Upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.Attributes.Add("enctype", "multipart/form-data");
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

        Title = "Settlement File Upload/Download";
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
            string BankName = null;
            string AccountNo = null;
            string Amount = null;
            string t1 = null;
            string s1 = null;
            string s2 = null;
            string DR_CR = "";

            while (reader.Peek() >= 0)
            {
                Line = reader.ReadLine();

                if (Line.ToUpper().Trim().EndsWith("DEBIT AMOUNT"))
                    DR_CR = "Dr";
                if (Line.ToUpper().Trim().EndsWith("CREDIT AMOUNT"))
                    DR_CR = "Cr";

                if (Line.Trim().Length < 95)
                    continue;

                if (Line.EndsWith("0") || Line.EndsWith("1") || Line.EndsWith("2") || Line.EndsWith("3") || Line.EndsWith("4") || Line.EndsWith("5") || Line.EndsWith("6") || Line.EndsWith("7") || Line.EndsWith("8") || Line.EndsWith("9"))
                {
                                     

                    try
                    {
                        string[] words = Line.Split(" ".ToCharArray());
                        Amount = words[words.Length - 1].Trim();

                        int i1 = Amount.Length;
                        int i2 = Line.Length;

                        //s2 = Line.Substring(i2 - i1).Trim();
                        s1 = Line.Substring(0, i2 - i1).Trim();
                        string[] words1 = s1.Split(" ".ToCharArray());
                        AccountNo = words1[words1.Length - 1].Trim();

                        int i3 = AccountNo.Length;
                        int i4 = s1.Length;

                        BankName = Line.Substring(0, i4 - i3).Trim();
                        //BankName = s2.Trim();

                        //BankName = (Line.Substring(0, 47).Trim());
                        //AccountNo = (Line.Substring(50, 18).Trim());
                        //Amount = (Line.Substring(78, 17).Trim());
                        
                        
                        //int i1 = int.Parse(words[1].Trim());
                        //string AccountNo = words[5].Trim();
                        //string CardNo = words[2].Trim();
                        //string ITCLID = words[1].Trim();
                        //string NameOnCard = words[4].Trim();
                        //string Status = words[8].Trim();

                        //if (Status.ToUpper() != "GIVEN") continue;

                        //ObjectDataSource1.InsertParameters["Account"].DefaultValue = AccountNo;
                        //ObjectDataSource1.InsertParameters["CardNumber"].DefaultValue = CardNo;
                        //ObjectDataSource1.InsertParameters["ITCLID"].DefaultValue = ITCLID;
                        //ObjectDataSource1.InsertParameters["NameOnCard"].DefaultValue = NameOnCard;
                        //ObjectDataSource1.InsertParameters["Status"].DefaultValue = Status;
                        //ObjectDataSource1.InsertParameters["SessionID"].DefaultValue = HidPageID.Value;
                        //ObjectDataSource1.InsertParameters["InsertDT"].DefaultValue = DateTime.Now.ToString();
                        ObjectDataSource1.InsertParameters["BankName"].DefaultValue = BankName;
                        ObjectDataSource1.InsertParameters["AccountNo"].DefaultValue = AccountNo;
                        ObjectDataSource1.InsertParameters["Amount"].DefaultValue = Amount;
                        ObjectDataSource1.InsertParameters["DrCr"].DefaultValue = DR_CR;
                        ObjectDataSource1.InsertParameters["SessionID"].DefaultValue = HidPageID.Value;
                        ObjectDataSource1.Insert();
                        TotalRows++;
                    }
                    catch (Exception) { }
                }
            }
            reader.Close();
            lblStatus.Text = "Total Rows: <b>" + TotalRows.ToString() + "</b>";
            //cmdUpdate.Visible = TotalRows > 0;
            cmdUploadAgain.Visible = TotalRows == 0;
        }
        catch (Exception) { }

        Panel2.Visible = true;
        ProcessSettlementValue.Visible = true;
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

    //protected void cmdUpdate_Click(object sender, EventArgs e)
    //{
    //    DateTime DT;
    //    try
    //    {
    //        DT = DateTime.ParseExact(txtDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
    //    }
    //    catch (Exception)
    //    {
    //        TrustControl1.ClientMsg("Enter correct date.");
    //        return;
    //    }

    //    RunNonQuery(string.Format("EXEC sp_Card_Reissue_Insert '{0}', '{1}', '{2:MM/dd/yyyy}'",
    //        HidPageID.Value, Session["EMPID"], DT),
    //        "CardDataConnectionString", CommandType.Text);
    //    Panel2.Visible = false;
    //    TrustControl1.ClientMsg("Saved in Card Reissue List.");
    //    //GridView2.DataBind();
    //    GridView1.Visible = false;
    //    CleanDatabase();
    //    cmdUploadAgain.Visible = true;
    //}

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

    protected void SettlementProcess(object sender, EventArgs e)
    {
        try
        {
            GridView1.Visible = false;
            string constr = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ToString();
            SqlConnection con = new SqlConnection(constr);
            SqlDataAdapter adapt = new SqlDataAdapter("S_SettlementValueInsert", con);
            adapt.SelectCommand.CommandType = CommandType.StoredProcedure;
            //adapt.SelectCommand.Parameters.Add(new SqlParameter("@BatchID", SqlDbType.VarChar, 10)).Value = batchNo;
            adapt.SelectCommand.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar, 64)).Value = HidPageID.Value;
            adapt.SelectCommand.Parameters.Add(new SqlParameter("@InsertBy", SqlDbType.VarChar, 10)).Value = Session["EMPID"];
            //DataTable dt = new DataTable();
            DataSet dt = new DataSet();
            adapt.Fill(dt);
            //GridViewAtmValue.DataSource = dt;
            //GridViewAtmValue.DataBind();
            ProcessSettlementValue.Visible = false;

            GridView2.DataBind();

        }
        catch (Exception ex) { }
    }


    protected void DrDownload(object sender, EventArgs e)
    {
        string sFileName = System.IO.Path.GetRandomFileName();
        string sGenName = "Friendly.txt";       

        //YOu could omit these lines here as you may
        //not want to save the textfile to the server
        //I have just left them here to demonstrate that you could create the text file 
        using (System.IO.StreamWriter SW = new System.IO.StreamWriter(
               Server.MapPath("TextFiles/" + sFileName + ".txt")))
        {
            SW.WriteLine("sadat");
            SW.Close();
        }

        System.IO.FileStream fs = null;
        fs = System.IO.File.Open(Server.MapPath("TextFiles/" +
                 sFileName + ".txt"), System.IO.FileMode.Open);
        byte[] btFile = new byte[fs.Length];
        fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
        fs.Close();
        Response.AddHeader("Content-disposition", "attachment; filename=" +
                           sGenName);
        Response.ContentType = "application/octet-stream";
        Response.BinaryWrite(btFile);
        Response.End();
    }







    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GridView2.SelectedRow;
        //Label lblSL = (Label)row.FindControl("lblSL");
        //hidSlNo.Value = lblSL.Text;
        string s= row.Cells[0].Text;
    }
}