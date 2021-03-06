﻿using OfficeOpenXml;
using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CardSummary : System.Web.UI.Page
{
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (!IsPostBack)
        {
           
            txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date.AddMonths(-1));
            txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        }
        else
            GridView1.Visible = true;
       
    }  
    
    protected void cboBranch_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in cboBranch.Items)
            i.Selected = false;

        if (Session["BRANCHID"].ToString() != "1")
        {
            foreach (ListItem ii in cboBranch.Items)
            {
                if (ii.Value == Session["BRANCHID"].ToString())
                    ii.Selected = true;
                else
                    ii.Enabled = false;
            }
        }

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
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("CardSummary");
                int StartRow = 1;

                //Adding Title Row
                worksheet.Column(1).Width = 15;
                worksheet.Column(2).Width = 30;
                worksheet.Column(3).Width = 20;
                worksheet.Column(4).Width = 15;
                worksheet.Column(5).Width = 20;
               

                worksheet.Cells["A1:Z1"].Style.Font.Bold = true;



                //Adding Title Row
                worksheet.Cells[StartRow, 1].Value = "BranchID";
                worksheet.Cells[StartRow, 2].Value = "Branch Name";
                worksheet.Cells[StartRow, 3].Value = "TotalIssueCard";
                worksheet.Cells[StartRow, 4].Value = "TotalBranchReissueCard";
                worksheet.Cells[StartRow, 5].Value = "TotalIssueSupplCard";
                
                DataView DV = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                int R = 1;
                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {
                    R = R + 1;

                    if (DV.Table.Rows[r]["BranchID"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["BranchID"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["BranchName"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["BranchName"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["TotalIssueCard"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["TotalIssueCard"];
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["TotalBranchReissueCard"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["TotalBranchReissueCard"];
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["TotalIssueSupplCard"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["TotalIssueSupplCard"];
                        //worksheet.Cells[R, 6].Style.Numberformat.Format = "#.##";
                    }                    
                }


                worksheet.Cells["A1:Z" + R].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["F1:F"].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;

                //Adding Properties
                xlPackage.Workbook.Properties.Title = "CardSummary";
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
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "CardSummary_" + DateTime.Now.ToString() + ".xlsx");
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


    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        cmdExport.Visible = e.AffectedRows > 0;
    }
}
    
   
