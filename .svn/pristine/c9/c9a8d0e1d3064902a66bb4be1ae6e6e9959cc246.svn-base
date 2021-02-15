using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using OfficeOpenXml;
//using Excel;
using System.Text.RegularExpressions;

public partial class DisputeCheck : System.Web.UI.Page
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
                    if(FI.CreationTime.AddHours(1)< DateTime.Now)
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
        int Rows = RunNonQuery("DELETE FROM TempDisputeCheck WHERE EmpID = '" + Session["EMPID"].ToString() + "'", "CardDataConnectionString", CommandType.Text);
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
        string Line = string.Empty;
        
        StringBuilder sb;
        StreamReader reader = new StreamReader(FileName);
        sb = new StringBuilder();
        
        bool ProceedLine = false;
        bool ProceedLine1 = false;
        string CardNo = string.Empty;
        DateTime DT;
        double Amount = 0;
        string Status = string.Empty;
        int RowCount = 0;
        string TRNDATE = "";

        //if (Type == "DBBL")
        //{
        //    FileInfo FI = new FileInfo(FileName);

        //    using (ExcelPackage package = new ExcelPackage(FI))
        //    {
        //        try
        //        {
        //            ExcelWorkbook workBook = package.Workbook;
        //            if (workBook.Worksheets.Count > 0)
        //            {
        //                ExcelWorksheet WS = workBook.Worksheets[1];

        //                for (int r = 1; r <= WS.Dimension.End.Row; r++)
        //                {
        //                    try
        //                    {
        //                        int SL = int.Parse(WS.Cells["A" + r].Value.ToString());

        //                        string DateTime1 = string.Format("{0:dd-MM-yy}",
        //                            DateTime.FromOADate(double.Parse(WS.Cells["B" + r].Value.ToString())));
        //                        //DateTime1 = WS.Cells["B" + r].Value.ToString();
        //                        DateTime1 += "-" + WS.Cells["C" + r].Value.ToString().PadLeft(6, '0');
        //                        DT = DateTime.ParseExact(DateTime1, "yy-MM-dd-HHmmss", System.Globalization.CultureInfo.InvariantCulture);
        //                        CardNo = DoubleConverter.ToExactString((Double)(WS.Cells["D" + r].Value));
                                
                                
        //                        Amount = double.Parse(WS.Cells["H" + r].Value.ToString());
        //                        Status = "OK";

        //                        InsertTempDisputeCheck(Type + " R_ON_US", ".", CardNo, DT, Amount, Status);
        //                        RowCount++;
        //                    }
        //                    catch (Exception)
        //                    {
        //                        continue;
        //                    }
        //                }
        //            }
        //        }

        //        catch (Exception ex)
        //        {
        //            lblUploadStatus.Text = ex.Message;
        //        }
        //    }
        //}
        //else
        {
            int LineNo = 0;

            while (!reader.EndOfStream)
            {
                try
                {
                    Line = reader.ReadLine();
                    LineNo++;

                    if (LineNo == 6613)
                    {
                    }

                    if (Type == "ITCL")
                    {
                        try
                        {
                            DT = DateTime.ParseExact(Line.Substring(9, 17), "dd/MM/yy H:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
                            CardNo = (Line.Substring(93, 20)).Trim();
                            if (CardNo == "4181290000891457")
                            {
                            }
                            if ((Line.Substring(113, 14).Trim()) != "")
                            {
                                Amount = double.Parse(Line.Substring(113, 14));
                                Status = "CR";
                            }
                            else if ((Line.Substring(128, 14).Trim()) != "")
                            {
                                Amount = double.Parse(Line.Substring(128, 14));
                                Status = "DR";
                            }
                            if (Amount > 9)
                            {
                                InsertTempDisputeCheck(Type, Line, CardNo, DT, Amount, Status);
                                RowCount++;
                            }
                        }
                        catch (Exception ex) { }
                    }
                    else if (Type == "OMNIBUS")
                    {
                        if (Line.StartsWith("Issuer: QCASH") || Line.StartsWith("Issuer: 463767"))
                        {
                            ProceedLine = !ProceedLine;
                        }
                        if (ProceedLine)
                        {
                            if (Line.StartsWith("0200 WITHDRAWAL"))
                            {
                                CardNo = (Line.Substring(16, 20)).Trim();
                                Amount = double.Parse(Line.Substring(37, 16));
                                DT = DateTime.ParseExact(Line.Substring(54, 17), "MM/dd/yy H:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
                                Status = (Line.Substring(106, 12)).Trim();
                                if (Status == "OK" || Status == "ACQ REVERSAL")
                                {
                                    InsertTempDisputeCheck(Type + " R_ON_US", Line, CardNo, DT, Amount, Status);
                                    RowCount++;
                                }
                            }
                        }
                        if (Line.StartsWith("Acquirer: QCASH"))
                        {
                            ProceedLine1 = !ProceedLine1;
                        }
                        if (ProceedLine1)
                        {
                            if (Line.StartsWith("0200 WITHDRAWAL"))
                            {
                                CardNo = (Line.Substring(16, 20)).Trim();
                                Amount = double.Parse(Line.Substring(37, 16));
                                DT = DateTime.ParseExact(Line.Substring(54, 17), "MM/dd/yy H:mm:ss", System.Globalization.CultureInfo.InvariantCulture);
                                Status = (Line.Substring(106, 12)).Trim();
                                if (Status == "OK")
                                {
                                    InsertTempDisputeCheck(Type + " OFF_US", Line, CardNo, DT, Amount, Status);
                                    RowCount++;
                                }
                            }
                        }
                    }
                    else if (Type == "DBBL_TXT")
                    {
                        string[] words = Line.Trim().Split(' ');
                        string DateTime1 = TRNDATE;

                        try
                        {
                            TRNDATE = string.Format("{0:dd-MMM-yy}", DateTime.ParseExact(words[1].Trim(),
                            "dd-MMM-yy",
                            System.Globalization.CultureInfo.InvariantCulture));
                            DateTime1 = TRNDATE;
                        }
                        catch (Exception) { }

                        try
                        {
                            int SL = int.Parse(words[0]);
                        }
                        catch (Exception) { continue; }


                        DateTime1 += "-" + words[2].Trim().PadLeft(6, '0');
                        DT = DateTime.ParseExact(DateTime1,
                            "dd-MMM-yy-HHmmss",
                            System.Globalization.CultureInfo.InvariantCulture);

                        CardNo = words[3].Trim();
                        //string[] s = words[6].Split(" ".ToCharArray());
                        Amount = double.Parse(words[words.Length - 2]);
                        Status = "OK";
                        InsertTempDisputeCheck("DBBL" + " R_ON_US", Line.Trim(), CardNo, DT, Amount, Status);
                        RowCount++;


                    }
                    else if (Type == "DBBL_OLD")
                    {
                        string[] words = Line.Trim().Split(' ');
                        string DateTime1 = TRNDATE;

                        try
                        {
                            TRNDATE = string.Format("{0:dd-MMM-yyyy}", DateTime.ParseExact(Line.Trim(),
                            "dd-MMM-yyyy",
                            System.Globalization.CultureInfo.InvariantCulture));
                            DateTime1 = TRNDATE;
                        }
                        catch (Exception) { }

                        try
                        {
                            int SL = int.Parse(words[0]);
                        }
                        catch (Exception) { continue; }

                        
                        DateTime1 += "-" + words[1].Trim().PadLeft(6, '0');
                        DT = DateTime.ParseExact(DateTime1, 
                            "dd-MMM-yyyy-HHmmss", 
                            System.Globalization.CultureInfo.InvariantCulture);
                        
                        CardNo = words[2].Trim();
                        //string[] s = words[6].Split(" ".ToCharArray());
                        Amount = double.Parse(words[words.Length-2]);
                        Status = "OK";
                        InsertTempDisputeCheck("DBBL" + " R_ON_US", Line.Trim(), CardNo, DT, Amount, Status);
                        RowCount++;    

                  
                    }
                    else if (Type == "DBBL")
                    {
                        string[] words = Line.Trim().Split(' ');
                        string DateTime1 = "";

                        try
                        {
                            int SL = int.Parse(words[0]);
                        }
                        catch (Exception) { continue; }

                        DateTime1 = words[1].Trim() + "-" + words[2].Trim().PadLeft(6, '0');
                        DT = DateTime.ParseExact(DateTime1,
                            "dd-MMM-yy-HHmmss",
                            System.Globalization.CultureInfo.InvariantCulture);

                        CardNo = words[3].Trim();
                        //string[] s = words[6].Split(" ".ToCharArray());
                        Amount = double.Parse(words[words.Length - 2]);
                        Status = "OK";
                        InsertTempDisputeCheck(Type + " R_ON_US", Line.Trim(), CardNo, DT, Amount, Status);
                        RowCount++;


                    }
                    else if (Type == "ATM")
                    {
                        DT = DateTime.ParseExact(Line.Substring(12, 9), "dd-MMM-yy", System.Globalization.CultureInfo.InvariantCulture);
                        string PrevLine = Line;
                        CardNo = Line.Substring(24, 20).Trim();
                        Amount = double.Parse(Line.Substring(96, 12).Trim());
                        Status = "OK";
                        string Account = Line.Substring(44, 20).Trim();
                        InsertTempDisputeCheck(Type + " ON_US", PrevLine, CardNo, DT, Amount, Status, Account);
                        RowCount++;
                    }
                }
                catch (Exception) { }
            }
            reader.Close();
        }
        TrustControl1.ClientMsg(RowCount.ToString() + " Rows Saved.");
        try
        {
            File.Delete(FileName);
        }
        catch (Exception) { }
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
        if(GridView1.Rows.Count>0)
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
