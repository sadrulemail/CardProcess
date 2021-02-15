using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class DiputePostingPending : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (!IsPostBack)
        {
            //txtReqBegDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date.AddDays(-7));
            //txtReqEndDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            //txtAccNo.Text = string.Format("{0}", Request.QueryString["AccNo"]);
        }

        Title = "Dispute Posting Pending";

      
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        GridView1.DataBind();

    }
    protected void dboBranchCode_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in dboReqBranch.Items)
            i.Selected = false;


        if (Session["BRANCHID"].ToString() != "1" || Session["DEPTID"].ToString() != "7")
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
       
        lblStatus.Visible = e.AffectedRows > 0;
        lblStatus.Text = string.Format("Total: <b>{0}</b><br /><br />", e.AffectedRows);

    }
    
   
   
    

}


