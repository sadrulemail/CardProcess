using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;


public partial class UndeliverCardMarkLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        if (!IsPostBack)
        {
            txtReqBegDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date.AddDays(-1));
            txtReqEndDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        }
       
        GridView1.DataBind();
        GridView1.Visible = true;

        SqlDataSource1.DataBind();
        Title = "Undeliver Card Mark Log";

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "OPEN")
        {
            Response.Redirect("~/Dispute.aspx?ID=" + e.CommandArgument, true);
        }
    }


    protected void dboBranchCode_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in dboReqBranch.Items)
            i.Selected = false;

        if (Session["BRANCHID"].ToString() != "1")
        {
            foreach (ListItem ii in dboReqBranch.Items)
            {
                if (ii.Value == Session["BRANCHID"].ToString())
                    ii.Selected = true;
                else
                    ii.Enabled = false;
            }
        }
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }

    
}
