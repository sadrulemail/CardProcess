﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Banks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (!TrustControl1.isRole("ADMIN"))
        {            
            Response.Write("No Permission.<br><br><a href=''>Home</a>");
            Response.End();        
        }

        Title = "All Banks Info";
    }
    protected void SqlDataSource2_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string Msg = e.Command.Parameters["@Msg"].Value.ToString();
        bool Done =(bool) e.Command.Parameters["@Done"].Value;
       
            TrustControl1.ClientMsg(Msg);

        GridView1.DataBind();
    }
    protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        GridView1.DataBind();
    }
    protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        GridView1.DataBind();
    }
    protected void DetailsView1_ModeChanged(object sender, EventArgs e)
    {
       
        modal.Show();
    }
    protected void DetailsView1_DataBound(object sender, EventArgs e)
    {
        
    }
    protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        string Msg = e.Command.Parameters["@Msg"].Value.ToString();
        bool Done = (bool)e.Command.Parameters["@Done"].Value;
       
            TrustControl1.ClientMsg(Msg);
        //GridView1.DataBind();
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

    protected void SqlDataSource3_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        
    }
}