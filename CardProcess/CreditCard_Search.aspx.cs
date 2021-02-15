﻿using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;


public partial class CreditCard_Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtIssueDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date.AddDays(-1));
            txtIssueDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        }
        TrustControl1.getUserRoles();
        GridView1.DataBind();
        GridView1.Visible = true;

        SqlDataSource1.DataBind();

        Title = "Credit Card";

        //if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["type"]))
        //{
            
        //}
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "OPEN")
        {
            Response.Redirect("~/Dispute.aspx?ID=" + e.CommandArgument, true);
        }
    }
   
    
   
    protected void cboBranch_DataBound(object sender, EventArgs e)
    {
        //foreach (ListItem i in cboBranch.Items)

        //    i.Selected = false;


        //if (Session["BRANCHID"].ToString() != "1")
        //{
        //    foreach (ListItem ii in cboBranch.Items)
        //    {
        //        if (ii.Value == Session["BRANCHID"].ToString())
        //            ii.Selected = true;
        //        else
        //            ii.Enabled = false;
        //    }
        //}

    }
    protected void DropDownListIssueBranch_DataBound(object sender, EventArgs e)
    {
        //foreach (ListItem i in cboBranch.Items)

        //    i.Selected = false;


        //if (Session["BRANCHID"].ToString() != "1")
        //{
        //    foreach (ListItem ii in cboBranch.Items)
        //    {
        //        if (ii.Value == Session["BRANCHID"].ToString())
        //            ii.Selected = true;
        //        else
        //            ii.Enabled = false;
        //    }
        //}

    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
        if (e.AffectedRows > 0)
            cmdExport.Visible = true;
        else
            cmdExport.Visible = false;
    }
   
    protected void cmdFilter_Click(object sender, EventArgs e)
    {
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
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("CreditCardInfo");
                int StartRow = 1;

                //Adding Title Row
                worksheet.Column(1).Width = 15;
                worksheet.Column(2).Width = 20;
                worksheet.Column(3).Width = 25;
                worksheet.Column(4).Width = 20;
                worksheet.Column(5).Width = 20;
                worksheet.Column(6).Width = 20;
                worksheet.Column(7).Width = 20;
                worksheet.Column(8).Width = 15;
                worksheet.Column(9).Width = 30;
                
                worksheet.Cells["A1:Z1"].Style.Font.Bold = true;


                //Adding Title Row
                worksheet.Cells[StartRow, 1].Value = "ITCLID";
                worksheet.Cells[StartRow, 2].Value = "Card Number";
                worksheet.Cells[StartRow, 3].Value = "Name";
                worksheet.Cells[StartRow, 4].Value = "Issue Type";
                worksheet.Cells[StartRow, 5].Value = "Issue Date";
                worksheet.Cells[StartRow, 6].Value = "Receive Date";
                worksheet.Cells[StartRow, 7].Value = "Delivery Branch";
                worksheet.Cells[StartRow, 8].Value = "Delivery Date";
                worksheet.Cells[StartRow, 9].Value = "Remarks";
                

                DataView DV = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                int R = 1;
                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {
                    R = R + 1;

                    if (DV.Table.Rows[r]["ITCLID"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["ITCLID"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["CardNumber"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["CardNumber"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["CardHolderName"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["CardHolderName"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["IssueType"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["IssueType"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["IssueDate"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["IssueDate"].ToString();
                        worksheet.Cells[R, 5].Style.Numberformat.Format = "MMM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["ReceiveDate"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["ReceiveDate"];
                        worksheet.Cells[R, 6].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["BranchName"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 7].Value = DV.Table.Rows[r]["BranchName"];
                        //worksheet.Cells[R, 6].Style.Numberformat.Format = "#.##";
                    }
                    if (DV.Table.Rows[r]["DeliveryDate"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 8].Value = DV.Table.Rows[r]["DeliveryDate"].ToString();
                        worksheet.Cells[R, 8].Style.Numberformat.Format = "MM/dd/yyyy";
                    }

                    if (DV.Table.Rows[r]["Remarks"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 9].Value = DV.Table.Rows[r]["Remarks"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                   
                }


                worksheet.Cells["A1:Z" + R].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["F1:F"].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;

                //Adding Properties
                xlPackage.Workbook.Properties.Title = "CreditCard";
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
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "CreditCard_" + DateTime.Now.ToString() + ".xlsx");
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
