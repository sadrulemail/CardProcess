using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


public partial class Card_Activation_Request : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (TrustControl1.getUserRoles() == string.Empty)
            Response.End();

        //TrustControl1.ClientMsg(Session["CardType"].ToString());        
        
        if (hidID.Value != "")
        {
            if (TrustControl1.isRole("GUEST"))   //Guest User
            {
                //DetailsView1.Rows[DetailsView1.Rows.Count - 1].Visible = false;
            }
        }
        else if (!TrustControl1.isRole("ADMIN")
            && !TrustControl1.isRole("USER"))
        {
            Response.Write("No Permission.");
            //DetailsView1.Visible = false;
            Panel1.Visible = false;
        }

        string focusScript = "document.getElementById('" + txtCardNumber.ClientID + "').focus();";
        TrustControl1.ClientScriptStartup("setTimeout(\"" + focusScript + ";\",200);");

        SqlConnection.ClearAllPools();
        lblNotice.Text = TrustControl1.getValueOfKey("CardActicationNotice");

        Title = "Card Actication Request";
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = e.Command.Parameters["@Msg"].Value.ToString(); 
        if ((bool)e.Command.Parameters["@Done"].Value)
        {
            txtCardNumber.Text = "";
        }
        else
        {
            TrustControl1.ClientMsg(e.Command.Parameters["@Msg"].Value.ToString());
        }
        GridView1.DataBind();
    }

    protected void txtCardNumber_TextChanged(object sender, EventArgs e)
    {
        SqlDataSource1.Select(DataSourceSelectArguments.Empty);
    }

    protected void cmdOK_Click(object sender, EventArgs e)
    {
        SqlDataSource1.Select(DataSourceSelectArguments.Empty);
    }
}