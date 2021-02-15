﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PriorityPassTrans : System.Web.UI.Page
{
    string Msg = "";
    bool Done = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        Title = "Priority Pass Trans";
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void SqlDataSource2_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        Done = (bool)e.Command.Parameters["@Done"].Value;
        if (Done)
        {
            TrustControl1.ClientMsg(Msg);
            GridView1.DataBind();
        }
    }
    protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        Done = (bool)e.Command.Parameters["@Done"].Value;
        if (Done)
        {
            TrustControl1.ClientMsg(Msg);
            GridView1.DataBind();
        }
    }
    protected void cmdNew_Click(object sender, EventArgs e)
    {
        DetailsView1.ChangeMode(DetailsViewMode.Insert);
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
    }

    protected void txtCardNo_TextChanged(object sender, EventArgs e)
    {
        using (SqlConnection objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString))
        {
            string query = "SELECT TOP 1 * FROM [CardData].[dbo].[PriorityPass] WHERE CardNo='" + ((TextBox)DetailsView1.FindControl("txtCardNo")).Text + "'";

            using (SqlDataAdapter da = new SqlDataAdapter(query, objConn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    ((Label)DetailsView1.FindControl("lblCardNo")).Text = dt.Rows[0]["CustomerName"].ToString();
                }
                else
                    ((Label)DetailsView1.FindControl("lblCardNo")).Text = "";
            }
        }

    }

    protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        if(!Done)
        {
            e.KeepInInsertMode = true;
            TrustControl1.ClientMsg(Msg);
        }
    }

    protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        if (!Done)
        {
            e.KeepInEditMode = true;
            TrustControl1.ClientMsg(Msg);
        }
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblstatus.Visible = e.AffectedRows > 0;
        lblstatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }
}
