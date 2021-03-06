﻿using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using SocialExplorer.IO.FastDBF;

public partial class PIN_Reissue_Branch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
       

        //lblTitle.Text = string.Format("PIN Reissue Branch # {0}", Request.QueryString["batch"]);
        //this.Title = string.Format("PIN Reissue # {0}", Request.QueryString["batch"]);
        GridView1.DataBind();

    }


    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
            lblStatus.Text = string.Format("Total PIN Reissue: <b>{0:N0}</b>", e.AffectedRows);
        else
            lblStatus.Text = "";
    }



}
