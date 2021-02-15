using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using OfficeOpenXml;

public partial class CardMobileEmailAddressView : System.Web.UI.Page
{
    public DataSet ds=new DataSet();
   public decimal TotalCr=0;
    public decimal TotalDr=0;
    string batch ;
    string file;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            batch = Request.QueryString["batchid"].ToString();
            file = Request.QueryString["file"].ToString();
            if (!IsPostBack && batch != null && file == "xlsx")
            {

                string FileName = Path.GetTempFileName();
                if (File.Exists(FileName)) File.Delete(FileName);
                FileInfo FI = new FileInfo(FileName);
                using (ExcelPackage xlPackage = new ExcelPackage(FI))
                {
                    ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("ME");
                    int StartRow = 1;

                    //Adding Title Row
                    worksheet.Cells[StartRow, 1].Value = "ME";

                    worksheet.Column(1).Width = 30;

                    DataView DV = (DataView)SqlDataSourceDataUploadLog.Select(DataSourceSelectArguments.Empty);
                    for (int r = 0; r < DV.Table.Rows.Count; r++)
                    {
                        int R = StartRow + r + 1;
                        //worksheet.Cells[R, 1].Value = r + 1;
                        if (DV.Table.Rows[r]["ME"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["ME"].ToString();
                        }
                    }
                    worksheet.Cells["A1:K1"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                    worksheet.Cells["A1:K1"].Style.Font.Bold = true;

                    //Adding Properties
                    xlPackage.Workbook.Properties.Title = "mobile";
                    xlPackage.Workbook.Properties.Author = string.Format("{0}", Session["EMPNAME"]);
                    xlPackage.Workbook.Properties.Company = "Trust Bank Limited";
                    xlPackage.Workbook.Properties.LastModifiedBy = string.Format("{0}", Session["EMPNAME"]);

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
                Response.AddHeader("Content-Disposition", "attachment;filename=" +
                    "MobileEmail.xlsx"
                    );
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.BinaryWrite(content);
                Response.End();
            }
            else if(!IsPostBack && batch != null && file == "view")
            {
                GridView2.DataBind();
            }
        }
        catch(Exception exx) { }
        }


    protected void btnDownload_Click(object sender, EventArgs e)
    {    
    
            Response.Redirect("CardMobileEmailAddressView.aspx?batchid=" + batch + "&type=M&file=xlsx");
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //lblCount.Visible = e.AffectedRows > 0;
        //lblCount.Text = "Total Record(s):<b>" + e.AffectedRows.ToString() + "</b>";

    }

   
}