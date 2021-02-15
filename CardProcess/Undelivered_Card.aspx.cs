using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Undelivered_Card : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date.AddDays(-30));
            txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        }
        TrustControl1.getUserRoles();
        GridView1.DataBind();
        GridView1.Visible = true;

        SqlDataSource1.DataBind();

        Title = "Undelivered Card";
    }
    protected void cmdMarkUndeliver_Click1(object sender, EventArgs e)
    {
        try
        {
           

                string Msg = "";
                bool done = false;

                using (SqlConnection conn = new SqlConnection())
                {
                    string Query = "s_UndeliveredMark_Insert";
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = Query;
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                        cmd.Parameters.Add("@ReceiveFrom", System.Data.SqlDbType.DateTime).Value = txtDateFrom.Text;
                        cmd.Parameters.Add("@ReceiveTo", System.Data.SqlDbType.DateTime).Value = txtDateTo.Text;
                        cmd.Parameters.Add("@BranchID", System.Data.SqlDbType.VarChar).Value = cboBranch.SelectedValue;
                    //cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();

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
        catch (Exception exx) { TrustControl1.ClientMsg(exx.Message); }
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
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
        cmdMarkUndeliver.Enabled = e.AffectedRows > 0;
    }
    protected void cmdFilter_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
}
