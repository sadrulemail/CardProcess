﻿using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using OfficeOpenXml;
using System.IO;

public partial class PriorityPassBillDownload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        //TrustControl1.LoadEmpToSession(false);

        //if (TrustControl1.isRole() == "")
        //    Response.End();
        if (Session["BRANCHID"].ToString() != "1")
            Response.End();

        if (string.Format("{0}", Request.QueryString["card"]) == "")
        {
            GridView2.Visible = false;
            GridView3.Visible = false;
        }

        if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["bm"]) && !string.IsNullOrEmpty(Request.QueryString["type"]))
        {
            if (string.Format("{0}", Request.QueryString["type"]) == "view")
            {
                GridView1.DataBind();
            }

            else if (string.Format("{0}", Request.QueryString["type"]) == "xlsx")
            {
                try
                {
                    string FileName = Path.GetTempFileName();
                    //string BatchID = Request.QueryString["batch"].ToString();

                    if (File.Exists(FileName)) File.Delete(FileName);
                    FileInfo FI = new FileInfo(FileName);

                    using (ExcelPackage xlPackage = new ExcelPackage(FI))
                    {
                        ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("PriorityPassBill");
                        int StartRow = 1;
                        //Adding Title Row
                        worksheet.Cells[StartRow, 1].Value = "SL";
                        worksheet.Cells[StartRow, 2].Value = "Name";
                        worksheet.Cells[StartRow, 3].Value = "ITCLID";
                        worksheet.Cells[StartRow, 4].Value = "Card No.";
                        worksheet.Cells[StartRow, 5].Value = "Card Holder";
                        worksheet.Cells[StartRow, 6].Value = "Guest";
                        worksheet.Cells[StartRow, 7].Value = "Total";
                        worksheet.Cells[StartRow, 8].Value = "Charge";
                        worksheet.Cells[StartRow, 9].Value = "Total Amount";
                        worksheet.Cells[StartRow, 10].Value = "No. of Waive";
                        worksheet.Cells[StartRow, 11].Value = "No. of Charge";
                        worksheet.Cells[StartRow, 12].Value = "Charge Amount";

                        worksheet.Column(1).Width = 10;
                        worksheet.Column(2).Width = 25;
                        worksheet.Column(3).Width = 10;
                        worksheet.Column(4).Width = 15;
                        worksheet.Column(5).Width = 10;
                        worksheet.Column(6).Width = 10;
                        worksheet.Column(7).Width = 10;
                        worksheet.Column(8).Width = 10;
                        worksheet.Column(9).Width = 15;
                        worksheet.Column(10).Width = 10;
                        worksheet.Column(11).Width = 15;
                        worksheet.Column(12).Width = 15;

                       
                        DataView DV = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                        int R = 0;
                        for (int r = 0; r < DV.Table.Rows.Count; r++)
                        {
                             R = StartRow + r + 1;
                            worksheet.Cells[R, 1].Value = R - 1;
                            if (DV.Table.Rows[r]["CustomerName"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["CustomerName"].ToString();
                            }
                            if (DV.Table.Rows[r]["ITCLID"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["ITCLID"].ToString();
                            }
                            if (DV.Table.Rows[r]["CardNo"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["CardNo"].ToString();
                            }
                            if (DV.Table.Rows[r]["Member"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["Member"];
                               // worksheet.Cells[R, 5].Style.Numberformat.Format = "#.##";
                            }
                            if (DV.Table.Rows[r]["Guest"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["Guest"];
                                //worksheet.Cells[R, 6].Style.Numberformat.Format = "#.##";
                            }
                            if (DV.Table.Rows[r]["Total"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 7].Value = DV.Table.Rows[r]["Total"];
                                //worksheet.Cells[R, 7].Style.Numberformat.Format = "#.##";
                            }
                            if (DV.Table.Rows[r]["ChargePerVisit"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 8].Value = DV.Table.Rows[r]["ChargePerVisit"];
                                worksheet.Cells[R, 8].Style.Numberformat.Format = "0.00";
                            }
                            if (DV.Table.Rows[r]["TotalAmount"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 9].Value = DV.Table.Rows[r]["TotalAmount"];
                                worksheet.Cells[R, 9].Style.Numberformat.Format = "0.00";
                            }
                            if (DV.Table.Rows[r]["Waive"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 10].Value = DV.Table.Rows[r]["Waive"];
                                //worksheet.Cells[R, 10].Style.Numberformat.Format = "#.##";
                            }
                            if (DV.Table.Rows[r]["NoOfCharge"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 11].Value = DV.Table.Rows[r]["NoOfCharge"];
                                //worksheet.Cells[R, 11].Style.Numberformat.Format = "#.##";
                            }
                            if (DV.Table.Rows[r]["ChargeAmount"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 12].Value = DV.Table.Rows[r]["ChargeAmount"];
                                worksheet.Cells[R, 12].Style.Numberformat.Format = "0.00";
                            }

                        }

                        worksheet.Cells[R + 1, 5].Formula = "=SUM(E2:E" + R + ")";
                        worksheet.Cells[R + 1, 6].Formula = "=SUM(F2:F" + R + ")";
                        worksheet.Cells[R + 1, 7].Formula = "=SUM(G2:G" + R + ")";
                        //worksheet.Cells[R + 1, 8].Formula = "=SUM(H2:H" + R + ")";
                        worksheet.Cells[R + 1, 9].Formula = "=SUM(I2:I" + R + ")";
                        worksheet.Cells[R + 1, 9].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[R + 1, 10].Formula = "=SUM(J2:J" + R + ")";
                        worksheet.Cells[R + 1, 11].Formula = "=SUM(K2:K" + R + ")";
                        worksheet.Cells[R + 1, 12].Formula = "=SUM(L2:L" + R + ")";
                        worksheet.Cells[R + 1, 12].Style.Numberformat.Format = "0.00";
                        worksheet.Cells["E" + (R + 1) + ":L" + (R + 1)].Style.Font.Bold = true;
                        worksheet.Cells["E" + (R + 1) + ":L" + (R + 1)].Style.Font.Size = 14;

                        worksheet.Cells["A1:D1"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;

                        worksheet.Cells["A1:Z1"].Style.Font.Bold = true;
                        worksheet.Cells["A1:Z1"].Style.WrapText = true;
                        worksheet.Cells["B1:B100"].Style.WrapText = true;
                        worksheet.Cells["E:L"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                        //Adding Properties
                        xlPackage.Workbook.Properties.Title = "PriorityPassBill";
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
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + "PriorityPassBill_" + DateTime.Now + ".xlsx");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.BinaryWrite(content);
                    Response.End();
                    return;

                }
                catch (Exception ex)
                {
                    TrustControl1.ClientMsg(ex.Message);
                }

            }
            else if (string.Format("{0}", Request.QueryString["type"]) == "bill")
            {
                try
                {
                    string FileName = Path.GetTempFileName();
                    //string BatchID = Request.QueryString["batch"].ToString();

                    if (File.Exists(FileName)) File.Delete(FileName);
                    FileInfo FI = new FileInfo(FileName);

                    using (ExcelPackage xlPackage = new ExcelPackage(FI))
                    {
                        ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("PriorityPassBill");
                        int StartRow = 4;
                        //Adding Title Row
                        worksheet.Cells[1, 3].Value = "Bill For the Month of "+ 
                            System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(
                                Int32.Parse(Request.QueryString["bm"].ToString().Substring(4,2)))+"-"+ Request.QueryString["bm"].ToString().Substring(0,4);
                        worksheet.Cells[1, 3].Style.Font.Size = 14;
                        worksheet.Cells[1, 3].Style.Font.Bold = true;

                        worksheet.Cells[StartRow, 1].Value = "SL";
                        worksheet.Cells[StartRow, 2].Value = "Name";
                        worksheet.Cells[StartRow, 3].Value = "ITCLID";
                        worksheet.Cells[StartRow, 4].Value = "Card No.";
                        worksheet.Cells[StartRow, 5].Value = "Card Holder";
                        worksheet.Cells[StartRow, 6].Value = "Guest";
                        worksheet.Cells[StartRow, 7].Value = "Total";
                        worksheet.Cells[StartRow, 8].Value = "Charge";
                        worksheet.Cells[StartRow, 9].Value = "Total Amount";
                        worksheet.Cells[StartRow, 10].Value = "No. of Waive";
                        worksheet.Cells[StartRow, 11].Value = "No. of Charge";
                        worksheet.Cells[StartRow, 12].Value = "Charge Amount";

                        worksheet.Column(1).Width = 10;
                        worksheet.Column(2).Width = 25;
                        worksheet.Column(3).Width = 10;
                        worksheet.Column(4).Width = 15;
                        worksheet.Column(5).Width = 10;
                        worksheet.Column(6).Width = 10;
                        worksheet.Column(7).Width = 10;
                        worksheet.Column(8).Width = 10;
                        worksheet.Column(9).Width = 15;
                        worksheet.Column(10).Width = 10;
                        worksheet.Column(11).Width = 15;
                        worksheet.Column(12).Width = 15;

                        DataView DV = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
                        int R = 0;
                        for (int r = 0; r < DV.Table.Rows.Count; r++)
                        {
                            R = StartRow + r + 1;
                            worksheet.Cells[R, 1].Value = R - 4;
                            if (DV.Table.Rows[r]["CustomerName"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["CustomerName"].ToString();
                            }
                            if (DV.Table.Rows[r]["ITCLID"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["ITCLID"].ToString();
                            }
                            if (DV.Table.Rows[r]["CardNo"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["CardNo"].ToString();
                            }
                            if (DV.Table.Rows[r]["Member"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 5].Value =DV.Table.Rows[r]["Member"];
                                //worksheet.Cells[R, 5].Style.Numberformat.Format = "#";
                            }
                            if (DV.Table.Rows[r]["Guest"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["Guest"];
                                //worksheet.Cells[R, 6].Style.Numberformat.Format = "#";
                            }
                            if (DV.Table.Rows[r]["Total"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 7].Value = DV.Table.Rows[r]["Total"];
                                //worksheet.Cells[R, 7].Style.Numberformat.Format = "#";
                            }
                            if (DV.Table.Rows[r]["ChargePerVisit"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 8].Value = DV.Table.Rows[r]["ChargePerVisit"];
                                worksheet.Cells[R, 8].Style.Numberformat.Format = "0.00";
                            }
                            if (DV.Table.Rows[r]["TotalAmount"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 9].Value = DV.Table.Rows[r]["TotalAmount"];
                                worksheet.Cells[R, 9].Style.Numberformat.Format = "0.00";
                            }
                            if (DV.Table.Rows[r]["Waive"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 10].Value = DV.Table.Rows[r]["Waive"];
                                //worksheet.Cells[R, 10].Style.Numberformat.Format = "#";
                            }
                            if (DV.Table.Rows[r]["NoOfCharge"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 11].Value = DV.Table.Rows[r]["NoOfCharge"];
                                //worksheet.Cells[R, 11].Style.Numberformat.Format = "#";
                            }
                            if (DV.Table.Rows[r]["ChargeAmount"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 12].Value = DV.Table.Rows[r]["ChargeAmount"];
                                worksheet.Cells[R, 12].Style.Numberformat.Format = "0.00";
                            }

                        }
                        worksheet.Cells[R + 1, 5].Formula = "=SUM(E5:E"+R+")";
                        worksheet.Cells[R + 1, 6].Formula = "=SUM(F5:F" + R + ")";
                        worksheet.Cells[R + 1, 7].Formula = "=SUM(G5:G" + R + ")";
                        //worksheet.Cells[R + 1, 8].Formula = "=SUM(H2:H" + R + ")";
                        worksheet.Cells[R + 1, 9].Formula = "=SUM(I5:I" + R + ")";
                        worksheet.Cells[R+1, 9].Style.Numberformat.Format = "0.00";
                        worksheet.Cells[R + 1, 10].Formula = "=SUM(J5:J" + R + ")";
                        worksheet.Cells[R + 1, 11].Formula = "=SUM(K5:K" + R + ")";
                        worksheet.Cells[R + 1, 12].Formula = "=SUM(L5:L" + R + ")";
                        worksheet.Cells[R + 1, 12].Style.Numberformat.Format = "0.00";
                        worksheet.Cells["E"+(R+1)+":L"+(R+1)].Style.Font.Bold = true;
                        worksheet.Cells["E" + (R + 1) + ":L" + (R + 1)].Style.Font.Size = 14;

                        worksheet.Cells["A1:D1"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                       
                        worksheet.Cells["A4:Z4"].Style.Font.Bold = true;
                        worksheet.Cells["A4:Z4"].Style.WrapText = true;
                        worksheet.Cells["B1:B100"].Style.WrapText = true;
                        worksheet.Cells["E:L"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;

                        worksheet.Cells[R + 5, 2].Value = "----------------";
                        worksheet.Cells[R + 5, 5].Value = "----------------";
                        worksheet.Cells[R + 5, 10].Value = "---------------";
                        worksheet.Cells[R + 6, 2].Value = "Prepared By";
                        worksheet.Cells[R + 6, 5].Value = "Check By";
                        worksheet.Cells[R + 6, 10].Value = "Authorize By";
                        worksheet.Cells[R + 6, 2].Style.Font.Bold = true;
                        worksheet.Cells[R + 6, 5].Style.Font.Bold = true;
                        worksheet.Cells[R + 6, 10].Style.Font.Bold = true;

                        //Adding Properties
                        xlPackage.Workbook.Properties.Title = "PriorityPassBill";
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
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + "PriorityPassBill" + DateTime.Now + ".xlsx");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.BinaryWrite(content);
                    Response.End();
                    return;

                }
                catch (Exception ex)
                {
                    TrustControl1.ClientMsg(ex.Message);
                }

            }

            else if (string.Format("{0}", Request.QueryString["type"]) == "xlsxSM")
            {
                try
                {
                    string FileName = Path.GetTempFileName();
                    //string BatchID = Request.QueryString["batch"].ToString();

                    if (File.Exists(FileName)) File.Delete(FileName);
                    FileInfo FI = new FileInfo(FileName);

                    using (ExcelPackage xlPackage = new ExcelPackage(FI))
                    {
                        ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("Summary");
                        int StartRow = 4;
                        //Adding Title Row
                        worksheet.Cells[1, 3].Value = "Summery for the Month of " +
                            System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(
                                Int32.Parse(Request.QueryString["bm"].ToString().Substring(4, 2))) + "-" + Request.QueryString["bm"].ToString().Substring(0, 4);
                        worksheet.Cells[1, 3].Style.Font.Size = 14;
                        worksheet.Cells[1, 3].Style.Font.Bold = true;

                        worksheet.Cells[StartRow, 1].Value = "SL";
                        worksheet.Cells[StartRow, 2].Value = "Name";
                        worksheet.Cells[StartRow, 3].Value = "ITCLID";
                        worksheet.Cells[StartRow, 4].Value = "Card No.";
                        worksheet.Cells[StartRow, 5].Value = "Member";
                        worksheet.Cells[StartRow, 6].Value = "Guest";
                        worksheet.Cells[StartRow, 7].Value = "Total";                        
                        worksheet.Cells[StartRow, 8].Value = "Total Amount";
                        worksheet.Cells[StartRow, 9].Value = "No. of Waive";
                        worksheet.Cells[StartRow, 10].Value = "No. of Charge";
                        worksheet.Cells[StartRow, 11].Value = "Charge Amount";

                        worksheet.Column(1).Width = 10;
                        worksheet.Column(2).Width = 25;
                        worksheet.Column(3).Width = 10;
                        worksheet.Column(4).Width = 15;
                        worksheet.Column(5).Width = 10;
                        worksheet.Column(6).Width = 10;
                        worksheet.Column(7).Width = 10;
                        worksheet.Column(8).Width = 10;
                        worksheet.Column(9).Width = 15;
                        worksheet.Column(10).Width = 10;
                        worksheet.Column(11).Width = 15;
                        //worksheet.Column(12).Width = 15;

                        DataView DV = (DataView)SqlDataSource3.Select(DataSourceSelectArguments.Empty);
                        int R = 0;
                        for (int r = 0; r < DV.Table.Rows.Count; r++)
                        {
                            R = StartRow + r + 1;
                            worksheet.Cells[R, 1].Value = R - 4;
                            if (DV.Table.Rows[r]["CustomerName"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["CustomerName"].ToString();
                            }
                            if (DV.Table.Rows[r]["ITCLID"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["ITCLID"].ToString();
                            }
                            if (DV.Table.Rows[r]["CardNo"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["CardNo"].ToString();
                            }
                            if (DV.Table.Rows[r]["Member"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["Member"];
                                //worksheet.Cells[R, 5].Style.Numberformat.Format = "#";
                            }
                            if (DV.Table.Rows[r]["Guest"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["Guest"];
                                //worksheet.Cells[R, 6].Style.Numberformat.Format = "#";
                            }
                            if (DV.Table.Rows[r]["Total"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 7].Value = DV.Table.Rows[r]["Total"];
                                //worksheet.Cells[R, 7].Style.Numberformat.Format = "#";
                            }
                            //if (DV.Table.Rows[r]["ChargePerVisit"] != DBNull.Value)
                            //{
                            //    worksheet.Cells[R, 8].Value = DV.Table.Rows[r]["ChargePerVisit"];
                            //    worksheet.Cells[R, 8].Style.Numberformat.Format = "0.00";
                            //}
                            if (DV.Table.Rows[r]["TotalAmount"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 8].Value = DV.Table.Rows[r]["TotalAmount"];
                                worksheet.Cells[R, 8].Style.Numberformat.Format = "0.00";
                            }
                            if (DV.Table.Rows[r]["Waive"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 9].Value = DV.Table.Rows[r]["Waive"];
                                //worksheet.Cells[R, 10].Style.Numberformat.Format = "#";
                            }
                            if (DV.Table.Rows[r]["NoOfCharge"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 10].Value = DV.Table.Rows[r]["NoOfCharge"];
                                //worksheet.Cells[R, 11].Style.Numberformat.Format = "#";
                            }
                            if (DV.Table.Rows[r]["ChargeAmount"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 11].Value = DV.Table.Rows[r]["ChargeAmount"];
                                worksheet.Cells[R, 11].Style.Numberformat.Format = "0.00";
                            }

                        }
                        //worksheet.Cells[R + 1, 5].Formula = "=SUM(E5:E" + R + ")";
                        //worksheet.Cells[R + 1, 6].Formula = "=SUM(F5:F" + R + ")";
                        //worksheet.Cells[R + 1, 7].Formula = "=SUM(G5:G" + R + ")";
                        ////worksheet.Cells[R + 1, 8].Formula = "=SUM(H2:H" + R + ")";
                        //worksheet.Cells[R + 1, 9].Formula = "=SUM(I5:I" + R + ")";
                        //worksheet.Cells[R + 1, 9].Style.Numberformat.Format = "0.00";
                        //worksheet.Cells[R + 1, 10].Formula = "=SUM(J5:J" + R + ")";
                        //worksheet.Cells[R + 1, 11].Formula = "=SUM(K5:K" + R + ")";
                        //worksheet.Cells[R + 1, 12].Formula = "=SUM(L5:L" + R + ")";
                        //worksheet.Cells[R + 1, 12].Style.Numberformat.Format = "0.00";
                        //worksheet.Cells["E" + (R + 1) + ":L" + (R + 1)].Style.Font.Bold = true;
                        //worksheet.Cells["E" + (R + 1) + ":L" + (R + 1)].Style.Font.Size = 14;

                        worksheet.Cells["A1:D1"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;

                        worksheet.Cells["A4:Z4"].Style.Font.Bold = true;
                        worksheet.Cells["A4:Z4"].Style.WrapText = true;
                        worksheet.Cells["B1:B100"].Style.WrapText = true;
                        worksheet.Cells["E:L"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;

                       
                        //Adding Properties
                        xlPackage.Workbook.Properties.Title = "PriorityPassBillSummary";
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
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + "PriorityPassBill" + DateTime.Now + ".xlsx");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.BinaryWrite(content);
                    Response.End();
                    return;

                }
                catch (Exception ex)
                {
                    TrustControl1.ClientMsg(ex.Message);
                }

            }
        }

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

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        decimal TotalMember = 0;
        decimal TotalGuest = 0;
        decimal TotalVisit = 0;
        decimal TotalAmount = 0;
        decimal TotalWaive = 0;
        decimal TotalNoOfCharge = 0;
        decimal TotalChargeAmount = 0;

        try
        {
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                //TrustControl1.ClientMsg(grdvDrCrDetails.Rows[i].Cells[2].Text);
                TotalMember += checkValue(GridView1.Rows[i].Cells[5].Text);
                TotalGuest += checkValue(GridView1.Rows[i].Cells[6].Text);
                TotalVisit += checkValue(GridView1.Rows[i].Cells[7].Text);
                TotalAmount += checkValue(GridView1.Rows[i].Cells[9].Text);
                TotalWaive += checkValue(GridView1.Rows[i].Cells[10].Text);
                TotalNoOfCharge += checkValue(GridView1.Rows[i].Cells[11].Text);
                TotalChargeAmount += checkValue(GridView1.Rows[i].Cells[12].Text);
            }
            GridView1.FooterRow.Cells[4].Text = "Total";
            GridView1.FooterRow.Cells[5].Text = TotalMember.ToString();
            GridView1.FooterRow.Cells[6].Text = TotalGuest.ToString();
            GridView1.FooterRow.Cells[7].Text = TotalVisit.ToString();
            GridView1.FooterRow.Cells[9].Text = TotalAmount.ToString();
            GridView1.FooterRow.Cells[10].Text = TotalWaive.ToString();
            GridView1.FooterRow.Cells[11].Text = TotalNoOfCharge.ToString();
            GridView1.FooterRow.Cells[12].Text = TotalChargeAmount.ToString();           
        }
        catch (Exception exx)
        {           
            //TrustControl1.ClientMsg(exx.Message.ToString());
        }
    }
    private decimal checkValue(string Value)
    {
        if (Value == "&nbsp;")
            return 0;
        else
            return decimal.Parse(Value);

    }

}