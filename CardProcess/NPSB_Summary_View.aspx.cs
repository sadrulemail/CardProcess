using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class NPSB_Summary_View : System.Web.UI.Page
{
    bool Done = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        this.Title = "NPSB Summary";
        //txtSearch.Focus();

        if (!IsPostBack)
        {
            //txtEndDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Today);
            //txtStartDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Today);
        }
    }


    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total: <b>{0}</b>", e.AffectedRows);

    }
    protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        Done = (bool)e.Command.Parameters["@Done"].Value;
        TrustControl1.ClientMsg(e.Command.Parameters["@Msg"].Value.ToString());
        GridView1.DataBind();
    }
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        if (!Done)
            e.KeepInEditMode = true;
    }


    protected void GridView1_PageIndexChanged(object sender, EventArgs e)
    {
        GridView1.EditIndex = -1;
    }

    protected void GridView1_Sorted(object sender, EventArgs e)
    {
        GridView1.EditIndex = -1;
    }

    protected void cmdSearch_Click(object sender, EventArgs e)
    {
        GridView1.EditIndex = -1;
    }
}