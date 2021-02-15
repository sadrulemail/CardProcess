using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;


public partial class CreditCard_Summary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtIssueDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date.AddDays(-1));
            txtIssueDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        }
        TrustControl1.getUserRoles();
         

        Title = "Credit Card Summary";
     
    }

 
    protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        Button1.Visible = e.AffectedRows > 0;
    }
    protected void cmdFilter_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
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

    protected void Button1_Click1(object sender, EventArgs e)
    {
        
        string FileName = Path.GetTempFileName();
        try
        {           
            FileInfo FI = new FileInfo(FileName);
            if (File.Exists(FileName)) File.Delete(FileName);
            using (ExcelPackage xlPackage = new ExcelPackage(FI))
            {
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("Summary_CreditCardInfo");
                int StartRow = 1;

                //Adding Title Row
                worksheet.Column(1).Width = 25;
                worksheet.Column(2).Width = 15;
                worksheet.Column(3).Width = 15;
                worksheet.Column(4).Width = 15;
                worksheet.Column(5).Width = 15;
                worksheet.Column(6).Width = 15;
                worksheet.Column(7).Width = 15;
                
               

                worksheet.Cells["A1:Z1"].Style.Font.Bold = true;


                //Adding Title Row
                worksheet.Cells[StartRow, 1].Value = "BranchName";
                worksheet.Cells[StartRow, 2].Value = "PREPAID CARD";
                worksheet.Cells[StartRow, 3].Value = "HAJJ CARD";
                worksheet.Cells[StartRow, 4].Value = "PIN REISSUE";
                worksheet.Cells[StartRow, 5].Value = "SUPPLY CARD";
                worksheet.Cells[StartRow, 6].Value = "REISSUE CARD";
                worksheet.Cells[StartRow, 7].Value = "NEW CARD";
               


                DataView DV = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
                int R = 1;
                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {
                    R = R + 1;

                    if (DV.Table.Rows[r]["BranchName"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["BranchName"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["PREPAID CARD"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["PREPAID CARD"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["HAJJ CARD"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["HAJJ CARD"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["PIN REISSUE"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["PIN REISSUE"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["SUPPLY CARD"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["SUPPLY CARD"].ToString();
                        //worksheet.Cells[R, 5].Style.Numberformat.Format = "MMM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["REISSUE CARD"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["REISSUE CARD"];
                        //worksheet.Cells[R, 6].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["NEW CARD"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 7].Value = DV.Table.Rows[r]["NEW CARD"];
                        //worksheet.Cells[R, 6].Style.Numberformat.Format = "#.##";
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
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "CreditCard_Summary_" + DateTime.Now.ToString() + ".xlsx");
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
