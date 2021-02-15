using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        TrustControl1.getUserRoles();        
        //GridView1.Visible = IsPostBack;

        Title = "Search All Cards";
        
        string focusScript = "document.getElementById('" + txtFilter.ClientID + "').focus();";
        TrustControl1.ClientScriptStartup("setTimeout(\"" + focusScript + ";\",100);");

        if (!IsPostBack)
        {
            txtFilter.Text = string.Format("{0}", Request.QueryString["q"]);
            Title = txtFilter.Text + " : Search Card";
        }

        if (txtFilter.Text.Length == 0)
            GridView1.Visible = false;
    }
    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
        //GridView1.DataBind();
    }
    protected void cmdOK_Click(object sender, EventArgs e)
    {
        Response.Redirect("Search.aspx?q=" + txtFilter.Text.Trim(), true);
    }
}