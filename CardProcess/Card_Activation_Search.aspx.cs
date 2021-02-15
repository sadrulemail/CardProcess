using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Card_Activation_Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (TrustControl1.getUserRoles() == string.Empty)
            Response.End();
              
        GridView1.Visible = IsPostBack;

        Title = "Search Card Activation Request";

        string focusScript = "document.getElementById('" + txtCardNumner.ClientID + "').focus();";
        TrustControl1.ClientScriptStartup("setTimeout(\"" + focusScript + ";\",200);");
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //TrustControl1.ClientIDFocus(txtCardNumner.ClientID);

        lblStatus.Text = string.Format("", e.AffectedRows);
    }
    protected void txtCardNumner_TextChanged(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
}