﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Credit_Card_Types : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (!TrustControl1.isRole("ADMIN"))
        {            
            Response.Write("No Permission.<br><br><a href=''>Home</a>");
            Response.End();        
        }

        Title = "Credit Card Types";
    }
    protected void SqlDataSource2_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView1.DataBind();
    }
    protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
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

    protected void dboType_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddltype = (DropDownList)DetailsView1.FindControl("dboType");
        if (ddltype != null)
        {
            if (ddltype.SelectedValue == "S")
            {
                //CheckBox chkS = (CheckBox)DetailsView1.FindControl();
            }

        }
    }
}
