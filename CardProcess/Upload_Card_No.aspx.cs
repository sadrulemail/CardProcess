﻿using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Ionic.Zip;
using System.Globalization;
using System.Text.RegularExpressions;

public partial class Upload_Card_No : System.Web.UI.Page
{
    string UploadTempFile;
    string UploadTempFolder;

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
        UploadTempFile = Server.MapPath("Upload/" + Session.SessionID + ".zip");
        UploadTempFolder = Path.Combine(Path.GetDirectoryName(UploadTempFile), Session.SessionID);

        if (!IsPostBack)
        {
            Panel2.Visible = false;
            Panel3.Visible = false;
            CleanDatabase();
            try
            {
                Directory.Delete(UploadTempFolder, true);
            }
            catch (Exception) { }
        }
        Session["SessionID"] = Session.SessionID;

        Title = "Upload Card No.";
    }

    private void CleanDatabase()
    {
        RunNonQuery("EXEC sp_DeleteTempImport '" + Session.SessionID + "'", "CardDataConnectionString", CommandType.Text);
    }

    protected void FileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        Session["FILENAME"] = FileUpload1.FileName.Trim();
        //lblUploadStatus.Text = "Uploaded File: " + FileUpload1.FileName;
        if (File.Exists(UploadTempFile))
            File.Delete(UploadTempFile);        
        FileUpload1.SaveAs(UploadTempFile);
        File.SetCreationTime(UploadTempFile, DateTime.Now);

        FileInfo FI = new FileInfo(UploadTempFile);

        try
        {
            ZipFile zf = new ZipFile(UploadTempFile);
            zf.ExtractAll(UploadTempFolder, ExtractExistingFileAction.OverwriteSilently);
            zf.Dispose();
        }
        catch (Exception) {
            //FileUpload1_UploadedFileError(sender, new AjaxControlToolkit.AsyncFileUploadEventArgs(AjaxControlToolkit.AsyncFileUploadState.Failed, "Invalid File", "", ""));
        }
        File.Delete(UploadTempFile);
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
        CleanDatabase();
        DirectoryInfo DI = new DirectoryInfo(UploadTempFolder);
        FileInfo [] Files = DI.GetFiles("*.txt", SearchOption.AllDirectories);
        foreach (FileInfo FI in Files)
        {
            //ParseFile(FI.FullName, int.Parse(txtAccNoColumn.Text.Trim()), int.Parse(txtCardNoColumn.Text.Trim()), int.Parse(txtItclID.Text.Trim()), int.Parse(txtCustomerNameID.Text.Trim()), int.Parse(txtStatus.Text.Trim()), int.Parse(txtEmail.Text.Trim()));
            ParseFileFinal(FI.FullName, 
                int.Parse(txtAccNoColumn.Text.Trim()), 
                int.Parse(txtCardNoColumn.Text.Trim()), 
                int.Parse(txtItclID.Text.Trim()), 
                int.Parse(txtCustomerNameID.Text.Trim()), 
                int.Parse(txtStatus.Text.Trim()), 
                int.Parse(txtEmail.Text.Trim()), 
                int.Parse(txtCreated.Text.Trim()), 
                int.Parse(txtECommStatus.Text.Trim()),
                int.Parse(txtNameOnCard.Text.Trim()),
                int.Parse(txtAddress.Text.Trim())
                );
            File.Delete(FI.FullName);
        }
        DeleteOldUploadedFiles();
    }

    private void ParseFile(string FileName, int AccNoColumn, int CardNoColumn, int ItclID, int CustomerNameColumn, int StatusColumn, int EmailColumn, int ECommerceColumn, int CreatedColumn)
    {
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
                        string AccountNo = words[AccNoColumn];
                        string CardNo = ValidCardNumber(words[CardNoColumn]);
                        string ITCLID = words[ItclID];
                        string CustomerName = words[CustomerNameColumn];
                        string Status = words[StatusColumn];
                        string Email1 = getEmail(words[EmailColumn]);
                        string ECommerce = words[ECommerceColumn];
                        string Created = words[CreatedColumn].Trim();

                        ObjectDataSource1.InsertParameters["AccountNo"].DefaultValue = AccountNo.Trim();
                        ObjectDataSource1.InsertParameters["CardNo"].DefaultValue = CardNo.Trim();
                        ObjectDataSource1.InsertParameters["ITCLID"].DefaultValue = ITCLID.Trim();
                        ObjectDataSource1.InsertParameters["CustomerName"].DefaultValue = CustomerName.Trim();
                        ObjectDataSource1.InsertParameters["Status"].DefaultValue = Status.Trim();
                        ObjectDataSource1.InsertParameters["Email1"].DefaultValue = Email1; 
                        ObjectDataSource1.InsertParameters["SessionID"].DefaultValue = Session.SessionID;
                        ObjectDataSource1.InsertParameters["InsertDT"].DefaultValue = DateTime.Now.ToString();
                        ObjectDataSource1.InsertParameters["Created"].DefaultValue = Created;
                        ObjectDataSource1.InsertParameters["ECommerce"].DefaultValue = ECommerce;
                        ObjectDataSource1.Insert();
                        TotalRows++;
                    }
                    catch (Exception) { }                    
                }
            }
            reader.Close();
            lblStatus.Text = "Total Rows: <b>" + TotalRows.ToString() + "</b>";        
        }
        catch (Exception) { }

        Panel2.Visible = true;
    }
    private string ValidCardNumber(string CardNo)
    {
        string RetVal = CardNo;

        Regex rgx = new Regex("[^0-9]");   //take only numbers 
        RetVal = rgx.Replace(RetVal, "");

        return RetVal;
    }
    private void ParseFileFinal(string FileName, int AccNoColumn, int CardNoColumn, int ItclID, int CustomerNameColumn, int StatusColumn, int EmailColumn, int CreatedColumn, int ECommColumn, int NameOnCardColumn, int AddressColumn)
    {
      

        DataSetUpload.TempImportDataTable CardData = new DataSetUpload.TempImportDataTable();


        string[] lines = System.IO.File.ReadAllLines(FileName);

        foreach (string line in lines)
        {
            var cols = line.Split('|');
            int dt;
            if (cols.Length > 5)
            {
                if (int.TryParse(cols[1].Trim().ToString(), out dt))
                {
                    //filter_line.add
                    var colss = line.Split(new string[] { "|" }, StringSplitOptions.RemoveEmptyEntries);
                    DataSetUpload.TempImportRow oRow = CardData.NewTempImportRow();

                    oRow.AccountNo = colss[AccNoColumn - 1].ToString().Trim();
                    oRow.CardNo = ValidCardNumber(colss[CardNoColumn - 1].ToString().Trim());
                    oRow.ITCLID = colss[ItclID - 1].ToString().Trim();
                    oRow.CustomerName = colss[CustomerNameColumn - 1].ToString().Trim();
                    oRow.Status = colss[StatusColumn - 1].ToString().Trim();

                    if (isEmailAddress(colss[EmailColumn - 1].ToString().Trim()))
                        oRow.Email1 = colss[EmailColumn - 1].ToString().Trim();
                    else
                        oRow.Email1 = null;

                    oRow.SessionID = Session.SessionID.ToString();
                    oRow.InsertDT = DateTime.Now;
                    oRow.ECommerce = colss[ECommColumn - 1].ToString().Trim();
                    //DateTime DT;
                    //oRow.CREATED = DateTime.ParseExact(colss[CreatedColumn - 1].ToString().Trim(), "dd-MMM-yyyy", CultureInfo.InvariantCulture);
                    oRow.CREATED = DateTime.Parse(colss[CreatedColumn - 1].ToString().Trim());
                    oRow.NameOnCard = colss[NameOnCardColumn - 1].ToString().Trim();
                    oRow.Address = colss[AddressColumn - 1].ToString().Trim();


                    CardData.Rows.Add(oRow);
                      
                }
            }
        }       

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
                bulkCopy.DestinationTableName = "TempImport";
                bulkCopy.WriteToServer(CardData);

            }
        }

        Panel2.Visible = true;
    }


    private bool isEmailAddress(string emailAddress)
    {
        //string patternLenient = @"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*";
        //Regex reLenient = new Regex(patternLenient);

        string patternStrict = @"^(([^<>()[\]\\.,;:\s@\""]+"
              + @"(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@"
              + @"((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
              + @"\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+"
              + @"[a-zA-Z]{2,}))$";
        Regex reStrict = new Regex(patternStrict);

        //bool isLenientMatch = reLenient.IsMatch(emailAddress);
        //return isLenientMatch;

        bool isStrictMatch = reStrict.IsMatch(emailAddress);
        return isStrictMatch;
    }

    private void RunNonQuery(string Query, string ConnectionStringsName, CommandType commandType)
    {
        string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings[ConnectionStringsName].ConnectionString;
        SqlConnection oConn = new SqlConnection(oConnString);        

        SqlCommand oCommand = new SqlCommand(Query, oConn);
        oCommand.CommandType = commandType;
        oCommand.CommandTimeout = 0;
        if (oConn.State == ConnectionState.Closed)
            oConn.Open();        
        oCommand.ExecuteNonQuery();
    }

    protected void cmdUpdate_Click(object sender, EventArgs e)
    {
        RunNonQuery("EXEC sp_Update_CardNumber_from_TempImport '" + Session.SessionID + "','" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);
        Panel2.Visible = false;
        Panel3.Visible = false;
        TrustControl1.ClientMsg("Updated in Card Process Database");
        GridView2.DataBind();
        CleanDatabase();
    }

    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

    }

    protected void cmdCheckFlat_Click(object sender, EventArgs e)
    {
        Panel1.Visible = false;
        ParseFile(UploadTempFile);
        DeleteOldUploadedFiles();
    }

    private void ParseFile(string FileName)
    {
        return;
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
                long ITCLID = 0;
                try
                {
                    ITCLID = long.Parse(Line.Substring(0, 10));
                    if (ITCLID == 153120)
                    {
                    }
                    string CustomerName = Line.Substring(10, 40);
                    string CardNo = Line.Substring(71, 20);
                    string CardStatus = Line.Substring(92, 15);
                    string AccountNo = Line.Substring(137, 20);
                    string[] sss = Line.Trim().Split(' ');
                    string CREATED = sss[sss.Length - 1];
                    //string ECommerce = sss[];
                        //Line.Trim().pli .Substring(242, 9);

                    try
                    {                      

                        ObjectDataSource1.InsertParameters["AccountNo"].DefaultValue = AccountNo.Trim();
                        ObjectDataSource1.InsertParameters["CardNo"].DefaultValue = CardNo.Trim();
                        ObjectDataSource1.InsertParameters["ITCLID"].DefaultValue = ITCLID.ToString();
                        ObjectDataSource1.InsertParameters["CustomerName"].DefaultValue = CustomerName.Trim();
                        ObjectDataSource1.InsertParameters["CREATED"].DefaultValue = CREATED;
                        ObjectDataSource1.InsertParameters["Status"].DefaultValue = CardStatus.Trim();
                        ObjectDataSource1.InsertParameters["SessionID"].DefaultValue = Session.SessionID;
                        ObjectDataSource1.InsertParameters["InsertDT"].DefaultValue = DateTime.Now.ToString();
                        //ObjectDataSource1.InsertParameters["ECommerce"].DefaultValue = ECommerce;

                        try
                        {
                            string s = AccountNo.Replace("-", "");
                            long acc = long.Parse(s);

                            if (AccountNo.Substring(4, 1) == "-")
                            {
                                ObjectDataSource1.Insert();
                                TotalRows++;
                            }
                        }
                        catch (Exception) { }
                    }
                    catch (Exception) { }
                }
                catch(Exception){}           
            }
            reader.Close();
            lblStatus.Text = "Total Rows: <b>" + TotalRows.ToString() + "</b>";
        }
        catch (Exception) { }

        Panel3.Visible = true;
    }

    protected void ObjectDataSource1_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
    {
        
    }

    private string getEmail(string Email)
    {
        if (TrustControl1.isEmailAddress(Email.Trim()))
            return Email.Trim().ToLower();
        else 
            return "";
    }

    protected void cmdUpdate0_Click(object sender, EventArgs e)
    {
        RunNonQuery("EXEC sp_Update_CardNumber_from_TempImport_Flat_File '" + Session.SessionID + "','" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);
        Panel2.Visible = false;
        Panel3.Visible = false;
        TrustControl1.ClientMsg("Updated in Old Card Database");
        CleanDatabase();
        GridView2.DataBind();
    }

    protected void cmdClearData_Click(object sender, EventArgs e)
    {
        CleanDatabase();
    }
}