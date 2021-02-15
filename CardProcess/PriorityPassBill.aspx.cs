﻿using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web;
using System.Web.UI;
using System.Text;
using System.Data;
using OfficeOpenXml;
using System.IO;


public partial class PriorityPassBill : System.Web.UI.Page
{
    string Msg = "";
    bool Done = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        Title = "Priority Pass Bill";

        //TrustControl1.ClientMsg(Session["BRANCHID"].ToString());
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblstatus.Visible = e.AffectedRows > 0;
        lblstatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }

    public bool DeleteEnabled(object _BillDate, object _CurrentDate)
    {
        try
        {
            DateTime BillDate = ((DateTime)Eval("BillDate")).AddDays(200);
            DateTime CurrentDate = (DateTime)Eval("CurrentDate");

            if (DateTime.Compare(BillDate, CurrentDate) > 1 && Session["BRANCHID"].ToString() == "1")
                return true;
            else
                return false;
        }
        catch (Exception)
        {
            return false;
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "GenerateBill")
        {
            string ID = e.CommandArgument.ToString();

            string Msg = "";
            bool Done = false;
            using (SqlConnection conn = new SqlConnection())
            {
                string Query = "s_GeneratePriorityPassBill";
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = Query;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@BillingMonth", System.Data.SqlDbType.Int).Value = ID;
                    cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();

                    SqlParameter Sql_Msg = new SqlParameter("@Msg", System.Data.SqlDbType.VarChar, 255);
                    Sql_Msg.Direction = System.Data.ParameterDirection.InputOutput;
                    Sql_Msg.Value = Msg;
                    cmd.Parameters.Add(Sql_Msg);

                    SqlParameter Sql_Done = new SqlParameter("@Done", System.Data.SqlDbType.Bit);
                    Sql_Done.Direction = System.Data.ParameterDirection.InputOutput;
                    Sql_Done.Value = Done;
                    cmd.Parameters.Add(Sql_Done);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();
                    Msg = string.Format("{0}", Sql_Msg.Value);
                    Done = (bool)Sql_Done.Value;
                }
            }

            GridView1.DataBind();

            TrustControl1.ClientMsg(Msg);

        }
        else if (e.CommandName == "Delete1")
        {
            string ID = e.CommandArgument.ToString();

            string Msg = "";
            bool Done = false;
            using (SqlConnection conn = new SqlConnection())
            {
                string Query = "s_PriorityPassBill_Delete";
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = Query;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@BillingMonth", System.Data.SqlDbType.Int).Value = ID;
                    cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();

                    SqlParameter Sql_Msg = new SqlParameter("@Msg", System.Data.SqlDbType.VarChar, 255);
                    Sql_Msg.Direction = System.Data.ParameterDirection.InputOutput;
                    Sql_Msg.Value = Msg;
                    cmd.Parameters.Add(Sql_Msg);

                    SqlParameter Sql_Done = new SqlParameter("@Done", System.Data.SqlDbType.Bit);
                    Sql_Done.Direction = System.Data.ParameterDirection.InputOutput;
                    Sql_Done.Value = Done;
                    cmd.Parameters.Add(Sql_Done);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();
                    Msg = string.Format("{0}", Sql_Msg.Value);
                    Done = (bool)Sql_Done.Value;
                }
            }

            GridView1.DataBind();

            TrustControl1.ClientMsg(Msg);

        }
        else if (e.CommandName == "Download1")
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

                    string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
                    SqlConnection oConn = new SqlConnection(oConnString);
                    SqlCommand oCommand = new SqlCommand("SELECT * FROM dbo.v_PriorityPassTransactionBill WHERE BillingMonth=@BillingMonth", oConn);
                    oCommand.CommandType = CommandType.Text;
                    oCommand.Parameters.AddWithValue("BillingMonth", e.CommandArgument.ToString());
                   
                    if (oConn.State == ConnectionState.Closed)
                        oConn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(oCommand);
                    DataSet DV = new DataSet();
                    da.Fill(DV);

                    for (int r = 0; r < DV.Tables[0].Rows.Count; r++)
                    {
                        int R = StartRow + r + 1;
                        worksheet.Cells[R, 1].Value = R;
                        if (DV.Tables[0].Rows[r]["CustomerName"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 2].Value = DV.Tables[0].Rows[r]["CustomerName"].ToString();                           
                        }
                        if (DV.Tables[0].Rows[r]["CardNo"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 4].Value = DV.Tables[0].Rows[r]["CardNo"].ToString();                           
                        }
                        if (DV.Tables[0].Rows[r]["Member"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 5].Value = DV.Tables[0].Rows[r]["Member"].ToString();
                            worksheet.Cells[R, 5].Style.Numberformat.Format = "#.##";
                        }
                        if (DV.Tables[0].Rows[r]["Guest"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 6].Value = DV.Tables[0].Rows[r]["Guest"].ToString();
                            worksheet.Cells[R, 6].Style.Numberformat.Format = "#.##";
                        }
                        if (DV.Tables[0].Rows[r]["Total"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 7].Value = DV.Tables[0].Rows[r]["Total"].ToString();
                            worksheet.Cells[R, 7].Style.Numberformat.Format = "#.##";
                        }
                        if (DV.Tables[0].Rows[r]["ChargePerVisit"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 8].Value = DV.Tables[0].Rows[r]["ChargePerVisit"].ToString();
                            worksheet.Cells[R, 8].Style.Numberformat.Format = "#.##";
                        }
                        if (DV.Tables[0].Rows[r]["TotalAmount"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 9].Value = DV.Tables[0].Rows[r]["TotalAmount"].ToString();
                            worksheet.Cells[R, 9].Style.Numberformat.Format = "#.##";
                        }
                        if (DV.Tables[0].Rows[r]["Waive"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 10].Value = DV.Tables[0].Rows[r]["Waive"].ToString();
                            worksheet.Cells[R, 10].Style.Numberformat.Format = "#.##";
                        }
                        if (DV.Tables[0].Rows[r]["NoOfCharge"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 11].Value = DV.Tables[0].Rows[r]["NoOfCharge"].ToString();
                            worksheet.Cells[R, 11].Style.Numberformat.Format = "#.##";
                        }
                        if (DV.Tables[0].Rows[r]["ChargeAmount"] != DBNull.Value)
                        {
                            worksheet.Cells[R, 12].Value = DV.Tables[0].Rows[r]["ChargeAmount"].ToString();
                            worksheet.Cells[R, 12].Style.Numberformat.Format = "#.##";
                        }
                        
                    }
                    worksheet.Cells["A1:D1"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                    worksheet.Cells["B1:B"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                    worksheet.Cells["C1:C"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                    worksheet.Cells["D1:D"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                    worksheet.Cells["A1:D"].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Top;
                    worksheet.Cells["A1:D1"].Style.Font.Bold = true;
                    worksheet.Cells["B1:B100"].Style.WrapText = true;


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
                //Response.End();
                return;
            }
            catch (Exception ex)
            {
                TrustControl1.ClientMsg(ex.Message.ToString());
            }
        }
    }
}
