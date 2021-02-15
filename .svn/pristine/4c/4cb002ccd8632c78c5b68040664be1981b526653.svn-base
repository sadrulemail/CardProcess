using System;
using System.Web.UI.WebControls;

public partial class Atm_Cash_Load_Show : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        this.Title = string.Format("{0}. ATM Cash Load", Request.QueryString["id"]);
    }

    protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        DeleteHistoryDiv.Visible = e.AffectedRows > 0;
    }

    protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        //SqlDataSource2.DataBind();
    }

    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        GridView2.DataBind();
    }
}