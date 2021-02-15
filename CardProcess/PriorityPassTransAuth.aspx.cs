﻿using OfficeOpenXml;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PriorityPassTransAuth : System.Web.UI.Page
{
    string Msg = "";
    bool Done = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();        

        Title = "Priority Pass Trans Authorization";

        //if (!IsPostBack)
        //    txtYMID.Text = (DateTime.Now.AddMonths(-1)).Year.ToString() + DateTime.Now.AddMonths(-1).ToString("MM");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        downloadxlsx.Visible= e.AffectedRows > 0;
        lblStatus.Visible = e.AffectedRows > 0;
        lblStatus.Text = string.Format("Total: <b>{0}</b><br /><br />", e.AffectedRows);

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
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("Priority Pass Trans");
                int StartRow = 1;

                //Adding Title Row
                worksheet.Column(1).Width = 12;
                worksheet.Column(2).Width = 15;
                worksheet.Column(3).Width = 35;
                worksheet.Column(4).Width = 25;
                worksheet.Column(5).Width = 15;
                worksheet.Column(6).Width = 12;
                worksheet.Column(7).Width = 17;
                worksheet.Column(8).Width = 17;
                worksheet.Column(9).Width = 12;
                worksheet.Column(10).Width = 12;
                worksheet.Column(11).Width = 12;
                //worksheet.Column(12).Width = 12;
                //worksheet.Column(13).Width = 12;
                //worksheet.Column(14).Width = 12;
                //worksheet.Column(15).Width = 12;
                //worksheet.Column(16).Width = 12;
                //worksheet.Column(17).Width = 12;
                //worksheet.Column(18).Width = 12;
                //worksheet.Column(19).Width = 12;
                worksheet.Cells["A1:Y1"].Style.Font.Bold = true;
                worksheet.Cells["A1:Y1"].Style.WrapText = true;


                //Adding Title Row
                worksheet.Cells[StartRow, 1].Value = "Billing Month";
                worksheet.Cells[StartRow, 2].Value = "Card No.";
                worksheet.Cells[StartRow, 3].Value = "Lounge Name";
                worksheet.Cells[StartRow, 4].Value = "Country";
                worksheet.Cells[StartRow, 5].Value = "Terminal";
                worksheet.Cells[StartRow, 6].Value = "City";
                worksheet.Cells[StartRow, 7].Value = "Visit Date";
                worksheet.Cells[StartRow, 8].Value = "Visit Member";
                worksheet.Cells[StartRow, 9].Value = "Visit Guest";
                worksheet.Cells[StartRow, 10].Value = "Bill Amount";
                worksheet.Cells[StartRow, 11].Value = "Remarks";
                //worksheet.Cells[StartRow, 9].Value = "NoOfVisitGuest";
                //worksheet.Cells[StartRow, 9].Value = "NoOfVisitGuest";
                //worksheet.Cells[StartRow, 9].Value = "NoOfVisitGuest";
                //worksheet.Cells[StartRow, 9].Value = "NoOfVisitGuest";
                //worksheet.Cells[StartRow, 9].Value = "NoOfVisitGuest";
                //worksheet.Cells[StartRow, 9].Value = "NoOfVisitGuest";
                //worksheet.Cells[StartRow, 9].Value = "NoOfVisitGuest";
                //worksheet.Cells[StartRow, 9].Value = "NoOfVisitGuest";
                //worksheet.Cells[StartRow, 9].Value = "NoOfVisitGuest";
                int R;

                DataView DV = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {
                    R = StartRow + r + 1;

                    if (DV.Table.Rows[r]["BillingMonth"] != DBNull.Value)
                        worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["BillingMonth"].ToString();
                    if (DV.Table.Rows[r]["CardNo"] != DBNull.Value)
                        worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["CardNo"].ToString();
                    if (DV.Table.Rows[r]["LoungeName"] != DBNull.Value)
                        worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["LoungeName"].ToString();
                    if (DV.Table.Rows[r]["Country"] != DBNull.Value)
                        worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["Country"].ToString();
                    if (DV.Table.Rows[r]["Terminal"] != DBNull.Value)
                        worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["Terminal"].ToString();
                    if (DV.Table.Rows[r]["City"] != DBNull.Value)
                        worksheet.Cells[R, 6].Value = DV.Table.Rows[r]["City"].ToString();
                    if (DV.Table.Rows[r]["VisitDate"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 7].Value = DV.Table.Rows[r]["VisitDate"];
                        worksheet.Cells[R, 7].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["NoOfVisitMember"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 8].Value = DV.Table.Rows[r]["NoOfVisitMember"].ToString();
                       // worksheet.Cells[R, 8].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["NoOfVisitGuest"] != DBNull.Value)
                        worksheet.Cells[R, 9].Value = DV.Table.Rows[r]["NoOfVisitGuest"].ToString();
                    if(DV.Table.Rows[r]["BillAmount"] != DBNull.Value)
                        worksheet.Cells[R, 10].Value = DV.Table.Rows[r]["BillAmount"].ToString();
                    if(DV.Table.Rows[r]["Remarks"] != DBNull.Value)
                        worksheet.Cells[R, 11].Value = DV.Table.Rows[r]["Remarks"].ToString();
                }

                worksheet.Cells["A1:I"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["I1:I"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                worksheet.Cells["F1:F"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                worksheet.Cells["E1:E"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;

                //Adding Properties
                xlPackage.Workbook.Properties.Title = "Priority Pass Trans" + DateTime.Now.ToString();
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
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "Priority_Pass_Trans" + DateTime.Now.ToString() + ".xlsx");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(content);
            Response.End();
        }
        catch (Exception exx) { TrustControl1.ClientMsg(exx.Message); }

    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Authorize")
            {
                string ID = e.CommandArgument.ToString();

                string Msg = "";
                bool done = false;

                using (SqlConnection conn = new SqlConnection())
                {
                    string Query = "s_PriorityPassTransaction_Auth";
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = Query;
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add("@ID", System.Data.SqlDbType.VarChar).Value = ID;
                        cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();                        

                        SqlParameter Sql_Msg = new SqlParameter("@Msg", System.Data.SqlDbType.VarChar, 255);
                        Sql_Msg.Direction = System.Data.ParameterDirection.InputOutput;
                        Sql_Msg.Value = Msg;
                        cmd.Parameters.Add(Sql_Msg);

                        SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                        SQL_Done.Direction = ParameterDirection.InputOutput;
                        SQL_Done.Value = done;
                        cmd.Parameters.Add(SQL_Done);

                        cmd.Connection = conn;
                        conn.Open();

                        cmd.ExecuteNonQuery();
                        Msg = string.Format("{0}", Sql_Msg.Value);
                    }
                }

                TrustControl1.ClientMsg(Msg);
                GridView1.DataBind();

            }

        }
        catch (Exception exx) { TrustControl1.ClientMsg(exx.Message); }
    }

    
}
