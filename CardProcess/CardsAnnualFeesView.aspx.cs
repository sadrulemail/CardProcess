﻿using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CardsAnnualFeesView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.LoadEmpToSession(false);

        //if (Session["BRANCHID"].ToString() != "1")
        //    if (Session["BRANCHID"].ToString() != string.Format("{0}", Request.QueryString["branch"]))
        //    {
        //        Response.End();
        //        return;
        //    }

        this.Title = string.Format("Batch: {0}", Request.QueryString["batchid"]);
        if(!IsPostBack)
        hidBatch.Value = Request.QueryString["batchid"];
    }
    protected void GridView3_SelectedIndexChanged(object sender, EventArgs e)
    {
       DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
    }
    protected void SqlDataSource4_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            string Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
            TrustControl1.ClientMsg(Msg);

            GridView3.DataBind();
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }

    protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        TrustControl1.ClientMsg(Msg);
        GridView1.DataBind();        
    }

    protected void downloadxlsx_Click(object sender, EventArgs e)
    {
        string FileName = Path.GetTempFileName();
        try
        {
            FileInfo FI = new FileInfo(FileName);
            if (File.Exists(FileName)) File.Delete(FileName);
            using (ExcelPackage xlPackage = new ExcelPackage(FI))
            {
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("Card Annual Fees");
                int StartRow = 1;

                //Adding Title Row
                worksheet.Column(1).Width = 20;
                worksheet.Column(2).Width = 18;
                worksheet.Column(3).Width = 35;
                worksheet.Column(4).Width = 12;
                worksheet.Column(5).Width = 12;
                worksheet.Column(6).Width = 12;

                worksheet.Cells["A1:K1"].Style.Font.Bold = true;
                worksheet.Cells["A1:K1"].Style.WrapText = true;


                //Adding Title Row
                worksheet.Cells[StartRow, 1].Value = "CardNo";
                worksheet.Cells[StartRow, 2].Value = "Account";
                worksheet.Cells[StartRow, 3].Value = "Customer Name";
                worksheet.Cells[StartRow, 4].Value = "Creation Date";
                worksheet.Cells[StartRow, 5].Value = "Card Status";
                worksheet.Cells[StartRow, 6].Value = "Annual Fees";
                int R;

                DataView DV = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {
                    R = StartRow + r + 1;

                    if (DV.Table.Rows[r]["CardNumber"] != DBNull.Value)
                        worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["CardNumber"].ToString();
                    if (DV.Table.Rows[r]["AccountNumber"] != DBNull.Value)
                        worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["AccountNumber"].ToString();
                    if (DV.Table.Rows[r]["CardHolderName"] != DBNull.Value)
                        worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["CardHolderName"].ToString();
                    if (DV.Table.Rows[r]["CreationDate"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["CreationDate"];
                        worksheet.Cells[R, 4].Style.Numberformat.Format = "MM/dd/yyyy";                   }
                   
                    if (DV.Table.Rows[r]["CardStatus"] != DBNull.Value)
                        worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["CardStatus"].ToString();
                    if (DV.Table.Rows[r]["AnnualFees"] != DBNull.Value)
                        worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["AnnualFees"].ToString();

                }

                worksheet.Cells["A1:I"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["I1:I"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["F1:F"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                worksheet.Cells["E1:E"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["K1:K"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                //Adding Properties
                xlPackage.Workbook.Properties.Title = "CardAnnualFees" + DateTime.Now.Date.ToString("dd/MM/yyyy");
                xlPackage.Workbook.Properties.Author = "Sadrul(sadrul.email@gmail.com)";
                xlPackage.Workbook.Properties.Company = "Trust Bank Limited";
                xlPackage.Workbook.Properties.LastModifiedBy = string.Format("{0} ({1})", Session["FULLNAME"], "sadrul.email@gmail.com");

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
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "CardAnnualFees_" + DateTime.Now.Date.ToString("dd/MM/yyyy") + ".xlsx");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(content);
            Response.End();
        }
        catch (Exception exx) { TrustControl1.ClientMsg(exx.Message); }

    }
    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Visible = e.AffectedRows > 0;
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }
    protected void SqlDataSource2_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        Label1.Visible = e.AffectedRows > 0;
        Label1.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }
    protected void GridView2_DataBound(object sender, EventArgs e)
    {
        decimal Credit = 0;
        decimal Debit = 0;
        try
        {
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                Credit += checkValue(GridView2.Rows[i].Cells[2].Text);
                Debit += checkValue(GridView2.Rows[i].Cells[3].Text);
            }
            GridView2.FooterRow.Cells[1].Text = "Total";
            GridView2.FooterRow.Cells[2].Text = Credit.ToString();
            GridView2.FooterRow.Cells[3].Text = Debit.ToString();
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