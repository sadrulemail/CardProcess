using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using OfficeOpenXml;

public partial class MerchantSetup : System.Web.UI.Page
{
    string MerchantID = "";
    bool Done = false;
    string Msg = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        //TrustControl1.ClientMsg(Request.QueryString["id"]);
        if (!IsPostBack)
        {
            
        }      
    }
    protected void SqlDataSourceMerchantSetup_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        MerchantID = string.Format("{0}", e.Command.Parameters["@MerchantID"].Value);
        Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        Done = (bool)e.Command.Parameters["@Done"].Value;
        if (Done)
        {
            TrustControl1.ClientMsg(Msg);
            GridView1.DataBind();
            hidMerchantID.Value = MerchantID;
            DetailsMerchantSetup.ChangeMode(DetailsViewMode.ReadOnly);
        }
        //DetailsMerchantSetup.Visible = true;
        //DetailsMerchantSetup.ChangeMode(DetailsViewMode.ReadOnly);
        //DetailsMerchantSetup.DefaultMode = DetailsViewMode.ReadOnly;
    }
    protected void SqlDataSourceMerchantSetup_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        Done = (bool)e.Command.Parameters["@Done"].Value;
        if (Done)
        {
            TrustControl1.ClientMsg(Msg);
            GridView1.DataBind();
            //hidMerchantID.Value = MerchantID;
            DetailsMerchantSetup.ChangeMode(DetailsViewMode.ReadOnly);
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DetailsPartySetup.Visible = true;
        DetailsMerchantSetup.ChangeMode(DetailsViewMode.ReadOnly);
        
        hidMerchantID.Value = GridView1.SelectedRow.Cells[1].Text.ToString();
        // DetailsPartySetup.DefaultMode = DetailsViewMode.ReadOnly;
        GridView1.SelectedIndex = -1;
    }
    protected void cmdValidateOrginalAccount_Click(object sender, EventArgs e)
    {
        if (((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Text.Trim().ToString() == ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Text.Trim().ToString())
            TrustControl1.ClientMsg("Merchant Orginal and Shadow Accout are Same");
        else
        {

            string AccNo = ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Text.Trim();
            //modal.Show();
            if (String.IsNullOrEmpty(AccNo))
                TrustControl1.ClientMsg("Please Enter A/C Number.");
            else
            {
                string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
                SqlConnection oConn = new SqlConnection(oConnString);
                if (oConn.State == ConnectionState.Closed) oConn.Open();

                SqlCommand oCommand = new SqlCommand("s_Flora_Acc_Validate", oConn);
                oCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter sql_Account = new SqlParameter("Account", SqlDbType.VarChar, 20);
                sql_Account.Value = AccNo;

                SqlParameter sql_Done = new SqlParameter("@Done", SqlDbType.Bit);
                sql_Done.Direction = ParameterDirection.Output;

                oCommand.Parameters.Add(sql_Account);
                oCommand.Parameters.Add(sql_Done);


                SqlDataReader oReader = oCommand.ExecuteReader();
                string Done = string.Format("{0}", sql_Done.Value);

                if (Done == "False")
                    TrustControl1.ClientMsg("Account Not Valid");
                else
                {
                    ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Enabled = false;
                    ((Button)(DetailsMerchantSetup.FindControl("cmdValidateOrginalAccount"))).Enabled = false;

                    if (DetailsMerchantSetup.CurrentMode == DetailsViewMode.Insert && ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Enabled == false)
                    {
                        ((Button)(DetailsMerchantSetup.FindControl("cmdInsert"))).Enabled = true;
                    }
                    if (DetailsMerchantSetup.CurrentMode == DetailsViewMode.Edit && ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Enabled == false)
                        ((Button)(DetailsMerchantSetup.FindControl("cmdUpdate"))).Enabled = true;
                }
            }
        }
    }
    protected void cmdValidateShadowAccount_Click(object sender, EventArgs e)
    {
        if (((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Text.Trim().ToString() == ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Text.Trim().ToString())
            TrustControl1.ClientMsg("Merchant Orginal and Shadow Accout are Same");
        else
        {
            string AccNo = ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Text.Trim();
            //modal.Show();
            if (String.IsNullOrEmpty(AccNo))
                TrustControl1.ClientMsg("Please Enter A/C Number.");
            else
            {
                string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
                SqlConnection oConn = new SqlConnection(oConnString);
                if (oConn.State == ConnectionState.Closed) oConn.Open();

                SqlCommand oCommand = new SqlCommand("s_Flora_Acc_Validate", oConn);
                oCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter sql_Account = new SqlParameter("Account", SqlDbType.VarChar, 20);
                sql_Account.Value = AccNo;

                SqlParameter sql_Done = new SqlParameter("@Done", SqlDbType.Bit);
                sql_Done.Direction = ParameterDirection.Output;

                oCommand.Parameters.Add(sql_Account);
                oCommand.Parameters.Add(sql_Done);


                SqlDataReader oReader = oCommand.ExecuteReader();
                string Done = string.Format("{0}", sql_Done.Value);

                if (Done == "False")
                    TrustControl1.ClientMsg("Account Not Valid");
                else
                {
                    ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Enabled = false;
                    ((Button)(DetailsMerchantSetup.FindControl("cmdValidateShadowAccount"))).Enabled = false;

                    if ((DetailsMerchantSetup.CurrentMode == DetailsViewMode.Insert) && ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Enabled == false)
                    {
                        ((Button)(DetailsMerchantSetup.FindControl("cmdInsert"))).Enabled = true;
                    }
                    if (DetailsMerchantSetup.CurrentMode == DetailsViewMode.Edit && ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Enabled == false)
                        ((Button)(DetailsMerchantSetup.FindControl("cmdUpdate"))).Enabled = true;
                }
            }
        }
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
            lblStatus.Text = ex.Message;
        }
    }
    protected void cmdExport_Click1(object sender, EventArgs e)
    {

    }

    protected void DetailsMerchantSetup_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        if (!Done)
        {
            e.KeepInEditMode = true;
            TrustControl1.ClientMsg(Msg);
        }
    }

    protected void DetailsMerchantSetup_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        if (!Done)
        {
            e.KeepInInsertMode = true;
            TrustControl1.ClientMsg(Msg);
        }
    }
}