﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SettlementView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.LoadEmpToSession(false);

        //if (Session["BRANCHID"].ToString() != "1")
        //    if (Session["BRANCHID"].ToString() != string.Format("{0}", Request.QueryString["branch"]))
        //    {
        //        Response.End();
        //        return;
        //    }

        this.Title = string.Format("Settlement: {0}", Request.QueryString["batchid"]);
    }
    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }
}