using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using System.Data.SqlClient;
using System.Configuration;

public partial class CreditCard_ForwardingHistory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date.AddDays(-1));
            txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        }
        TrustControl1.getUserRoles();
        GridView1.DataBind();
        GridView1.Visible = true;

        SqlDataSource1.DataBind();

        Title = "Credit Card Forwarding History";

    }
   
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
        //cmdForwarding.Visible = e.AffectedRows > 0;
    }

    protected void cmdFilter_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
   
}
