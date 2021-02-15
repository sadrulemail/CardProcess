using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using OfficeOpenXml;
using Excel;
using System.Text.RegularExpressions;
using System.Configuration;

public partial class Atm_Upload : System.Web.UI.Page
{

    string RemitterName;
    string RemitterAddress;
    string BeneficiaryName;
    string BeneficiaryAddress;
    string BankName;
    string BranchName;
    string Area;
    string District;
    string Account;
    string Amount;
    string PIN;
    string Password;
    string RefOrderReceipt;
    string Contact;
    string Purpose;
    string PaymentMethod;
    string ValueDate;
    string BeneficiaryID;
    string ToBranch;
    string ExHouseCode;
    string CommentHO;
    string CommentBR;
    string RemitterAccount;
    string RemitterAccType;
    string AccountType;
    string SL;

    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Upload ATM Cashload";

        Page.Form.Attributes.Add("enctype", "multipart/form-data");
        TrustControl1.getUserRoles();

        //if (!(Session["BRANCHID"].ToString() == "1" && (TrustControl1.isRole("ADMIN")
        //    || TrustControl1.isRole("UPLOAD") || TrustControl1.isRole("ATM")))
        //    )    //Not IT & Cards
        //{
        //    Response.Write("No Permission.<br><br><a href=''>Home</a>");
        //    Response.End();
        //}

        if (!Directory.Exists(Server.MapPath("Upload")))
        {
            Directory.CreateDirectory(Server.MapPath("Upload"));
        }

        if (!IsPostBack)
        {
            //string Clear = string.Format("{0}", Request.QueryString["clear"]);
            //if (Clear == "YES")
            Random R = new Random(DateTime.Now.Millisecond +
                            DateTime.Now.Second * 1000 +
                            DateTime.Now.Minute * 60000 +
                            DateTime.Now.Hour * 3600000);

            HidPageID.Value = string.Format("{0}{1}", Session.SessionID, R.Next());

            HidUploadTempFile.Value = Server.MapPath("Upload/" + Session["EMPID"].ToString() + "_" + HidPageID.Value + ".xlsx");
            {
                CleanDatabase();
                //Response.Redirect("Upload.aspx", true);
            }

            Panel2.Visible = false;

            //GridView1.DataBind();
        }
        Session["SESSIONID"] = Session.SessionID;

