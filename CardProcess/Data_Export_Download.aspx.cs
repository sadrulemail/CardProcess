﻿using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using OfficeOpenXml;
using System.IO;
using System.Data.SqlClient;

public partial class Data_Export_Download : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        //if (TrustControl1.isRole() == "")
        //    Response.End();
        if (Session["BRANCHID"].ToString() != "1")
            Response.End();

        if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["batch"]) && !string.IsNullOrEmpty(Request.QueryString["type"]))
        {
            if (string.Format("{0}", Request.QueryString["type"]) == "csv")
            {

                string BatchID = Request.QueryString["batch"].ToString();
                string CardType = Request.QueryString["CardType"].ToString();
                //string Branches = Request.QueryString["branches"].ToString();
                string attachment = "attachment; filename=CARD_BATCH_" + BatchID + "_CardType_"+ CardType + ".csv";
                //TrustControl1.ClientMsg(GridView1.Rows[0].Cells[1].te()); return;                        
                HttpContext.Current.Response.ClearHeaders();
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ClearContent();
                HttpContext.Current.Response.AddHeader("content-disposition", attachment);
                HttpContext.Current.Response.ContentType = "application/vnd.xls";
                HttpContext.Current.Response.AddHeader("Pragma", "public");

                HttpContext.Current.Response.Write(getCSV_ReExport(BatchID));
                HttpContext.Current.Response.End();
            }
            else if (string.Format("{0}", Request.QueryString["type"]) == "view")
            {
                GridView1.DataBind();
            }
            else if(string.Format("{0}", Request.QueryString["type"]) == "xml")
            {
                try
                {
                    string BranchCodes = string.Format("{0}", Request.QueryString["branches"]);
                    Int32 BatchID =Int32.Parse(Request.QueryString["batch"]);
                    string CardType = Request.QueryString["CardType"];

                    string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
                    SqlConnection oConn = new SqlConnection(oConnString);
                    SqlCommand oCommand = new SqlCommand("sp_ExportToITCL_Offline_xml", oConn);
                    oCommand.CommandType = CommandType.StoredProcedure;
                    oCommand.Parameters.AddWithValue("BatchID", BatchID);
                    oCommand.Parameters.AddWithValue("BranchCodes", BranchCodes);
                    if (oConn.State == ConnectionState.Closed)
                        oConn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(oCommand);

                    DataSet Dss = new DataSet();
                    da.Fill(Dss);

                    string FileName = System.IO.Path.GetRandomFileName();


                    StringBuilder SW = new StringBuilder();

                    string line00 = "<?xml version="+"\""+"1.0"+"\""+ " encoding="+"\""+"UTF-8"+"\""+ "?>";
                    string line0 = "<dataroot xmlns:od=" + "\"" + "urn:schemas-microsoft-com:officedata" + "\" "+ "generated="+ "\"" +string.Format("{0}",DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ss"))+ "\" " + ">";

                    SW.Append(line00).AppendLine();
                    SW.Append(line0).AppendLine();
                    
                    foreach (DataRow dr in Dss.Tables[0].Rows)
                    {
                        string line = dr[0].ToString();
                        SW.Append(line).AppendLine();
                    }
                    string linelast = "</dataroot>";
                    SW.Append(linelast).AppendLine();

                    //Downloading xml file 
                    string download_file_name = "attachment; filename=New_Issue_" +BatchID+ "_CardType_"+ CardType+".xml";
                    Response.ClearHeaders();
                    Response.Clear();
                    Response.ClearContent();
                    Response.AddHeader("content-disposition", download_file_name);
                    Response.ContentType = "text/xml";
                    Response.AddHeader("Pragma", "public");

                    Response.Write(SW);
                    Response.End();
                }
                catch (Exception ex)
                {
                    //lblStatus.Text = ex.Message;
                }

            }
            else if (Request.QueryString["type"].ToString() == "xlsx1")
            {
                try
                {
                    string FileName = Path.GetTempFileName();
                    string BatchID = Request.QueryString["batch"].ToString();

                    if (File.Exists(FileName)) File.Delete(FileName);
                    FileInfo FI = new FileInfo(FileName);

                    using (ExcelPackage xlPackage = new ExcelPackage(FI))
                    {
                        ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("Card Issue List");
                        int StartRow = 1;
                        //Adding Title Row
                        worksheet.Cells[StartRow, 1].Value = "Accountno";
                        worksheet.Cells[StartRow, 2].Value = "Amount_tk";
                        worksheet.Cells[StartRow, 3].Value = "Dr_Cr";
                        worksheet.Cells[StartRow, 4].Value = "Trn_br_code";

                        worksheet.Column(1).Width = 22;
                        worksheet.Column(2).Width = 20;
                        worksheet.Column(3).Width = 15;
                        worksheet.Column(4).Width = 15;

                        DataView DV = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);

                        for (int r = 0; r < DV.Table.Rows.Count; r++)
                        {
                            int R = StartRow + r + 1;

                            if (DV.Table.Rows[r]["Account"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["Account"].ToString();
                                //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                            }


                            if (DV.Table.Rows[r]["Card_IssueFee"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["Card_IssueFee"].ToString();
                                worksheet.Cells[R, 2].Style.Numberformat.Format = "#.##";
                            }

                            worksheet.Cells[R, 3].Value = "Dr";



                            if (DV.Table.Rows[r]["Account"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["Account"].ToString().Trim().Substring(0, 4);
                            }
                        }
                        worksheet.Cells["A1:D1"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                        worksheet.Cells["B1:B"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                        worksheet.Cells["C1:C"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                        worksheet.Cells["D1:D"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                        worksheet.Cells["A1:D"].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Top;
                        worksheet.Cells["A1:D1"].Style.Font.Bold = true;



                        //Adding Properties
                        xlPackage.Workbook.Properties.Title = "CARD-ISSUE-VISA";
                        xlPackage.Workbook.Properties.Author = "Administrator";
                        xlPackage.Workbook.Properties.Company = "Trust Bank Limited";
                        //xlPackage.Workbook.Properties.LastModifiedBy = string.Format("{0}", Session["EMPNAME"]);

                        xlPackage.Save();
                    }


                    //Reading File Content
                    byte[] content = File.ReadAllBytes(FileName);
                    File.Delete(FileName);

                    //Downloading File
                    Response.Clear();
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.ContentType = "application/xlsx";
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + "CARD_ISSUE_VISA_" + BatchID + ".xlsx");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.BinaryWrite(content);
                    Response.End();
                    return;
                }
                catch (Exception ex)
                {
                    //lblStatus.Text = ex.Message;
                }
            }

            else if (string.Format("{0}", Request.QueryString["type"]) == "xlsx")
            {
                try
                {
                    string FileName = Path.GetTempFileName();
                    string BatchID = Request.QueryString["batch"].ToString();
                    string CardType = Request.QueryString["CardType"].ToString();
                    //FileName = "C:\\1.xlsx";
                    FileInfo FI = new FileInfo(FileName);
                    if (File.Exists(FileName)) File.Delete(FileName);

                    using (ExcelPackage xlPackage = new ExcelPackage(FI))
                    {
                        ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("Cards");
                        int StartRow = 1;

                        //Adding Title Row
                        worksheet.Column(1).Width = 35;
                        worksheet.Column(2).Width = 8;
                        worksheet.Column(3).Width = 6;
                        worksheet.Column(4).Width = 30;
                        worksheet.Column(5).Width = 20;
                        worksheet.Column(6).Width = 10;
                        worksheet.Column(7).Width = 15;
                        worksheet.Column(8).Width = 10;
                        worksheet.Column(9).Width = 25;
                        worksheet.Column(10).Width = 25;
                        worksheet.Column(11).Width = 25;
                        worksheet.Column(12).Width = 10;
                        worksheet.Column(13).Width = 10;
                        worksheet.Column(14).Width = 10;
                        worksheet.Column(15).Width = 20;
                        worksheet.Column(16).Width = 20;
                        worksheet.Column(17).Width = 35;
                        worksheet.Column(18).Width = 25;
                        //worksheet.Cells["A1:C1"].Style.Font.Bold = true;

                        //Adding Title Row
                        worksheet.Cells[StartRow, 1].Value = "FIO";
                        worksheet.Cells[StartRow, 2].Value = "SEX";
                        worksheet.Cells[StartRow, 3].Value = "TITLE";
                        worksheet.Cells[StartRow, 4].Value = "NAMEONCARD";
                        worksheet.Cells[StartRow, 5].Value = "ACCOUNT";
                        worksheet.Cells[StartRow, 6].Value = "ACCOUNTTP";
                        worksheet.Cells[StartRow, 7].Value = "BIRTHDAY";
                        worksheet.Cells[StartRow, 8].Value = "ACCTSTAT";
                        worksheet.Cells[StartRow, 9].Value = "ADDRESS";
                        worksheet.Cells[StartRow, 10].Value = "CORADDRESS";
                        worksheet.Cells[StartRow, 11].Value = "RESADDRESS";
                        worksheet.Cells[StartRow, 12].Value = "CNTRYREG";
                        worksheet.Cells[StartRow, 13].Value = "CNTRYCONT";
                        worksheet.Cells[StartRow, 14].Value = "CNTRYLIVE";
                        worksheet.Cells[StartRow, 15].Value = "CELLPHONE";
                        worksheet.Cells[StartRow, 16].Value = "PHONE";
                        worksheet.Cells[StartRow, 17].Value = "CLIENTPROP";
                        worksheet.Cells[StartRow, 18].Value = "BRPART";

                        DataView DV = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                        int R = 0;
                        for (int r = 0; r < DV.Table.Rows.Count; r++)
                        {
                            R = StartRow + r + 1;
                            if (DV.Table.Rows[r]["FIO"] != DBNull.Value)
                                worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["FIO"].ToString();
                            if (DV.Table.Rows[r]["SEX"] != DBNull.Value)
                                worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["SEX"].ToString();
                            if (DV.Table.Rows[r]["TITLE"] != DBNull.Value)
                                worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["TITLE"].ToString();
                            if (DV.Table.Rows[r]["NAMEONCARD"] != DBNull.Value)
                                worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["NAMEONCARD"].ToString();
                            if (DV.Table.Rows[r]["ACCOUNT"] != DBNull.Value)
                                worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["ACCOUNT"].ToString();

                            if (DV.Table.Rows[r]["ACCOUNTTP"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["ACCOUNTTP"];
                            }

                            if (DV.Table.Rows[r]["BIRTHDAY"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 7].Value = DV.Table.Rows[r]["BIRTHDAY"];
                                worksheet.Cells[R, 7].Style.Numberformat.Format = "dd-MMM-yyyy";
                            }

                            if (DV.Table.Rows[r]["ACCTSTAT"] != DBNull.Value)
                                worksheet.Cells[R, 8].Value = DV.Table.Rows[r]["ACCTSTAT"].ToString();
                            if (DV.Table.Rows[r]["ADDRESS"] != DBNull.Value)
                                worksheet.Cells[R, 9].Value = DV.Table.Rows[r]["ADDRESS"].ToString();
                            if (DV.Table.Rows[r]["CORADDRESS"] != DBNull.Value)
                                worksheet.Cells[R, 10].Value = DV.Table.Rows[r]["CORADDRESS"].ToString();
                            if (DV.Table.Rows[r]["RESADDRESS"] != DBNull.Value)
                                worksheet.Cells[R, 11].Value = DV.Table.Rows[r]["RESADDRESS"].ToString();
                            if (DV.Table.Rows[r]["CNTRYREG"] != DBNull.Value)
                                worksheet.Cells[R, 12].Value = DV.Table.Rows[r]["CNTRYREG"];
                            if (DV.Table.Rows[r]["CNTRYCONT"] != DBNull.Value)
                                worksheet.Cells[R, 13].Value = DV.Table.Rows[r]["CNTRYCONT"];
                            if (DV.Table.Rows[r]["CNTRYLIVE"] != DBNull.Value)
                                worksheet.Cells[R, 14].Value = DV.Table.Rows[r]["CNTRYLIVE"];
                            if (DV.Table.Rows[r]["CELLPHONE"] != DBNull.Value)
                                worksheet.Cells[R, 15].Value = DV.Table.Rows[r]["CELLPHONE"].ToString();
                            if (DV.Table.Rows[r]["PHONE"] != DBNull.Value)
                                worksheet.Cells[R, 16].Value = DV.Table.Rows[r]["PHONE"].ToString();
                            if (DV.Table.Rows[r]["CLIENTPROP"] != DBNull.Value)
                                worksheet.Cells[R, 17].Value = DV.Table.Rows[r]["CLIENTPROP"].ToString();
                            if (DV.Table.Rows[r]["BRPART"] != DBNull.Value)
                                worksheet.Cells[R, 18].Value = DV.Table.Rows[r]["BRPART"].ToString();
                        }

                        //worksheet.Cells["A1:C" + R].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;


                        //Adding Properties
                        xlPackage.Workbook.Properties.Title = "Export_to_ITCL (Batch " + BatchID + ")";
                        xlPackage.Workbook.Properties.Author = "Ashik Iqbal (www.ashik.info)";
                        xlPackage.Workbook.Properties.Company = "Trust Bank Limited";
                        xlPackage.Workbook.Properties.LastModifiedBy = string.Format("{0} ({1})", Session["FULLNAME"], Session["EMAIL"]);

                        xlPackage.Save();
                    }


                    //Reading File Content
                    byte[] content = File.ReadAllBytes(FileName);
                    File.Delete(FileName);

                    //Downloading File
                    Response.Clear();
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.ContentType = "application/ms-excel";
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + "Export_to_ITCL_" + BatchID + "_CardType_" + CardType + ".xlsx");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.BinaryWrite(content);
                    Response.End();

                }
                catch (Exception ex)
                {
                    TrustControl1.ClientMsg(ex.Message);
                }

            }
        }
        
    }

    private string getCSV_ReExport(string BatchID)
    {
        StringBuilder csv = new StringBuilder();
        //SqlDataSourceReExport.SelectParameters["BatchID"].DefaultValue = BatchID;
        DataView dv = (DataView)SqlDataSourceReExport.Select(DataSourceSelectArguments.Empty);

        //csv.Append("\"File ID\",\"File Name\",\"Description\",\"Rack Name\",\"Status\"");
        //csv.Append(Environment.NewLine);

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            csv.Append(dv.Table.Rows[i][0]);
            csv.Append(Environment.NewLine);
        }
        return csv.ToString();
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            lblMsg.Visible = true;
            lblMsg.Text = "<b>Total Records: </b>" + e.AffectedRows.ToString();
        }
        else
            lblMsg.Visible = false;
    }
}