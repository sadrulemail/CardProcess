﻿using System;

public partial class Activation_Ready : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.LoadEmpToSession(false);
        
        if(Session["BRANCHID"].ToString() !="1")
        if (Session["BRANCHID"].ToString() != string.Format("{0}", Request.QueryString["branch"]))
        {
            Response.End();
            return;
        }

        this.Title = string.Format("Branch ID: {0}", Request.QueryString["branch"]);
    }
    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }
}