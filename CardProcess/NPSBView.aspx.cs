using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using OfficeOpenXml;
using System.Data;

public partial class NPSBView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.LoadEmpToSession(false);
        this.Title = string.Format("Settlement: {0}", Request.QueryString["batchid"]);
    }
    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
        if (e.AffectedRows > 0)
            cmdExport.Visible = true;
        else
            cmdExport.Visible = false;
    }

    protected void cmdExport_Click(object sender, EventArgs e)
    {
        try
        {
            string FileName = Path.GetTempFileName();
            if (File.Exists(FileName)) File.Delete(FileName);
            FileInfo FI = new FileInfo(FileName);
            using (ExcelPackage xlPackage = new ExcelPackage(FI))
            {
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("NPSB");
                int StartRow = 1;
                //Adding Title Row

                
                worksheet.Cells[StartRow, 1].Value = "Type";
                worksheet.Cells[StartRow, 2].Value = "Source";
                worksheet.Cells[StartRow, 3].Value = "MTI";
                worksheet.Cells[StartRow, 4].Value = "Msg Description";
                worksheet.Cells[StartRow, 5].Value = "Msg Code";
                worksheet.Cells[StartRow, 6].Value = "RRN";
                worksheet.Cells[StartRow, 7].Value = "Auth Code";
                worksheet.Cells[StartRow, 8].Value = "Merchant";
                worksheet.Cells[StartRow, 9].Value = "Card No";
                worksheet.Cells[StartRow, 10].Value = "Local DT";
                worksheet.Cells[StartRow, 11].Value = "Creation DT";
                worksheet.Cells[StartRow, 12].Value = "Amount";
                worksheet.Cells[StartRow, 13].Value = "ATM ID";
                worksheet.Cells[StartRow, 14].Value = "Issuer";
                worksheet.Cells[StartRow, 15].Value = "Acquirer";
                worksheet.Cells[StartRow, 16].Value = "Dispute_ReasonCode";
                worksheet.Cells[StartRow, 17].Value = "Dispute_ReasonDetails";
                worksheet.Cells[StartRow, 18].Value = "Parm_WHAT_TRX";
                worksheet.Cells[StartRow, 19].Value = "Parm_SRVC";

                worksheet.Column(1).Width = 20;
                worksheet.Column(2).Width = 8;
                worksheet.Column(3).Width = 8;
                worksheet.Column(4).Width = 30;
                worksheet.Column(5).Width = 10;
                worksheet.Column(6).Width = 15;
                worksheet.Column(7).Width = 10;
                worksheet.Column(8).Width = 30;
                worksheet.Column(9).Width = 20;
                worksheet.Column(10).Width = 25;
                worksheet.Column(11).Width = 25;
                worksheet.Column(12).Width = 12;
                worksheet.Column(13).Width = 22;
                worksheet.Column(14).Width = 10;
                worksheet.Column(15).Width = 10;
                worksheet.Column(16).Width = 20;
                worksheet.Column(17).Width = 30;
                worksheet.Column(18).Width = 15;
                worksheet.Column(19).Width = 15;

                worksheet.Cells[1, 2].Style.WrapText = true;
                worksheet.Cells[1, 5].Style.WrapText = true;

                DataView DV = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);


                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {
                    int R = StartRow + r + 1;

                    if (DV.Table.Rows[r]["request_type"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["request_type"];
                    }


                    if (DV.Table.Rows[r]["Transaction_Source"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["Transaction_Source"].ToString();
                        worksheet.Cells[R, 2].Style.WrapText = false;
                    }

                    if (DV.Table.Rows[r]["Description"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["Description"];
                        worksheet.Cells[R, 3].Style.WrapText = false;
                    }

                    if (DV.Table.Rows[r]["Msg_Code_Description"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["Msg_Code_Description"];
                        worksheet.Cells[R, 4].Style.WrapText = false;
                    }

                    if (DV.Table.Rows[r]["MsgCode"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["MsgCode"].ToString();
                        worksheet.Cells[R, 5].Style.WrapText = false;
                    }

                    if (DV.Table.Rows[r]["RRN"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["RRN"].ToString();
                        //worksheet.Cells[R, 6].Style.Numberformat.Format = "dd/MM/yyyy";
                    }

                    if (DV.Table.Rows[r]["AuthCode"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 7].Value = DV.Table.Rows[r]["AuthCode"].ToString();

                    }

                    if (DV.Table.Rows[r]["MerchantName"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 8].Value = DV.Table.Rows[r]["MerchantName"];
                        worksheet.Cells[R, 8].Style.WrapText = false;
                    }

                    if (DV.Table.Rows[r]["CardNumber"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 9].Value = DV.Table.Rows[r]["CardNumber"].ToString();
                        worksheet.Cells[R, 9].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["LocalDt"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 10].Value = DV.Table.Rows[r]["LocalDt"].ToString();
                        worksheet.Cells[R, 10].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["CreationDate"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 11].Value = DV.Table.Rows[r]["CreationDate"].ToString();
                        worksheet.Cells[R, 11].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["TransactionAmount"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 12].Value = DV.Table.Rows[r]["TransactionAmount"];
                        worksheet.Cells[R, 12].Style.WrapText = false;

                    }
                    if (DV.Table.Rows[r]["ATM_ID"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 13].Value = DV.Table.Rows[r]["ATM_ID"];
                        worksheet.Cells[R, 13].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["Issuer"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 14].Value = DV.Table.Rows[r]["Issuer"];
                        worksheet.Cells[R, 14].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["Acquirer"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 15].Value = DV.Table.Rows[r]["Acquirer"];
                        worksheet.Cells[R, 15].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["Dispute_ReasonCode"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 16].Value = DV.Table.Rows[r]["Dispute_ReasonCode"];
                        worksheet.Cells[R, 16].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["Dispute_ReasonDetails"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 17].Value = DV.Table.Rows[r]["Dispute_ReasonDetails"];
                        worksheet.Cells[R, 17].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["Parm_WHAT_TRX"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 18].Value = DV.Table.Rows[r]["Parm_WHAT_TRX"];
                        worksheet.Cells[R, 18].Style.WrapText = false;
                    }
                    if (DV.Table.Rows[r]["Parm_SRVC"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 19].Value = DV.Table.Rows[r]["Parm_SRVC"];
                        worksheet.Cells[R, 19].Style.WrapText = false;
                    }


                }
                worksheet.Cells["A1:G1"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["A1:A"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                worksheet.Cells["A1:B"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
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
                
                worksheet.Cells["A1:Z1"].Style.Font.Bold = true;


                //Adding Properties
                xlPackage.Workbook.Properties.Title = "NPSB";
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
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "NPSB.xlsx");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(content);
            Response.End();
        }
        catch (Exception ex)
        {
            lblStatus.Text = ex.Message;
        }
    }
}