using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SMS_Sent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (TrustControl1.isRole("ADMIN"))
        {
            if (Session["DEPTID"].ToString() != "7")    //Not IT & Cards
            {
                Response.Write("No Permission.<br><br><a href=''>Home</a>");
                Response.End();
            }
        }

        Title = "SMS Archive";

        string focusScript = "document.getElementById('" + txtFilter.ClientID + "').focus();";
        TrustControl1.ClientScriptStartup("setTimeout(\"" + focusScript + ";\",100);");
    }
    protected void cboStatus_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }
}