        //lblUploadStatus.Text = AccountFilter("kjskj --82734897323-4987 320-;sd ");
    }

    private void CleanDatabase()
    {
        //RunNonQuery("EXEC sp_DeleteTempUpload '" + HidPageID.Value + "', '" + Session["EMPID"].ToString() + "'", "RemittanceConnectionString", CommandType.Text);
        //RunNonQuery("EXEC sp_DeleteTempUpload '" + HidPageID.Value + "', '" + Session["EMPID"].ToString() + "'", "SMSConnectionString", CommandType.Text);
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
        try
        {
            ParseFile(HidUploadTempFile.Value, int.Parse(txtWorksheet.Text));
        }
        catch (Exception ex)
        {
            lblStatus.Text = ex.Message;
        }
        DeleteOldUploadedFiles();
    }

    private void ParseFile(string FileName, int Worksheet)
    {
        CleanDatabase();
        //lblUploadStatus.Text += "<br>" + FileName;
        //try
        //{
        //    StringBuilder sb;
        //    StreamReader reader = new StreamReader(FileName);
        //    sb = new StringBuilder();
        //    string Line = string.Empty;
        //    int TotalRows = 0;

        //    while (reader.Peek() >= 0)
        //    {
        //        Line = reader.ReadLine();
        //        if (Line.StartsWith("|"))
        //        {
        //            string[] words = Line.Split("|".ToCharArray());
        //            try
        //            {                        
        //                int i1 = int.Parse(words[1].Trim());


        //                ObjectDataSource1.InsertParameters["SessionID"].DefaultValue = Session.SessionID;
        //                ObjectDataSource1.InsertParameters["InsertDT"].DefaultValue = DateTime.Now.ToString();                
        //                ObjectDataSource1.Insert();
        //                TotalRows++;
        //            }
        //            catch (Exception) { }                    
        //        }
        //    }
        //    reader.Close();
        //    lblStatus.Text = "Total Rows: <b>" + TotalRows.ToString() + "</b>";        
        //}
        //catch (Exception) { }

        //FileStream stream = File.Open(FileName, FileMode.Open, FileAccess.Read);
        ////IExcelDataReader excelReader = ExcelReaderFactory.CreateBinaryReader(stream);
        //IExcelDataReader excelReader = ExcelReaderFactory.CreateOpenXmlReader(stream);
        ////excelReader.IsFirstRowAsColumnNames = false;
        //DataSet result = excelReader.AsDataSet();

        ////5. Data Reader methods
        //while (excelReader.Read())
        //{
        //    string s = excelReader[0].ToString();
        //}

        ////6. Free resources (IExcelDataReader is IDisposable)
        //excelReader.Close();

        //ParseWorkSheet_UTL_TT();
        //return;


        FileInfo FI = new FileInfo(FileName);
        try
        {
            using (ExcelPackage package = new ExcelPackage(FI))
            {
                ExcelWorkbook workBook = package.Workbook;
                if (workBook.Worksheets.Count > 0)
                {
                    ExcelWorksheet currentWorksheet = workBook.Worksheets[Worksheet];

                    ParseCustomFormat(currentWorksheet);
                           
                    
                }
            }
            Panel1.Visible = false;
            //GridView1.Visible = true;
            cmdSaveData.Visible = true;
            GridView1.DataBind();

            //cmdUpdate.Enabled = GridView1.Rows.Count > 0;

            try
            {
                File.Delete(FileName);
            }
            catch (Exception) { }
        }
        catch (Exception)
        {
            Panel2.Visible = false;
            cmdUpdate.Visible = false;
            lblStatus.Text = "Parsing file failed. Please check your file format.";
            File.Delete(HidUploadTempFile.Value);
        }


        //Panel2.Visible = true;
        Panel2.Visible = false;
    }

    private void ParseWorkSheet_UTL_TT(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("DATE"))
                {
                    ValueDate = WS.Cells["B" + r].Value.ToString();
                }
            }
            catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SL"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    RemitterName = string.Format("{0}", WS.Cells["B" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "C" + r);
                    BankName = string.Format("{0}", WS.Cells["D" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["E" + r].Value);
                    Area = string.Format("{0}", WS.Cells["F" + r].Value);
                    District = string.Format("{0}", WS.Cells["G" + r].Value);
                    Account = getNumberFromCell(WS, "H" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["I" + r].Value);
                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = "";
                    Password = "";
                    RefOrderReceipt = "";
                    Contact = "";
                    Purpose = "";
                    PaymentMethod = "";
                    BeneficiaryID = "";
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private string getNumberFromCell(ExcelWorksheet WS, string CollumName)
    {
        try
        {
            return string.Format("{0:N0}", WS.Cells[CollumName].Value).Replace(",", "");
        }
        catch (Exception)
        {
            return string.Format("{0}", WS.Cells[CollumName].Value);
        }
    }
    private void ParseWorkSheet_UTL_IC(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToString().StartsWith("Date"))
                {
                    ValueDate = WS.Cells["B" + r].Value.ToString();
                }
            }
            catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SL"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    RemitterName = string.Format("{0}", WS.Cells["B" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "C" + r);
                    BeneficiaryAddress = string.Format("{0}", WS.Cells["D" + r].Value);
                    BeneficiaryID = string.Format("{0}", WS.Cells["E" + r].Value);
                    BankName = string.Format("{0}", WS.Cells["F" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["G" + r].Value);
                    PIN = getNumberFromCell(WS, "H" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["I" + r].Value);

                    RemitterAddress = "";
                    Area = "";
                    District = "";
                    Account = "";
                    Password = "";
                    RefOrderReceipt = "";
                    Contact = "";
                    Purpose = "";
                    PaymentMethod = "";
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }
    private void ParseWorkSheet_GULF(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                for (int c = 1; c <= WS.Dimension.End.Column; c++)
                {
                    string S = string.Format("{0}", WS.Cells[r, c].Value);
                    if (S.ToString().ToUpper().StartsWith("REPORT DATE"))
                    {
                        ValueDate = WS.Cells[r, c + 1].Value.ToString();
                    }
                }
            }
            catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SL"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    RemitterName = string.Format("{0}", WS.Cells["K" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "E" + r);
                    BeneficiaryAddress = "";
                    BeneficiaryID = "";
                    BankName = string.Format("{0}", WS.Cells["H" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["I" + r].Value);
                    PIN = "";
                    Amount = string.Format("{0:N2}", WS.Cells["D" + r].Value);

                    RemitterAddress = "";
                    Area = "";
                    District = string.Format("{0}", WS.Cells["J" + r].Value); ;
                    Account = getNumberFromCell(WS, "G" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["F" + r].Value);
                    Purpose = "";
                    PaymentMethod = "";
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }
    private void ParseWorkSheet_NEC_TT(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SERIAL NO"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    ValueDate = WS.Cells["C" + r].Value.ToString();
                    //(DateTime.ParseExact(WS.Cells["C" + r].Value.ToString(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture)).ToLongDateString();
                    RemitterName = string.Format("{0}", WS.Cells["J" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "D" + r);
                    BeneficiaryAddress = "";
                    BeneficiaryID = "";
                    BankName = string.Format("{0}", WS.Cells["E" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["F" + r].Value);
                    PIN = "";
                    Amount = string.Format("{0:N2}", WS.Cells["H" + r].Value);

                    RemitterAddress = "";
                    Area = "";
                    District = "";
                    Account = getNumberFromCell(WS, "G" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["I" + r].Value);

                    Purpose = string.Format("{0}", WS.Cells["K" + r].Value);
                    PaymentMethod = "";
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }
    private void ParseWorkSheet_NEC_IC(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SERIAL NO"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S.ToUpper().StartsWith("TEST"))
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    ValueDate = WS.Cells["C" + r].Value.ToString();
                    //(DateTime.ParseExact(WS.Cells["C" + r].Value.ToString(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture)).ToLongDateString();
                    RemitterName = string.Format("{0}", WS.Cells["K" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "D" + r);
                    BeneficiaryAddress = "";
                    BeneficiaryID = "";
                    BankName = string.Format("{0}", WS.Cells["G" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["H" + r].Value);
                    PIN = getNumberFromCell(WS, "F" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["I" + r].Value);

                    RemitterAddress = "";
                    Area = "";
                    District = "";
                    Account = getNumberFromCell(WS, "G" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["J" + r].Value);

                    Purpose = string.Format("{0}", WS.Cells["L" + r].Value);
                    PaymentMethod = string.Format("{0}", WS.Cells["E" + r].Value);
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }
    private void ParseWorkSheet_Orchid(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("DATE"))
                {
                    ValueDate = WS.Cells["B" + r].Value.ToString();
                }
            }
            catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SL"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    RemitterName = string.Format("{0}", WS.Cells["C" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "D" + r);
                    BankName = string.Format("{0}", WS.Cells["H" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["I" + r].Value);
                    Area = string.Format("{0}", WS.Cells["J" + r].Value);
                    District = "";
                    Account = getNumberFromCell(WS, "F" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["L" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = getNumberFromCell(WS, "G" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = "";
                    Purpose = "";
                    PaymentMethod = "";
                    BeneficiaryID = string.Format("{0}", WS.Cells["K" + r].Value);
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }
    private void ParseWorkSheet_Oman(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("DATE"))
                {
                    ValueDate = WS.Cells["A" + r].Value.ToString().ToUpper().Replace("DATE:", "");
                }
            }
            catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SL"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    RemitterName = string.Format("{0}", WS.Cells["I" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "C" + r);
                    BankName = string.Format("{0}", WS.Cells["E" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["F" + r].Value);
                    Area = "";
                    District = "";
                    Account = getNumberFromCell(WS, "D" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["G" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = "";
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = "";
                    Purpose = "";
                    PaymentMethod = "";
                    BeneficiaryID = "";
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }
    private void ParseWorkSheet_Oman_IC(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("DATE"))
                {
                    ValueDate = WS.Cells["A" + r].Value.ToString().ToUpper().Replace("DATE:", "");
                }
            }
            catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SL"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    RemitterName = _ExHouseCode;
                    BeneficiaryName = getNumberFromCell(WS, "E" + r);
                    BankName = "";
                    BranchName = string.Format("{0}", WS.Cells["D" + r].Value);
                    Area = "";
                    District = "";
                    Account = "";
                    Amount = string.Format("{0:N2}", WS.Cells["G" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = getNumberFromCell(WS, "C" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["F" + r].Value);
                    Purpose = "";
                    PaymentMethod = "";
                    BeneficiaryID = string.Format("{0}", WS.Cells["I" + r].Value);
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }
    private void ParseWorkSheet_Mitali(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("DATE"))
                {
                    ValueDate = WS.Cells["B" + r].Value.ToString();
                }
            }
            catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SL"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    RemitterName = string.Format("{0}", WS.Cells["B" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "C" + r);
                    BankName = string.Format("{0}", WS.Cells["G" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["H" + r].Value);
                    Area = string.Format("{0}", WS.Cells["I" + r].Value);
                    District = "";
                    Account = getNumberFromCell(WS, "E" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["K" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = getNumberFromCell(WS, "F" + r);
                    Password = "";
                    RefOrderReceipt = "";
                    Contact = "";
                    Purpose = "";
                    PaymentMethod = "";
                    BeneficiaryID = string.Format("{0}", WS.Cells["J" + r].Value);
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
        //bool isDataRow = false;
        //int iSL = 1;
        //for (int r = 1; r <= WS.Dimension.End.Row; r++)
        //{
        //    try
        //    {
        //        string S = string.Format("{0}", WS.Cells["A" + r].Value);
        //        if (S.ToUpper().StartsWith("MEX"))
        //        {
        //            //ValueDate = WS.Cells["A" + r].Value.ToString().ToUpper().Replace("  "," ").Replace("MEX / REM DT.", "");
        //            ValueDate = string.Format("{0:dd-MMM-yyyy}", DateTime.Now.Date);
        //        }
        //    }
        //    catch (Exception) { }

        //    try
        //    {
        //        string S = string.Format("{0}", WS.Cells["A" + r].Value);
        //        if (S.ToUpper().StartsWith("MEX"))
        //        {
        //            isDataRow = true;
        //            continue;
        //        }
        //        //else if (isDataRow && S == "")
        //        //    isDataRow = false;
        //    }
        //    catch (Exception) { }

        //    try
        //    {
        //        if (isDataRow)
        //        {
        //            SL = iSL.ToString();
        //            RefOrderReceipt = string.Format("{0}", WS.Cells["A" + r].Value);
        //            if (RefOrderReceipt.Length == 0) continue;

        //            iSL++;
        //            RemitterName = string.Format("{0}", WS.Cells["B" + r].Value);
        //            BeneficiaryName = getNumberFromCell(WS, "C" + r);
        //            BankName = string.Format("{0}", WS.Cells["D" + r].Value);
        //            BranchName = "";
        //            Area = "";
        //            District = "";
        //            Account = "";
        //            Amount = string.Format("{0:N2}", WS.Cells["F" + r].Value);

        //            RemitterAddress = string.Format("{0}", WS.Cells["B" + (r + 1)].Value);
        //            RemitterAddress = RemitterAddress.Trim();
        //            if (RemitterAddress.EndsWith(","))
        //                RemitterAddress = RemitterAddress.Substring(0, RemitterAddress.Length - 1);
        //            RemitterAddress += "<br>" + string.Format("{0}", WS.Cells["B" + (r + 2)].Value);

        //            BeneficiaryAddress = string.Format("{0}", WS.Cells["C" + (r + 1)].Value);
        //            BeneficiaryAddress = BeneficiaryAddress.Trim();
        //            if (BeneficiaryAddress.EndsWith(","))
        //                BeneficiaryAddress = BeneficiaryAddress.Substring(0, BeneficiaryAddress.Length - 1);
        //            BeneficiaryAddress += "<br>" + string.Format("{0}", WS.Cells["C" + (r + 2)].Value);

        //            PIN = "";
        //            Password = "";

        //            Contact = "";
        //            Purpose = "";
        //            PaymentMethod = string.Format("{0}", WS.Cells["E" + r].Value);
        //            string EE = string.Format("{0}", WS.Cells["E" + (r + 1)].Value);
        //            if (EE.Trim().Length > 0)
        //                PaymentMethod = PaymentMethod + "<br>" + EE;

        //            BeneficiaryID = "";
        //            ToBranch = "";
        //            ToBranch = getToBranchAll(ToBranch);
        //            CommentHO = "";
        //            CommentBR = "";


        //            InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
        //    }
        //}
    }

    private void ParseTrust_Ex(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                ValueDate = (DateTime.FromOADate(double.Parse(WS.Cells["A1"].Value.ToString()))).ToShortDateString();
            }
            catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("REF"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S.Trim() == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = "";
                    RemitterName = string.Format("{0}", WS.Cells["B" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "C" + r);
                    BankName = string.Format("{0}", WS.Cells["G" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["H" + r].Value);
                    Area = string.Format("{0}", WS.Cells["I" + r].Value);
                    District = "";
                    Account = getNumberFromCell(WS, "E" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["K" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = getNumberFromCell(WS, "F" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["A" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["D" + r].Value);
                    Purpose = "";
                    PaymentMethod = "";
                    BeneficiaryID = string.Format("{0}", WS.Cells["J" + r].Value);
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }

        //ValueDate = DateTime.Today.ToLongDateString();
        //bool isDataRow = false;
        //int iSL = 1;
        //for (int r = 1; r <= WS.Dimension.End.Row; r++)
        //{
        //    try
        //    {
        //        string S = string.Format("{0}", WS.Cells["A" + r].Value);
        //        if (S.ToUpper().StartsWith("RECEIPT"))
        //        {
        //            //ValueDate = "";
        //        }
        //    }
        //    catch (Exception) { }

        //    try
        //    {
        //        string S = string.Format("{0}", WS.Cells["A" + r].Value);
        //        if (S.ToUpper().StartsWith("RECEIPT"))
        //        {
        //            isDataRow = true;
        //            continue;
        //        }
        //        //else if (isDataRow && S == "")
        //        //    isDataRow = false;
        //    }
        //    catch (Exception) { }

        //    try
        //    {
        //        if (isDataRow)
        //        {
        //            SL = iSL.ToString();
        //            RefOrderReceipt = string.Format("{0}", WS.Cells["A" + r].Value);
        //            if (RefOrderReceipt.Length == 0) continue;

        //            iSL++;
        //            RemitterName = string.Format("{0}", WS.Cells["K" + r].Value);
        //            BeneficiaryName = getNumberFromCell(WS, "B" + r);
        //            BankName = "";
        //            BranchName = string.Format("{0}", WS.Cells["F" + r].Value);
        //            Area = "";
        //            District = "";
        //            Account = "";
        //            Amount = string.Format("{0:N2}", WS.Cells["D" + r].Value);

        //            RemitterAddress = string.Format("{0}", WS.Cells["L" + r].Value);
        //            RemitterAddress = RemitterAddress.Trim();                    
        //            RemitterAddress += "<br>" + string.Format("{0}", WS.Cells["M" + r].Value);

        //            BeneficiaryAddress = "";// string.Format("{0}", WS.Cells["C" + (r + 1)].Value);
        //            BeneficiaryAddress.Trim();
        //            //if (BeneficiaryAddress.Trim().EndsWith(","))
        //            //    BeneficiaryAddress = BeneficiaryAddress.Trim().Substring(0, BeneficiaryAddress.Trim().Length - 1);
        //            //BeneficiaryAddress += "<br>" + string.Format("{0}", WS.Cells["C" + (r + 2)].Value);

        //            PIN = string.Format("{0}", WS.Cells["I" + r].Value);
        //            Password = string.Format("{0}", WS.Cells["J" + r].Value);

        //            Contact = string.Format("{0}", WS.Cells["C" + r].Value);
        //            Purpose = "";
        //            PaymentMethod = string.Format("{0}", WS.Cells["E" + r].Value);
        //            //string EE = string.Format("{0}", WS.Cells["E" + (r + 1)].Value);
        //            //if (EE.Trim().Length > 0)
        //            //    PaymentMethod = PaymentMethod + "<br>" + EE;

        //            BeneficiaryID = string.Format("{0}", WS.Cells["G" + r].Value);
        //            ToBranch = "";
        //            ToBranch = getToBranchAll(ToBranch);
        //            CommentHO = "";
        //            CommentBR = "";

        //            for (int ii = 1; ii < 10; ii++)
        //            {
        //                int cellNo = (ii + r);
        //                string tmp = string.Format("{0}", WS.Cells["A" + cellNo].Value);
        //                if (tmp.Length > 0)
        //                    break;
        //                else
        //                {
        //                    tmp = string.Format("{0}", WS.Cells["B" + cellNo].Value);
        //                    if(tmp.StartsWith("AC#"))
        //                    {
        //                        Account = tmp.Replace("AC#:", "").Trim();
        //                    }
        //                    if (tmp.StartsWith("Bank"))
        //                    {
        //                        BankName = tmp.Replace("Bank:", "").Trim();
        //                    }
        //                    if (tmp.StartsWith("Branch"))
        //                    {
        //                        BranchName = tmp.Replace("Branch:", "").Trim();
        //                    }
        //                    if (tmp.StartsWith("Dist"))
        //                    {
        //                        District = tmp.Replace("Dist:", "").Trim();
        //                    }
        //                }
        //            }

        //            //Details


        //            InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
        //    }
        //}
    }
    private void ParseWorkSheet_Wsf(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        int iSL = 1;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["B" + r].Value).ToUpper();
                if (S.ToUpper().StartsWith("TEST"))
                {
                    string D = WS.Cells["B" + r].Value.ToString().ToUpper().Replace("TEST", "");
                    D = D.Replace(":", "");
                    D = D.Substring(D.IndexOf("DATED", 0), 18);
                    D = D.Replace("DATED", "").Trim();
                    ValueDate = D;
                }
            }
            catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("ORDER"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = iSL.ToString();
                    iSL++;
                    RemitterName = string.Format("{0}", WS.Cells["I" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "C" + r);
                    BankName = string.Format("{0}", WS.Cells["E" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["F" + r].Value);
                    Area = "";
                    District = string.Format("{0}", WS.Cells["K" + r].Value);
                    Account = "";
                    Amount = string.Format("{0:N2}", WS.Cells["H" + r].Value);

                    RemitterAddress = string.Format("TT Serial No. {0}", WS.Cells["B" + r].Value);
                    BeneficiaryAddress = "";
                    PIN = "";
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["A" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["J" + r].Value);
                    Purpose = "";
                    PaymentMethod = string.Format("{0}", WS.Cells["D" + r].Value);
                    BeneficiaryID = "";
                    ToBranch = "";
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private void ParseWorkSheet_Wsf_SMA(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        int iSL = 1;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            //try
            //{
            //    string S = string.Format("{0}", WS.Cells["B" + r].Value).ToUpper();
            //    if (S.ToUpper().StartsWith("TEST"))
            //    {
            //        string D = WS.Cells["B" + r].Value.ToString().ToUpper().Replace("TEST", "");
            //        D = D.Replace(":", "");
            //        D = D.Substring(D.IndexOf("DATED", 0), 18);
            //        D = D.Replace("DATED", "").Trim();
            //        ValueDate = D;
            //    }
            //}
            //catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("ORDER"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = iSL.ToString();
                    iSL++;
                    RemitterName = string.Format("{0}", WS.Cells["I" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "E" + r);
                    BankName = string.Format("{0}", WS.Cells["G" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["H" + r].Value);
                    ValueDate = DateTime.FromOADate((double)WS.Cells["C" + r].Value).ToString();
                    Area = "";
                    District = string.Format("{0}", WS.Cells["K" + r].Value);
                    if (!(string.Format("{0}", WS.Cells["F" + r].Value)).ToUpper().Trim().StartsWith("CASH"))
                    {
                        Account = getNumberFromCell(WS, "F" + r);
                        PaymentMethod = "";
                    }
                    else
                    {
                        Account = "";
                        PaymentMethod = "IC";
                    }
                    Amount = string.Format("{0:N2}", WS.Cells["D" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = getNumberFromCell(WS, "A" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["J" + r].Value);
                    Purpose = "";

                    BeneficiaryID = "";
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private void ParseWorkSheet_Nmt_TT(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        int iSL = 1;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            //try
            //{
            //    string S = string.Format("{0}", WS.Cells["B" + r].Value).ToUpper();
            //    if (S.ToUpper().StartsWith("TEST"))
            //    {
            //        string D = WS.Cells["B" + r].Value.ToString().ToUpper().Replace("TEST", "");
            //        D = D.Replace(":", "");
            //        D = D.Substring(D.IndexOf("DATED", 0), 18);
            //        D = D.Replace("DATED", "").Trim();
            //        ValueDate = D;
            //    }
            //}
            //catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SERIAL"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    ValueDate = WS.Cells["C" + r].Value.ToString();//(DateTime.ParseExact(WS.Cells["C" + r].Value.ToString(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture)).ToLongDateString();
                    RemitterName = string.Format("{0}", WS.Cells["J" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "D" + r);
                    BankName = string.Format("{0}", WS.Cells["E" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["F" + r].Value);
                    Area = "";
                    District = "";
                    Account = getNumberFromCell(WS, "G" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["H" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = "";
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["I" + r].Value);
                    Purpose = string.Format("{0}", WS.Cells["K" + r].Value);
                    PaymentMethod = "";
                    BeneficiaryID = "";
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private void ParseCITY_Ex(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        int iSL = 1;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {

            string VD = string.Format("{0}", WS.Cells["A" + r].Value);

            if (VD.Trim().ToLower().StartsWith("date") && !isDataRow)
            {
                try
                {
                    VD = (VD.Replace("Date:", "")).Trim();
                    ValueDate = DateTime.ParseExact(VD, "dd-MM-yyyy", System.Globalization.CultureInfo.InvariantCulture).ToLongDateString();
                }
                catch (Exception)
                {
                    ValueDate = DateTime.Now.Date.ToLongDateString();
                }
            }
            try
            {
                int SL = int.Parse(WS.Cells["A" + r].Value.ToString());
                isDataRow = true;
            }
            catch (Exception)
            {
                isDataRow = false;
            }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    //ValueDate = WS.Cells["C" + r].Value.ToString();//(DateTime.ParseExact(WS.Cells["C" + r].Value.ToString(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture)).ToLongDateString();
                    RemitterName = string.Format("{0}", WS.Cells["C" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "D" + r);
                    BankName = string.Format("{0}", WS.Cells["H" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["I" + r].Value);
                    Area = string.Format("{0}", WS.Cells["J" + r].Value);
                    District = "";
                    Account = getNumberFromCell(WS, "F" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["L" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = getNumberFromCell(WS, "G" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["E" + r].Value);
                    Purpose = "";
                    PaymentMethod = "";
                    BeneficiaryID = string.Format("{0}", WS.Cells["K" + r].Value);
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private void ParseWorkSheet_Nmt_IC(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        int iSL = 1;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            //try
            //{
            //    string S = string.Format("{0}", WS.Cells["B" + r].Value).ToUpper();
            //    if (S.ToUpper().StartsWith("TEST"))
            //    {
            //        string D = WS.Cells["B" + r].Value.ToString().ToUpper().Replace("TEST", "");
            //        D = D.Replace(":", "");
            //        D = D.Substring(D.IndexOf("DATED", 0), 18);
            //        D = D.Replace("DATED", "").Trim();
            //        ValueDate = D;
            //    }
            //}
            //catch (Exception) { }

            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("SL"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    ValueDate = WS.Cells["C" + r].Value.ToString();//(DateTime.ParseExact(WS.Cells["C" + r].Value.ToString(), "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture)).ToLongDateString();
                    RemitterName = string.Format("{0}", WS.Cells["K" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "D" + r);
                    BankName = string.Format("{0}", WS.Cells["G" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["H" + r].Value);
                    Area = "";
                    District = "";
                    Account = getNumberFromCell(WS, "G" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["I" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = getNumberFromCell(WS, "F" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["J" + r].Value);
                    Purpose = string.Format("{0}", WS.Cells["L" + r].Value);
                    PaymentMethod = "IC";
                    BeneficiaryID = string.Format("{0}", WS.Cells["E" + r].Value);
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private void ParseZenj_Ex(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        ValueDate = DateTime.Today.Date.ToString();

        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("S"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S.Trim() == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    RemitterName = _ExHouseCode;
                    BeneficiaryName = getNumberFromCell(WS, "D" + r);
                    BankName = string.Format("{0}", WS.Cells["F" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["G" + r].Value);
                    Area = "";
                    District = "";
                    Account = getNumberFromCell(WS, "H" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["J" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = getNumberFromCell(WS, "C" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = "";
                    Purpose = "";
                    PaymentMethod = "";
                    BeneficiaryID = string.Format("{0}", WS.Cells["E" + r].Value);
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private void ParseZenjBE_Ex(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        ValueDate = DateTime.Today.Date.ToString();

        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                string S = string.Format("{0}", WS.Cells["A" + r].Value);
                if (S.ToUpper().StartsWith("S"))
                {
                    isDataRow = true;
                    continue;
                }
                else if (isDataRow && S.Trim() == "")
                    isDataRow = false;
            }
            catch (Exception) { }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", WS.Cells["A" + r].Value);
                    RemitterName = string.Format("{0}", WS.Cells["C" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "D" + r);
                    BankName = string.Format("{0}", WS.Cells["G" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["H" + r].Value);
                    Area = "";
                    District = string.Format("{0}", WS.Cells["I" + r].Value);
                    Account = getNumberFromCell(WS, "F" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["J" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = "";
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["B" + r].Value);
                    Contact = string.Format("{0}", WS.Cells["E" + r].Value); ;
                    Purpose = "";
                    PaymentMethod = "";
                    BeneficiaryID = "";
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private void ParsePLD_Ex(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        for (int r = 0; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                if (!isDataRow)
                {
                    string S = string.Format("{0}", WS.Cells["C" + r].Value);
                    double id_receiver = double.Parse(S);
                    isDataRow = true;
                }
            }
            catch (Exception)
            {
                continue;
            }

            try
            {
                if (isDataRow)
                {
                    SL = string.Format("{0}", r - 1);
                    RemitterName = string.Format("{0}", WS.Cells["I" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "D" + r);
                    BankName = string.Format("{0}", WS.Cells["Q" + r].Value);
                    BranchName = string.Format("{0}", WS.Cells["W" + r].Value);
                    Area = "";
                    District = string.Format("{0}", WS.Cells["K" + r].Value);
                    Account = getNumberFromCell(WS, "P" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["C" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = string.Format("{0}", WS.Cells["E" + r].Value);
                    PIN = "";
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["O" + r].Value);

                    Contact = "";
                    if ((string.Format("{0}", WS.Cells["F" + r].Value)).Trim().Length > 3)
                        Contact = string.Format("{0}", WS.Cells["F" + r].Value);
                    if ((string.Format("{0}", WS.Cells["G" + r].Value)).Trim().Length > 3)
                        Contact += string.Format(", {0}", WS.Cells["G" + r].Value).Trim();
                    if (Contact.StartsWith(","))
                        Contact = Contact.Substring(1);

                    Purpose = "";
                    PaymentMethod = "";
                    BeneficiaryID = "";
                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private void ParseKFE_Ex(ExcelWorksheet WS, string _ExHouseCode)
    {
        bool isDataRow = false;
        int _SL = 1;
        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {
                //string S = string.Format("{0}", WS.Cells["A" + r].Value);
                //if (S.Length > 0)
                //{
                //    isDataRow = true;
                //    continue;
                //}                

                ValueDate = DateTime.Parse(WS.Cells["B" + r].Value.ToString()).ToString();
            }
            catch (Exception) { }

            try
            {
                int Ref = int.Parse(WS.Cells["A" + r].Value.ToString());
                isDataRow = true;
            }
            catch (Exception)
            {
                isDataRow = false;
            }

            try
            {
                if (isDataRow)
                {
                    SL = _SL.ToString();
                    RemitterName = string.Format("{0}", WS.Cells["J" + r].Value);
                    BeneficiaryName = getNumberFromCell(WS, "D" + r);
                    BankName = string.Format("{0}", WS.Cells["F" + r].Value);

                    if (!string.Format("{0}", WS.Cells["G" + r].Value).ToUpper().StartsWith("ID"))
                    {
                        BranchName = string.Format("{0}", WS.Cells["G" + r].Value);
                        BeneficiaryID = "";
                    }
                    else
                    {
                        BranchName = "";
                        BeneficiaryID = string.Format("{0}", WS.Cells["G" + r].Value).Substring(3);
                    }

                    Area = string.Format("{0}", WS.Cells["I" + r].Value);
                    District = "";
                    Account = getNumberFromCell(WS, "E" + r);
                    Amount = string.Format("{0:N2}", WS.Cells["K" + r].Value);

                    RemitterAddress = "";
                    BeneficiaryAddress = "";
                    PIN = getNumberFromCell(WS, "H" + r);
                    Password = "";
                    RefOrderReceipt = string.Format("{0}", WS.Cells["A" + r].Value);
                    Contact = "";
                    Purpose = "";
                    PaymentMethod = "";

                    ToBranch = "";
                    ToBranch = getToBranchAll(ToBranch);
                    CommentHO = "";
                    CommentBR = "";

                    InsertTempUpload(_ExHouseCode, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR);
                    _SL++;
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private void ParseCustomFormat(ExcelWorksheet WS)
    {
        //Same as Orchid
        string AtmID = string.Empty;
        string AtmName = string.Empty;
        string Caset1;
        string Caset2;
        string Caset3;
        string Caset4;
        int Caset1_NoteCount = 0;
        int Caset2_NoteCount = 0;
        int Caset3_NoteCount = 0;
        int Caset4_NoteCount = 0;
        int Caset1_NoteValue = 0;
        int Caset2_NoteValue = 0;
        int Caset3_NoteValue = 0;
        int Caset4_NoteValue = 0;

        int FirstSplitValue = 0;
        int SecondSpliteValue = 0;


        for (int r = 1; r <= WS.Dimension.End.Row; r++)
        {
            try
            {                
                AtmID = string.Format("{0}", WS.Cells["A" + r].Value).Trim();
                AtmName = string.Format("{0}", WS.Cells["B" + r].Value).Trim();


                if (AtmID == "TBagrA22")
                { }
                //Caset1 = string.Format("{0}", WS.Cells["C" + r].Value);
                //string result = Caset1.Replace(" ", string.Empty).Replace(")", string.Empty);
                //int FirstSplitValue = Convert.ToInt32((result.Split('('))[0]);
                //int SecondSpliteValue = Convert.ToInt32((result.Split('('))[1]);

                //Caset1_NoteCount = FirstSplitValue / SecondSpliteValue;
                //Caset1_NoteValue = SecondSpliteValue;


                Caset1 = string.Format("{0}", WS.Cells["C" + r].Value);
                string result = Caset1.Replace(" ", string.Empty);
                string[] x = result.Split('(');
                string FirstSplit = x[0];
                string SecondSplit = x[1].Replace(")", string.Empty);
                //FirstSplitValue = Convert.ToInt32(FirstSplit.Trim());
                //SecondSpliteValue = Convert.ToInt32(SecondSplit.Trim());

                //Caset1_NoteCount = FirstSplitValue / SecondSpliteValue;
                //Caset1_NoteValue = SecondSpliteValue;
                try
                {
                    FirstSplitValue = Convert.ToInt32(FirstSplit.Trim());

                    try
                    {
                        SecondSpliteValue = Convert.ToInt32(SecondSplit.Trim());
                    }
                    catch (Exception)
                    {
                        SecondSpliteValue = 0;
                    }

                    try
                    {
                        Caset1_NoteCount = FirstSplitValue / SecondSpliteValue;
                    }
                    catch (Exception)
                    {
                        Caset1_NoteCount = 0;
                    }
                    Caset1_NoteValue = SecondSpliteValue;
                }
                catch
                {
                    Caset1_NoteCount = 0;
                    Caset1_NoteValue = 0;
                }




                Caset2 = string.Format("{0}", WS.Cells["D" + r].Value);
                result = Caset2.Replace(" ", string.Empty);
                x = result.Split('(');
                FirstSplit = x[0];
                SecondSplit = x[1].Replace(")", string.Empty);
                //FirstSplitValue = Convert.ToInt32(FirstSplit.Trim());
                //SecondSpliteValue = Convert.ToInt32(SecondSplit.Trim());

                //Caset2_NoteCount = FirstSplitValue / SecondSpliteValue;
                //Caset2_NoteValue = SecondSpliteValue;
                try
                {
                    FirstSplitValue = Convert.ToInt32(FirstSplit.Trim());

                    try
                    {
                        SecondSpliteValue = Convert.ToInt32(SecondSplit.Trim());
                    }
                    catch (Exception)
                    {
                        SecondSpliteValue = 0;
                    }

                    try
                    {
                        Caset2_NoteCount = FirstSplitValue / SecondSpliteValue;
                    }
                    catch (Exception)
                    {
                        Caset2_NoteCount = 0;
                    }
                    Caset2_NoteValue = SecondSpliteValue;
                }
                catch
                {
                    Caset2_NoteCount = 0;
                    Caset2_NoteValue = 0;
                }





                Caset3 = string.Format("{0}", WS.Cells["E" + r].Value);
                result = Caset3.Replace(" ", string.Empty);
                x = result.Split('(');
                FirstSplit = x[0];
                SecondSplit = x[1].Replace(")", string.Empty);
                try
                {
                    FirstSplitValue = Convert.ToInt32(FirstSplit.Trim());

                    try
                    {
                        SecondSpliteValue = Convert.ToInt32(SecondSplit.Trim());
                    }
                    catch (Exception)
                    {
                        SecondSpliteValue = 0;
                    }

                    try
                    {
                        Caset3_NoteCount = FirstSplitValue / SecondSpliteValue;
                    }
                    catch (Exception)
                    {
                        Caset3_NoteCount = 0;
                    }
                    Caset3_NoteValue = SecondSpliteValue;
                }
                catch {
                    Caset3_NoteCount = 0;
                    Caset3_NoteValue = 0;
                }





                Caset4 = string.Format("{0}", WS.Cells["F" + r].Value);
                result = Caset4.Replace(" ", string.Empty);
                x = result.Split('(');
                FirstSplit = x[0];
                SecondSplit = x[1].Replace(")", string.Empty);
                try
                {
                    FirstSplitValue = Convert.ToInt32(FirstSplit.Trim());

                    try
                    {
                        SecondSpliteValue = Convert.ToInt32(SecondSplit.Trim());
                    }
                    catch (Exception)
                    {
                        SecondSpliteValue = 0;
                    }

                    try
                    {
                        Caset4_NoteCount = FirstSplitValue / SecondSpliteValue;
                    }
                    catch (Exception)
                    {
                        Caset4_NoteCount = 0;
                    }
                    Caset4_NoteValue = SecondSpliteValue;
                }
                catch {
                    Caset4_NoteCount = 0;
                    Caset4_NoteValue = 0;
                }


                

                CommentBR = "";


                InsertTempUpload(AtmID
                    , AtmName
                    , Caset1_NoteCount
                    , Caset1_NoteValue
                    , Caset2_NoteCount
                    , Caset2_NoteValue
                    , Caset3_NoteCount
                    , Caset3_NoteValue
                    , Caset4_NoteCount
                    , Caset4_NoteValue
                    );
                
            }
            catch (Exception ex)
            {
                lblStatus.Text += "<br>" + r.ToString() + " " + ex.Message;
            }
        }
    }

    private void InsertTempUpload(string ExHouseCode1, string SL, string RemitterName, string RemitterAddress, string BeneficiaryName, string BeneficiaryAddress, string BankName, string BranchName, string Area, string District, string Account, string Amount, string PIN, string Password, string RefOrderReceipt, string Contact, string Purpose, string PaymentMethod, string ValueDate, string BeneficiaryID, string ToBranch, string CommentHO, string CommentBR)
    {
        RemitterAccount = "";
        RemitterAccType = "";
        AccountType = "";

        //InsertTempUpload(ExHouseCode1, SL, RemitterName, RemitterAddress, BeneficiaryName, BeneficiaryAddress, BankName, BranchName, Area, District, Account, Amount, PIN, Password, RefOrderReceipt, Contact, Purpose, PaymentMethod, ValueDate, BeneficiaryID, ToBranch, CommentHO, CommentBR, RemitterAccount, RemitterAccType, AccountType);
    }

    private void InsertTempUpload(string AtmID, string AtmName, int Caset1_NoteCount, int Caset1_NoteValue, int Caset2_NoteCount, int Caset2_NoteValue, int Caset3_NoteCount, int Caset3_NoteValue, int Caset4_NoteCount, int Caset4_NoteValue)
    {
        //if (!chkDoNotChangeAccountNumber.Checked)
        //    Account = AccountFilter(Account);
        //else
        //    Account = Account.Trim();

        //RemitterAccount = AccountFilter(RemitterAccount);
        //PIN = PINFilter(PIN);
    
        ObjectDataSource1.InsertParameters["AtmID"].DefaultValue = AtmID.Trim();//currentWorksheet.Cells[r, 3].Value.ToString();
        ObjectDataSource1.InsertParameters["AtmName"].DefaultValue = AtmName.Trim();
        ObjectDataSource1.InsertParameters["Caset1_NoteCount"].DefaultValue = Caset1_NoteCount.ToString();
        ObjectDataSource1.InsertParameters["Caset1_NoteValue"].DefaultValue = Caset1_NoteValue.ToString();
        ObjectDataSource1.InsertParameters["Caset2_NoteCount"].DefaultValue = Caset2_NoteCount.ToString();
        ObjectDataSource1.InsertParameters["Caset2_NoteValue"].DefaultValue = Convert.ToString(Caset2_NoteValue);
        ObjectDataSource1.InsertParameters["Caset3_NoteCount"].DefaultValue = Convert.ToString(Caset3_NoteCount);
        ObjectDataSource1.InsertParameters["Caset3_NoteValue"].DefaultValue = Convert.ToString(Caset3_NoteValue);
        ObjectDataSource1.InsertParameters["Caset4_NoteCount"].DefaultValue = Convert.ToString(Caset4_NoteCount);
        ObjectDataSource1.InsertParameters["Caset4_NoteValue"].DefaultValue = Convert.ToString(Caset4_NoteValue);
        ObjectDataSource1.InsertParameters["SessionID"].DefaultValue = HidPageID.Value;
        ObjectDataSource1.InsertParameters["InsertDT"].DefaultValue = DateTime.Now.ToString();
        
        ObjectDataSource1.Insert();
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

    protected void cmdUpdate_Click(object sender, EventArgs e)
    {
        RunNonQuery("EXEC sp_Update_CardNumber_from_TempImport '" + HidPageID.Value + "'", "RemittanceConnectionString", CommandType.Text);
        //Panel2.Visible = false;        
        TrustControl1.ClientMsg("Updated in Card Process Database");
        CleanDatabase();
        SqlDataSourceRemiList_Add.Select(System.Web.UI.DataSourceSelectArguments.Empty);
    }

    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

    }

    protected void cmdCheckFlat_Click(object sender, EventArgs e)
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

                        try
                        {
                            string s = AccountNo.Replace("-", "");
                            s = AccountFilter(s);
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
                catch (Exception) { }
            }
            reader.Close();
            lblStatus.Text = "Total Rows: <b>" + TotalRows.ToString() + "</b>";
        }
        catch (Exception) { }
    }

    protected void ObjectDataSource1_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
    {

    }

    protected void cmdClearData_Click(object sender, EventArgs e)
    {
        CleanDatabase();
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        //if (GridView1.Rows.Count > 0)
        //{
        //    int AmountCol = 0;
        //    for (int c = 0; c < GridView1.Columns.Count; c++)
        //        if (GridView1.HeaderRow.Cells[c].Text == "Amount")
        //            AmountCol = c;

        //    double TotalAmount = 0;
        //    for (int i = 0; i < GridView1.Rows.Count; i++)
        //    {
        //        GridView1.Rows[i].Cells[0].Text = (i + 1).ToString();
        //        TotalAmount += double.Parse(GridView1.Rows[i].Cells[AmountCol].Text);
        //    }
        //    GridView1.FooterRow.Cells[AmountCol].Text = string.Format("{0:N2}", TotalAmount);
        //    GridView1.FooterRow.Cells[AmountCol].HorizontalAlign = HorizontalAlign.Right;

        //    //Hide Cells
        //    for (int c = 4; c < 21; c++)
        //    {
        //        bool isEmpty = true;
        //        for (int r = 0; r < GridView1.Rows.Count; r++)
        //        {
        //            if (GridView1.Rows[r].Cells[c].Text.Trim() != "&nbsp;")
        //            {
        //                isEmpty = false;
        //            }
        //        }

        //        if (isEmpty)
        //            GridView1.Columns[c].Visible = false;
        //    }
        //}
    }
    protected void cmdDataBind_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void SqlDataSourceRemiList_Add_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        string BatchID = e.Command.Parameters["@Batch"].Value.ToString();
        Label3.Text = string.Format("Data Saved with the Batch ID: {0}", BatchID);
        Label4.Text = string.Format("<a href='ShowBatch.aspx?batch={0}'>Show Data</a>", BatchID);
        Panel2.Visible = false;
        GridView1.Visible = false;
    }

    private string getPaymentMethod(string PIN, string Account)
    {
        string RetVal = "";

        if ((PIN.Trim().Length == 0 || PIN == null) && Account.Trim().Length > 0)
            RetVal = "ACC";

        if (PIN.Trim().Length > 0 && (Account.Trim().Length == 0 || Account == null))
            RetVal = "IC";

        return RetVal;
    }

    private string AccountFilter(string Account)
    {
        string RetVal = Account;

        Regex rgx = new Regex("[^0-9-]");   //take only numbers and dash
        RetVal = rgx.Replace(RetVal, "");
        RetVal = Regex.Replace(RetVal, "-{2,}", "-");   //replacing all consecutive dashes to single dash

        while (RetVal.StartsWith("-"))
            RetVal = RetVal.Substring(1);

        while (RetVal.EndsWith("-"))
            RetVal = RetVal.Substring(0, RetVal.Length - 1);

        return RetVal;
    }

    private string PINFilter(string PIN)
    {
        string RetVal = PIN.Trim();

        if (RetVal.EndsWith(".00"))
            RetVal = RetVal.Substring(0, RetVal.Length - 3);

        Regex rgx = new Regex("[^0-9]");   //take only numbers 
        RetVal = rgx.Replace(RetVal, "");
        return RetVal;
    }

    private string getToBranchAll(string ToBranch)
    {
        return ToBranch;
        //if (dboAnyBRanch.SelectedItem.Value == "")
        //    return ToBranch;
        //else
        //    return dboAnyBRanch.SelectedItem.Value;
    }
    protected void ObjectDataSource1_Selected(object sender, ObjectDataSourceStatusEventArgs e)
    {

    }

    protected void cmdSaveData_SaveData(object sender, EventArgs e)
    {
        string BatchNo = "";   

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_ATM_Load_SaveData";
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
                GridView1.Visible = false;

                //TrustControl1.ClientMsg("Successfully Saved.");
                lblBatchLink.Text = string.Format("Date Saved Successfully.<br>Goto: ATM Cashload <a href='ATM_Cashload_Batch.aspx?batchid={0}'><b>Batch: {0}</b></a>", BatchNo);
            }
        }



        //try
        //{
        //    GridView1.Visible = false;
        //    string constr = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ToString();
        //    SqlConnection con = new SqlConnection(constr);
        //    SqlDataAdapter adapt = new SqlDataAdapter("AtmValueProcess", con);
        //    adapt.SelectCommand.CommandType = CommandType.StoredProcedure;
        //    //adapt.SelectCommand.Parameters.Add(new SqlParameter("@BatchID", SqlDbType.VarChar, 10)).Value = batchNo;
        //    adapt.SelectCommand.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar, 64)).Value = HidPageID.Value;
        //    adapt.SelectCommand.Parameters.Add(new SqlParameter("@InsertBy", SqlDbType.VarChar, 10)).Value = Session["EMPID"];

            


        //    //DataTable dt = new DataTable();
        //    DataSet dt = new DataSet();
        //    adapt.Fill(dt);
        //    //GridViewAtmValue.DataSource = dt;
        //    //GridViewAtmValue.DataBind();
            

        //}
        //catch (Exception ex) { }
    }





    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GridView2.SelectedRow;
        //Label lblSL = (Label)row.FindControl("lblSL");
        //hidSlNo.Value = lblSL.Text;
        string s = row.Cells[0].Text;
    }


}