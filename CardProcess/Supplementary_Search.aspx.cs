using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Supplementary_Search : System.Web.UI.Page
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

        Title = "Search Supplementary Card";
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "OPEN")
        {
            Response.Redirect("~/Supplementary_Issue_Request.aspx?ID=" + e.CommandArgument, true);
        }
    }
   
    
   
    protected void cboBranch_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in cboBranch.Items)
           
                i.Selected = false;


        if (Session["BRANCHID"].ToString() != "1")
        {
            foreach (ListItem i in cboBranch.Items)
                if (i.Value == Session["BRANCHID"].ToString())
                    i.Selected = true;            
        }
                                 
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }
    protected void cmdFilter_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
}
