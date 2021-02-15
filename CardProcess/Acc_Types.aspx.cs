using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Acc_Types : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (!TrustControl1.isRole("ADMIN"))
        {            
            Response.Write("No Permission.<br><br><a href=''>Home</a>");
            Response.End();        
        }

        Title = "Account Types";
    }
    protected void SqlDataSource2_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string Msg = e.Command.Parameters["@Msg"].Value.ToString();
        bool Done =(bool) e.Command.Parameters["@Done"].Value;
        if (Done)
            TrustControl1.ClientMsg(Msg);

        GridView1.DataBind();
    }
    protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        string Msg = e.Command.Parameters["@Msg"].Value.ToString();
        bool Done = (bool)e.Command.Parameters["@Done"].Value;
        if (Done)
            TrustControl1.ClientMsg(Msg);
        GridView1.DataBind();
    }
    protected void cmdNew_Click(object sender, EventArgs e)
    {
        DetailsView1.ChangeMode(DetailsViewMode.Insert);
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
    }


    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            lblMsg.Visible = true;
            lblMsg.Text = "<b>Total Records:</b> " + e.AffectedRows.ToString();
        }
        else
            lblMsg.Visible = false;
    }
}
