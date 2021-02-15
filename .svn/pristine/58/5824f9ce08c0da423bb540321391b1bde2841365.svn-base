using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search_Adv : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        TrustControl1.getUserRoles();        
        //GridView1.Visible = IsPostBack;

        Title = "Advanced Search All Cards";

        if (!IsPostBack)
            GridView1.Visible = false;
        
        //string focusScript = "document.getElementById('" + txtids.ClientID + "').focus();";
        //TrustControl1.ClientScriptStartup("setTimeout(\"" + focusScript + ";\",100);");

        //if (!IsPostBack)
        //{
        //    txtFilter.Text = string.Format("{0}", Request.QueryString["q"]);
        //    Title = txtFilter.Text + " : Search Card";
        //}

        //if (txtIDs.Text.Length == 0)
        //    GridView1.Visible = false;
    }
    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
        //GridView1.DataBind();
    }
    protected void cmdOK_Click(object sender, EventArgs e)
    {
        //Response.Redirect("Search.aspx?q=" + txtFilter.Text.Trim(), true);
        GridView1.DataBind();
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //TrustControl1.ClientMsg(e.AffectedRows.ToString());
        if (e.AffectedRows > 0)
        {
            lblCount.Visible = true;
            lblCount.Text = "<b>Total Records : </b>" + e.AffectedRows.ToString();
        }
        else
            lblCount.Visible = false;
    }
}