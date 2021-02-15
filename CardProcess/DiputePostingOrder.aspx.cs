﻿using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class DiputePostingOrder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (!IsPostBack )
        {
            txtReqBegDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date.AddDays(-30));
            txtReqEndDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            //txtAccNo.Text = string.Format("{0}", Request.QueryString["AccNo"]);
        }

        Title = "Dispute Posting Order";

       
        // Button1_Click.visible = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        GridView1.DataBind();

    }
    protected void dboBranchCode_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in dboReqBranch.Items)
            i.Selected = false;


        if (Session["BRANCHID"].ToString() != "1" || Session["DEPTID"].ToString() != "7")
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

    protected void ddlApprove_DataBound(object sender, EventArgs e)
    {
        //foreach (ListItem i in ddlApprove.Items)
        //    i.Selected = false;


        //if (Session["BRANCHID"].ToString() != "1")
        //{
        //    foreach (ListItem ii in ddlApprove.Items)
        //    {
        //        if (ii.Value == "1")
        //            ii.Selected = true;
        //        else
        //            ii.Enabled = false;
        //    }
        //}
    }


    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //btnSendMail.Visible = false;
        //btnSendMail.Visible = e.AffectedRows > 0 && Session["DEPTID"].ToString() == "7"
        //    && Session["BRANCHID"].ToString() == "1";
        lblStatus.Visible = e.AffectedRows > 0;
        lblStatus.Text = string.Format("Total: <b>{0}</b><br /><br />", e.AffectedRows);

    }
    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            modal.Show();
        }
        catch (Exception exx) { }
    }
    protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        bool Done = (bool)e.Command.Parameters["@Done"].Value;
        string Msg = e.Command.Parameters["@Msg"].Value.ToString();
        TrustControl1.ClientMsg(Msg);
        if (Done)
        {
            GridView1.DataBind();
            GridView1.SelectedIndex = -1;
            modal.Hide();
        }
    }
    protected void DetailsView1_ModeChanged(object sender, EventArgs e)
    {
        modal.Show();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Approve")
            {
                string ID = e.CommandArgument.ToString();

                string Msg = "";
                bool done = false;

                using (SqlConnection conn = new SqlConnection())
                {
                    string Query = "s_dispute_Approve";
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

    public bool isDownloadLetterVisible(
        object _Authorize,
        object _Approve,
        object _ATM_Branch,
        object _PostingBY,
        object _BankCode,
        object _ApproveDT,
        object _PublishDate)
    {
        bool RetVal = false;
        try
        {
            int ATM_Branch = 0;
            DateTime ApproveDT = DateTime.Parse("01/01/1900");
            DateTime PublishDate = (DateTime)_PublishDate;

            bool Authorize = (bool)_Authorize;
            bool Approve = (bool)_Approve;
            if (Approve)
            {
                try
                {
                    ATM_Branch = int.Parse(string.Format("{0}", _ATM_Branch));
                }
                catch (Exception) { return false; }
                try
                {
                    ApproveDT = DateTime.Parse(string.Format("{0}", _ApproveDT));
                }
                catch (Exception) { return false; }
            }
            string PostingBY = string.Format("{0}", _PostingBY);
            string BankCode = string.Format("{0}", _BankCode);

            if (Authorize && Approve && PostingBY == "" && ApproveDT >= PublishDate) //      18/12/2016 publish date
                if (ATM_Branch == 1)
                {
                    if (BankCode == "240")  //Trust Bank
                    {
                        if (Session["BRANCHID"].ToString() == "1"
                            && Session["DEPTID"].ToString() == "60")     //ATM POS Unit, HO 
                            RetVal = true;
                    }
                    else
                    {
                        if (Session["BRANCHID"].ToString() == "1"
                         && Session["DEPTID"].ToString() == "7")     //IT ADC                
                            RetVal = true;
                    }
                }
                else
                {
                    if (ATM_Branch == (int)Session["BRANCHID"])
                        RetVal = true;
                }

            if (TrustControl1.isRole("ADMIN") && (int)Session["BRANCHID"] == 1 && Authorize && Approve && PostingBY == "")
                RetVal = true;


            return RetVal;
        }
        catch (Exception exx)
        {
            TrustControl1.ClientMsg(exx.Message);
            return RetVal = false;

        }
    }

    public bool isFloraInfoUpdateVisible(
        object _Authorize,
        object _Approve,
        object _ATM_Branch,
        object _PostingBY,
        object _BankCode,
        object _ApproveDT,
        object _PublishDate)
    {
        bool RetVal = false;
        try
        {
            int ATM_Branch = 0;
            DateTime ApproveDT = DateTime.Parse("01/01/1900");
            DateTime PublishDate = (DateTime)_PublishDate;

            bool Authorize = (bool)_Authorize;
            bool Approve = (bool)_Approve;
            if (Approve)
            {
                try
                {
                    ATM_Branch = int.Parse(string.Format("{0}", _ATM_Branch));
                }
                catch (Exception) { return false; }
                try
                {
                    ApproveDT = DateTime.Parse(string.Format("{0}", _ApproveDT));
                }
                catch (Exception) { return false; }
            }
            string PostingBY = string.Format("{0}", _PostingBY);
            string BankCode = string.Format("{0}", _BankCode);

            if (Authorize && Approve && PostingBY == "" && ApproveDT >= PublishDate) //      18/12/2016 publish date
                if (ATM_Branch == 1)
                {
                    if (BankCode == "240")  //Trust Bank
                    {
                        if ((Session["BRANCHID"].ToString() == "1"
                            && Session["DEPTID"].ToString() == "60") || Session["BRANCHID"].ToString() == "2")     //ATM POS Unit, HO & Principal Branch
                            RetVal = true;
                    }
                    else
                    {
                        if (Session["BRANCHID"].ToString() == "1"
                         && Session["DEPTID"].ToString() == "7")     //IT ADC                
                            RetVal = true;
                    }
                }
                else
                {
                    if (ATM_Branch == (int)Session["BRANCHID"])
                        RetVal = true;
                }

            if (TrustControl1.isRole("ADMIN") && (int)Session["BRANCHID"] == 1 && Authorize && Approve && PostingBY == "")
                RetVal = true;


            return RetVal;
        }
        catch (Exception exx)
        {
            TrustControl1.ClientMsg(exx.Message);
            return RetVal = false;

        }
    }

    protected void btnSendMail_Click(object sender, EventArgs e)
    {
        try
        {
            String Tos = "";
            String CCs = "G4";//ADC Division Group
            String Subject = "Dispute Posting Order Notification for your Branch (" + DateTime.Now.ToString("dd-MMM-yyyy") + ")";
            String Body = HttpContext.Current.Server.HtmlEncode("Dear Sir,\\n" +
                "Please find the following link for dispute Settlement: \\n" +
                "http://172.22.1.26/CardProcess/DiputeApprove.aspx" + "\\n" + "\\nBest Regards");

            using (SqlConnection conn = new SqlConnection())
            {
                string Query = "s_Dispute_Approve_Send_IntraMessage";
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = Query;
                    cmd.Connection = conn;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@DateFrom", System.Data.SqlDbType.DateTime).Value = DateTime.Parse(txtReqBegDate.Text);
                    cmd.Parameters.Add("@DateTo", System.Data.SqlDbType.DateTime).Value = DateTime.Parse(txtReqEndDate.Text);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);

                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            Tos += dt.Rows[i][0].ToString() + ",";
                        }
                    }
                }
            }
            //HyperLink1.Visible = true;
            //HyperLink1.Target = "_blank";
            //HyperLink1.Text = "http://172.22.1.26/msg/New.aspx?TO=" + Tos + "&CC=" + CCs + "&Subject=" + Subject + "&Body=" + Body;
            Response.Redirect("http://172.22.1.26/msg/New.aspx?TO=" + Tos + "&CC=" + CCs + "&Subject=" + Subject + "&Body=" + Body);

        }
        catch (Exception xx)
        {
            TrustControl1.ClientMsg(xx.Message);
        }
    }

}

