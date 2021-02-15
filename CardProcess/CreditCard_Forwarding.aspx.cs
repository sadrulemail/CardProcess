using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using System.Data.SqlClient;
using System.Configuration;

public partial class CreditCard_Forwarding : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtIssueDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date.AddDays(-1));
            txtIssueDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        }
        TrustControl1.getUserRoles();
        GridView1.DataBind();
        GridView1.Visible = true;

        SqlDataSource1.DataBind();

        Title = "Credit Card Forwarding Generate";

    }
   
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
        cmdForwarding.Visible = e.AffectedRows > 0;
    }

    protected void cmdFilter_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void cmdForwarding_Click(object sender, EventArgs e)
    {
        try
        {         
                string Msg = "";
                bool done = false;

                using (SqlConnection conn = new SqlConnection())
                {
                    string Query = "s_CreditCardForwardingLog_Insert";
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = Query;
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add("@IssueDateFrom", System.Data.SqlDbType.DateTime).Value = txtIssueDateFrom.Text.Trim();
                    cmd.Parameters.Add("@IssueDateTo", System.Data.SqlDbType.DateTime).Value = txtIssueDateTo.Text.Trim();
                    cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                        

                        SqlParameter Sql_Msg = new SqlParameter("@Msg", System.Data.SqlDbType.VarChar, 255);
                        Sql_Msg.Direction = System.Data.ParameterDirection.InputOutput;
                        Sql_Msg.Value = Msg;
                        cmd.Parameters.Add(Sql_Msg);

                        //SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                        //SQL_Done.Direction = ParameterDirection.InputOutput;
                        //SQL_Done.Value = done;
                        //cmd.Parameters.Add(SQL_Done);

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

}
