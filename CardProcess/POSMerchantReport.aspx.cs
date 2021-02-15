using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;


public partial class POSMerchantReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {      
        TrustControl1.getUserRoles();
        GridView1.DataBind();
        GridView1.Visible = true;
        SqlDataSource1.DataBind();
        Title = "Search";
    }
    protected void downloadxlsx_Click(object sender, EventArgs e)
    {
        try
        {
            string FileName = Path.GetTempFileName();
            if (File.Exists(FileName)) File.Delete(FileName);
            FileInfo FI = new FileInfo(FileName);
            using (ExcelPackage xlPackage = new ExcelPackage(FI))
            {
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("Merchant");
                int StartRow = 1;
                //Adding Title Row
                worksheet.Cells[StartRow, 1].Value = "MerchantID";
                worksheet.Cells[StartRow, 2].Value = "Merchant Name";
                worksheet.Cells[StartRow, 3].Value = "Address";
                worksheet.Cells[StartRow, 4].Value = "MobileNo";
                worksheet.Cells[StartRow, 5].Value = "Merchant Shadow Account";
                worksheet.Cells[StartRow, 6].Value = "Merchant Orginal Account";
                worksheet.Cells[StartRow, 7].Value = "OnUsCommissionPercent";
                worksheet.Cells[StartRow, 8].Value = "OfUsCommissionPercent";
                worksheet.Cells[StartRow, 9].Value = "Status";
                worksheet.Cells[StartRow, 10].Value = "No Of POS";
                worksheet.Cells[StartRow, 11].Value = "SIMInfo";
                worksheet.Cells[StartRow, 12].Value = "POSSerialNo";
                worksheet.Cells[StartRow, 13].Value = "InsertBy";
                worksheet.Cells[StartRow, 14].Value = "Insert On";
                worksheet.Cells[StartRow, 15].Value = "UpdateBy";
                worksheet.Cells[StartRow, 16].Value = "Update On";


                worksheet.Column(1).Width = 12;
                worksheet.Column(2).Width = 35;
                worksheet.Column(3).Width = 20;
                worksheet.Column(4).Width = 20;
                worksheet.Column(5).Width = 15;
                worksheet.Column(6).Width = 15;
                worksheet.Column(7).Width = 15;
                worksheet.Column(8).Width = 15;
                worksheet.Column(9).Width = 15;
                worksheet.Column(10).Width = 15;
                worksheet.Column(11).Width = 15;
                worksheet.Column(12).Width = 15;
                worksheet.Column(13).Width = 15;
                worksheet.Column(14).Width = 15;
                worksheet.Column(15).Width = 15;
                worksheet.Column(16).Width = 15;

                worksheet.Cells[1, 2].Style.WrapText = true;
                worksheet.Cells[1, 5].Style.WrapText = true;

                DataView DV = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {
                    int R = StartRow + r + 1;

                    if (DV.Table.Rows[r]["MerchantID"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["MerchantID"];
                    }

                    if (DV.Table.Rows[r]["MerchantName"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["MerchantName"].ToString();
                        worksheet.Cells[R, 2].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["Address"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["Address"].ToString();
                        worksheet.Cells[R, 3].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["MobileNo"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["MobileNo"].ToString();
                        worksheet.Cells[R, 4].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["MerchantShadowAccNo"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["MerchantShadowAccNo"];
                        worksheet.Cells[R, 5].Style.WrapText = true;
                    }

                    if (DV.Table.Rows[r]["MerchantOrginalAccNo"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["MerchantOrginalAccNo"];
                        worksheet.Cells[R, 6].Style.WrapText = false;
                    }

                    if (DV.Table.Rows[r]["OnUsCommissionPercent"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 7].Value = DV.Table.Rows[r]["OnUsCommissionPercent"];
                        worksheet.Cells[R, 7].Style.WrapText = false;
                    }

                    if (DV.Table.Rows[r]["OfUsCommissionPercent"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 8].Value = DV.Table.Rows[r]["OfUsCommissionPercent"];
                        //worksheet.Cells[R, 6].Style.Numberformat.Format = "dd/MM/yyyy";
                    }

                    if (DV.Table.Rows[r]["Status"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 9].Value = DV.Table.Rows[r]["Status"].ToString();

                    }

                    if (DV.Table.Rows[r]["NoOfPOS"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 10].Value = DV.Table.Rows[r]["NoOfPOS"];
                        worksheet.Cells[R, 10].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["SIMInfo"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 11].Value = DV.Table.Rows[r]["SIMInfo"];
                        worksheet.Cells[R, 11].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["POSSerialNo"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 12].Value = DV.Table.Rows[r]["POSSerialNo"];
                        worksheet.Cells[R, 12].Style.WrapText = false;
                    }

                    if (DV.Table.Rows[r]["InsertBy"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 13].Value = DV.Table.Rows[r]["InsertBy"].ToString();
                        worksheet.Cells[R, 13].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["InsertDT"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 14].Value = DV.Table.Rows[r]["InsertDT"];
                        worksheet.Cells[R, 14].Style.Numberformat.Format = "dd/MM/yyyy";
                    }
                    if (DV.Table.Rows[r]["UpdateBy"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 15].Value = DV.Table.Rows[r]["UpdateBy"].ToString();
                        worksheet.Cells[R, 15].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["UpdateDT"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 16].Value = DV.Table.Rows[r]["UpdateDT"];
                        worksheet.Cells[R, 16].Style.Numberformat.Format = "dd/MM/yyyy";

                    }



                }
                worksheet.Cells["A1:G1"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["A1:A"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                //worksheet.Cells["A1:B"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                worksheet.Cells["C1:C"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["D1:D"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["E1:E"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["F1:F"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                worksheet.Cells["G1:G"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                worksheet.Cells["I1:I"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                worksheet.Cells["K1:K"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                worksheet.Cells["F1:F"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["A1:H"].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Top;

                //worksheet.Cells["G1:M1"].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.ri;
                //
                worksheet.Cells["A1:P1"].Style.Font.Bold = true;


                //Adding Properties
                xlPackage.Workbook.Properties.Title = "Merchant";
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
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "Merchant.xlsx");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(content);
            Response.End();
        }
        catch (Exception ex)
        {
            //lblStatus.Text = ex.Message;
        }

    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Visible = e.AffectedRows > 0;
         lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
        downloadxlsx.Visible = e.AffectedRows > 0;


    }
    protected void cmdFilter_Click(object sender, EventArgs e)
    {
        //TrustControl1.ClientMsg(e)
        GridView1.DataBind();
    }

    protected void cmdExport_Click1(object sender, EventArgs e)
    {
        //Response.Redirect("Dispute_Search.aspx?type='xlsx'", true);
        //SqlDataSourceReExportActivation.Select(DataSourceSelectArguments.Empty);
        string FileName = Path.GetTempFileName();
        try
        {
            //FileName = "C:\\1.xlsx";
            FileInfo FI = new FileInfo(FileName);
            if (File.Exists(FileName)) File.Delete(FileName);
            using (ExcelPackage xlPackage = new ExcelPackage(FI))
            {
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("Disputes");
                int StartRow = 1;

                //Adding Title Row
                worksheet.Column(1).Width = 15;
                worksheet.Column(2).Width = 20;
                worksheet.Column(3).Width = 20;
                worksheet.Column(4).Width = 25;
                worksheet.Column(5).Width = 20;
                worksheet.Column(6).Width = 20;
                worksheet.Column(7).Width = 20;
                worksheet.Column(8).Width = 15;
                worksheet.Column(9).Width = 15;
                worksheet.Column(10).Width = 15;
                worksheet.Column(11).Width = 25;
                worksheet.Column(12).Width = 15;
                worksheet.Column(13).Width = 15;
                worksheet.Column(14).Width = 25;

                worksheet.Cells["A1:Z1"].Style.Font.Bold = true;



                //Adding Title Row
                worksheet.Cells[StartRow, 1].Value = "Dispute ID";
                worksheet.Cells[StartRow, 2].Value = "Card Number";
                worksheet.Cells[StartRow, 3].Value = "Account";
                worksheet.Cells[StartRow, 4].Value = "Customer Name";
                worksheet.Cells[StartRow, 5].Value = "Txn Date";
                worksheet.Cells[StartRow, 6].Value = "Txn Amount";
                worksheet.Cells[StartRow, 7].Value = "Dispute Amount";
                worksheet.Cells[StartRow, 8].Value = "Trance No";
                worksheet.Cells[StartRow, 9].Value = "Approval Code";
                worksheet.Cells[StartRow, 10].Value = "Terminal ID";
                worksheet.Cells[StartRow, 11].Value = "Bank Name";
                worksheet.Cells[StartRow, 12].Value = "NPSB Code";
                worksheet.Cells[StartRow, 13].Value = "Status";
                worksheet.Cells[StartRow, 14].Value = "Request Branch";

                DataView DV = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                int R = 1;
                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {
                    R = R + 1;

                    if (DV.Table.Rows[r]["ID"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["ID"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["CardNo"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["CardNo"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["AccNo"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["AccNo"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["CustomerName"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["CustomerName"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["TxnDate"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["TxnDate"].ToString();
                        worksheet.Cells[R, 5].Style.Numberformat.Format = "MMM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["TxnAmount"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["TxnAmount"];
                        //worksheet.Cells[R, 6].Style.Numberformat.Format = "#.##";
                    }
                    if (DV.Table.Rows[r]["DisputeAmount"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 7].Value = DV.Table.Rows[r]["DisputeAmount"];
                        //worksheet.Cells[R, 6].Style.Numberformat.Format = "#.##";
                    }
                    if (DV.Table.Rows[r]["TraceNo"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 8].Value = DV.Table.Rows[r]["TraceNo"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }

                    if (DV.Table.Rows[r]["ApprovalCode"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 9].Value = DV.Table.Rows[r]["ApprovalCode"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["TerminalID"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 10].Value = DV.Table.Rows[r]["TerminalID"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["Bank_Name"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 11].Value = DV.Table.Rows[r]["Bank_Name"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["NPSBCode"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 12].Value = DV.Table.Rows[r]["NPSBCode"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["StatusName"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 13].Value = DV.Table.Rows[r]["StatusName"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["BranchName"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 14].Value = DV.Table.Rows[r]["BranchName"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                }


                worksheet.Cells["A1:Z" + R].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["F1:F"].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;

                //Adding Properties
                xlPackage.Workbook.Properties.Title = "Disputes";
                xlPackage.Workbook.Properties.Author = "Sadrul Alom";
                xlPackage.Workbook.Properties.Company = "Trust Bank Limited";
                //xlPackage.Workbook.Properties.LastModifiedBy = string.Format("{0} ({1})", Session["FULLNAME"], Session["EMAIL"]);

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
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "Disputes_" + DateTime.Now.ToString() + ".xlsx");
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
