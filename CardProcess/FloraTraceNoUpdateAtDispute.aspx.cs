using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using System.Data.SqlClient;
using System.Configuration;

public partial class FloraTraceNoUpdateAtDispute : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        if (!IsPostBack)
        {
            txtReqBegDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            txtReqEndDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            //txtFloraDT.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);

            GridView1.DataBind();
        GridView1.Visible = true;

        SqlDataSource1.DataBind();
        Title = "Flora Trace No Update at Dispute";
        }     
    }

    //protected void headerLevelCheckBox_CheckedChanged(object sender, EventArgs e)
    //{
    //    CheckBox headerChkBox = ((CheckBox)GridView1.HeaderRow.FindControl("headerLevelCheckBox"));

    //    if (headerChkBox.Checked)
    //    {
    //        foreach (GridViewRow gvRow in GridView1.Rows)
    //        {
    //            CheckBox rowChkBox = ((CheckBox)gvRow.FindControl("rowLevelCheckBox"));
    //            rowChkBox.Checked = true;
    //        }
    //    }
    //    else
    //    {
    //        foreach (GridViewRow gvRow in GridView1.Rows)
    //        {
    //            CheckBox rowChkBox = ((CheckBox)gvRow.FindControl("rowLevelCheckBox"));
    //            rowChkBox.Checked = false;
    //        }
    //    }
    //}

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Approve")
            {
                string AccNo = "";
                string FloraTransactionNumber = "";
                DateTime FloraTranDT;
                string ID = e.CommandArgument.ToString();
                string[] words = ID.Split('|');

                ID = words[0].ToString();
                AccNo = words[1].Trim().ToString();
                FloraTransactionNumber = words[2].Trim().ToString();
                FloraTranDT = DateTime.Parse(String.Format("{0:MM/dd/yyyy}", words[3].Trim()).ToString());

                string Msg = "";
                bool done = false;

                using (SqlConnection conn = new SqlConnection())
                {
                    string Query = "s_dispute_floraInfo_update";
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = Query;
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add("@ID", System.Data.SqlDbType.VarChar).Value = ID;
                        cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                        cmd.Parameters.Add("@BranchID", System.Data.SqlDbType.VarChar).Value = Session["BranchID"].ToString();
                        cmd.Parameters.Add("@AccNo", System.Data.SqlDbType.VarChar).Value = AccNo.ToString();
                        cmd.Parameters.Add("@FloraTransactionNumber", System.Data.SqlDbType.VarChar).Value = FloraTransactionNumber.ToString();
                        cmd.Parameters.Add("@FloraTranDT", System.Data.SqlDbType.Date).Value = FloraTranDT;
                        cmd.Parameters.Add("@FloraUserCode", System.Data.SqlDbType.Date).Value = FloraTranDT;

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
    

    protected void dboBranchCode_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in dboReqBranch.Items)
            i.Selected = false;

        if (Session["BRANCHID"].ToString() != "1")
        {
            foreach (ListItem ii in dboReqBranch.Items)
            {
                if (ii.Value == Session["BRANCHID"].ToString())
                    ii.Selected = true;
                else
                    ii.Enabled = false;
            }
        }
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
        btn_UpdateTraceNum.Visible = e.AffectedRows > 0 ? true : false;
        dboReqBranch.Enabled = e.AffectedRows>0 ?false:true;
        txtReqBegDate.Enabled = e.AffectedRows > 0 ? false : true;
        txtReqEndDate.Enabled = e.AffectedRows > 0 ? false : true;
        txtFloraDT.Enabled = e.AffectedRows > 0 ? false : true;
        txtFloraUserID.Enabled = e.AffectedRows > 0 ? false : true;
        txtBatchNo.Enabled = e.AffectedRows > 0 ? false : true;

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void btn_UpdateTraceNum_Click(object sender, EventArgs e)
    {
        string Msg = "";
        bool done = false;

        using (SqlConnection conn = new SqlConnection())
        {
            string Query = "s_Dispute_Posting_Update_ByFloraBatch";
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = Query;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@BranchID", System.Data.SqlDbType.VarChar).Value = Session["BranchID"].ToString();
                cmd.Parameters.Add("@DateFrom", System.Data.SqlDbType.Date).Value = txtReqBegDate.Text;
                cmd.Parameters.Add("@DateTo", System.Data.SqlDbType.Date).Value = txtReqEndDate.Text;
                cmd.Parameters.Add("@FloraDT", System.Data.SqlDbType.Date).Value = txtFloraDT.Text;
                cmd.Parameters.Add("@FloraUserID", System.Data.SqlDbType.VarChar).Value = txtFloraUserID.Text;
                cmd.Parameters.Add("@BatchNO", System.Data.SqlDbType.VarChar).Value = txtBatchNo.Text.Trim();
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
    protected void btnReset_Click(object sender, EventArgs e)
    {
        dboReqBranch.Enabled = true;
        txtReqBegDate.Enabled = true;
        txtReqEndDate.Enabled = true;
        txtFloraDT.Enabled = true;
        txtFloraUserID.Enabled = true;
        txtBatchNo.Enabled = true;
        //dboReqBranch.Enabled = false;
    }

}
