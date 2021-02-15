using System;
using System.Web.UI.WebControls;

public partial class ShowCards : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.LoadEmpToSession(false);

        if (Session["BRANCHID"].ToString() != "1")
            Response.End();

        this.Title = string.Format("Type: {0}, Branch: {1}", Request.QueryString["cardtype"], Request.QueryString["branch"]);
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }

    protected void cmdExport_Click(object sender, EventArgs e)
    {
       
    }
}