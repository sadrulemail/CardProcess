﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using OfficeOpenXml;

public partial class ForwardingReceiveAtBranch : System.Web.UI.Page
{  
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        Title = "Forwarding Receive";

        if (!IsPostBack)
        {
            txtFilter.Text = string.Format("{0}", Request.QueryString["batch"]);
            if (txtFilter.Text.Length > 0)
            {
                Title = string.Format("{0}. Forwarding Receive", Request.QueryString["batch"]);
                lblTitle.Text = string.Format("Card Forwarding Receive at Branch # {0}", Request.QueryString["batch"]);
            }
            txtFilter.Focus();

           

            if (Session["BRANCHID"].ToString() == "1")
            {
                cboBranch.AppendDataBoundItems = true;
                //Div1.Visible = true;
            }
          
        }        
    }
    protected void cmdOK_Click(object sender, EventArgs e)
    {
        //Response.Redirect("ForwardingReceiveAtBranch.aspx?batch=" + txtFilter.Text.Trim(), true);
        GridView2.DataBind();
    }

    protected void SelectCheckBox_OnCheckedChanged(object sender, EventArgs e)
    {
        CheckBox chk = sender as CheckBox;

        if (chk.Checked)
        {
            GridViewRow row = (GridViewRow)chk.NamingContainer;             
        }
    }
    protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            lblMsg.Visible = true;
            lblMsg.Text = "<b>Total Records: </b>" + e.AffectedRows.ToString();
            //if(Session["BranchID"].ToString()=="1")
            //    btn_ReceiveAll.Enabled = false;
            //else
            btn_ReceiveAll.Visible = true;
            //cmdOK.Enabled = false;
            //txtFilter.Enabled = false;
            //GridView2.Visible = true;
            //divpending.Visible = false;
        }
        else
        {
            //GridView2.Visible = false;
            lblMsg.Visible = false;
            btn_ReceiveAll.Visible = false;
            //cmdOK.Enabled = true;
            //txtFilter.Enabled = true;
            //divpending.Visible = true;
        }
    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        string ID = e.CommandArgument.ToString();
        string Msg = "";
        bool done = false;
        string Query = "s_ForwardingReceived_Insert";

        if (e.CommandName == "Receive")
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["CardDataConnectionString"].ConnectionString;
               

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@ID", System.Data.SqlDbType.VarChar,8000).Value = ID;
                    cmd.Parameters.Add("@BranchID", System.Data.SqlDbType.Int).Value = Session["BranchID"];
                    cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                    cmd.Parameters.Add("@ForwardingBatch", System.Data.SqlDbType.BigInt).Value = txtFilter.Text.Trim();
                    cmd.Parameters.Add("@SMSEmailSend", System.Data.SqlDbType.Bit).Value = true;

                    SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                    SQL_Msg.Direction = ParameterDirection.InputOutput;
                    SQL_Msg.Value = Msg;
                    cmd.Parameters.Add(SQL_Msg);

                    SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    SQL_Done.Direction = ParameterDirection.InputOutput;
                    SQL_Done.Value = done;
                    cmd.Parameters.Add(SQL_Done);
                    cmd.CommandTimeout = 0;
                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();

                    done = (bool)SQL_Done.Value;
                    Msg = string.Format("{0}", SQL_Msg.Value);
                    GridView2.DataBind(); 
                }
            }
            if (done)
            {
                TrustControl1.ClientMsg(Msg);
                GridView2.DataBind();
            }

        }  
       else if (e.CommandName == "ReceiveSMS")
        {
            
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = System.Configuration.ConfigurationManager
                            .ConnectionStrings["CardDataConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.Add("@ID", System.Data.SqlDbType.VarChar,8000).Value = ID;
                    cmd.Parameters.Add("@BranchID", System.Data.SqlDbType.Int).Value = Session["BranchID"];
                    cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                    cmd.Parameters.Add("@ForwardingBatch", System.Data.SqlDbType.BigInt).Value = txtFilter.Text.Trim();
                    cmd.Parameters.Add("@SMSEmailSend", System.Data.SqlDbType.Bit).Value = false;

                    SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                    SQL_Msg.Direction = ParameterDirection.InputOutput;
                    SQL_Msg.Value = Msg;
                    cmd.Parameters.Add(SQL_Msg);

                    SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    SQL_Done.Direction = ParameterDirection.InputOutput;
                    SQL_Done.Value = done;
                    cmd.Parameters.Add(SQL_Done);
                    cmd.CommandTimeout = 0;
                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();

                    done = (bool)SQL_Done.Value;
                    Msg = string.Format("{0}", SQL_Msg.Value);
                    GridView2.DataBind();
                }
            }
            if (done)
            {
                TrustControl1.ClientMsg(Msg);
                GridView2.DataBind();
            }

        }
    }

    protected void btn_ReceiveAll_Click(object sender, EventArgs e)
    {
        try
        {
            //Get the total checked 
            string IDS = "";
            foreach (GridViewRow gvRow in GridView2.Rows)
            {
                CheckBox rowChkBox = ((CheckBox)gvRow.FindControl("rowLevelCheckBox"));
                if (rowChkBox.Checked)
                    IDS += rowChkBox.Text + ",";
            }
            //End
            if (IDS.Length > 3)
            {
                string Msg = "";
                bool done = false;
                string Query = "s_ForwardingReceived_Insert";
                using (SqlConnection conn = new SqlConnection())
                {
                    conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["CardDataConnectionString"].ConnectionString;

                    using (SqlCommand cmd = new SqlCommand(Query, conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.Add("@ID", System.Data.SqlDbType.VarChar,8000).Value = IDS;
                        cmd.Parameters.Add("@BranchID", System.Data.SqlDbType.Int).Value = Session["BranchID"];
                        cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                        cmd.Parameters.Add("@ForwardingBatch", System.Data.SqlDbType.BigInt).Value = txtFilter.Text.Trim();
                        cmd.Parameters.Add("@SMSEmailSend", System.Data.SqlDbType.Bit).Value = true;

                        SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                        SQL_Msg.Direction = ParameterDirection.InputOutput;
                        SQL_Msg.Value = Msg;
                        cmd.Parameters.Add(SQL_Msg);

                        SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                        SQL_Done.Direction = ParameterDirection.InputOutput;
                        SQL_Done.Value = done;
                        cmd.Parameters.Add(SQL_Done);
                        cmd.CommandTimeout = 0;
                        cmd.Connection = conn;
                        conn.Open();

                        cmd.ExecuteNonQuery();

                        done = (bool)SQL_Done.Value;
                        Msg = string.Format("{0}", SQL_Msg.Value);
                        GridView2.DataBind();

                    }
                }


                if (done)
                {
                    TrustControl1.ClientMsg(Msg);
                    GridView2.DataBind();
                }
            }
            else
                TrustControl1.ClientMsg("Please check mark the cards for receive.");
        }
        catch (Exception exx) {
            TrustControl1.ClientMsg(exx.Message);
        }
    }


    protected void headerLevelCheckBox_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox headerChkBox = ((CheckBox)GridView2.HeaderRow.FindControl("headerLevelCheckBox"));

        if (headerChkBox.Checked)
        {
            foreach (GridViewRow gvRow in GridView2.Rows)
            {
                CheckBox rowChkBox = ((CheckBox)gvRow.FindControl("rowLevelCheckBox"));
                rowChkBox.Checked = true;
            }
        }
        else
        {
            foreach (GridViewRow gvRow in GridView2.Rows)
            {
                CheckBox rowChkBox = ((CheckBox)gvRow.FindControl("rowLevelCheckBox"));
                rowChkBox.Checked = false;
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
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("CardForwardingList");
                int StartRow = 1;

                //Adding Title Row
                worksheet.Column(1).Width = 15;
                worksheet.Column(2).Width = 15;
                worksheet.Column(3).Width = 20;
                worksheet.Column(4).Width = 25;
                worksheet.Column(5).Width = 40;
               

                worksheet.Cells["A1:Z1"].Style.Font.Bold = true;

                //Adding Title Row
                worksheet.Cells[StartRow, 1].Value = "ID";
                worksheet.Cells[StartRow, 2].Value = "Batch";
                worksheet.Cells[StartRow, 3].Value = "Account";
                worksheet.Cells[StartRow, 4].Value = "Card Number";
                worksheet.Cells[StartRow, 5].Value = "Customer Name";

                DataView DV = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
                int R = 1;
                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {
                    R = R + 1;

                    
                        worksheet.Cells[R, 1].Value = R-1;                        
                    
                    if (DV.Table.Rows[r]["Batch"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["Batch"].ToString();                        
                    }
                    if (DV.Table.Rows[r]["AccountNo"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["AccountNo"].ToString();                       
                    }
                    if (DV.Table.Rows[r]["CardNumber"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["CardNumber"].ToString();
                        //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                    }
                    if (DV.Table.Rows[r]["CustomerName"] != DBNull.Value)
                    {
                        worksheet.Cells[R, 5].Value = DV.Table.Rows[r]["CustomerName"].ToString();                       
                    }                    
                }
                worksheet.Cells["A1:Z" + R].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["F1:F"].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Center;

                //Adding Properties
                xlPackage.Workbook.Properties.Title = "Card Forwarding List";
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
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "CardForwardingList_" + DateTime.Now.ToString() + ".xlsx");
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
    
   
