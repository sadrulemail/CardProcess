﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ForwardingView : System.Web.UI.Page
{
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        TrustControl1.ClientMsg(Msg);
        GridView1.DataBind();
        GridView2.DataBind();
        GridView3.DataBind();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.Attributes.Add("enctype", "multipart/form-data");
        TrustControl1.getUserRoles(); try
        {
            this.Title = string.Format("Batch: {0}", Request.QueryString["batch"]);
            string batch = Request.QueryString["batch"].ToString();


        }
        catch (Exception exx) { TrustControl1.ClientMsg(exx.ToString()); }
    }
    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }
    protected void SqlDataSource4_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        GridView2.DataBind();
        Label2.Text = string.Format("Total Deleted Rows: <b>{0:N0}</b>", e.AffectedRows);
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
        //if (DetailsView1.CurrentMode == DetailsViewMode.ReadOnly)
        //    DetailsView1.CellPadding = 1;
        //else
        //    DetailsView1.CellPadding = 1;
        modal.Show();
    }
    protected void DetailsView1_DataBound(object sender, EventArgs e)
    {
        //try
        //{
        //    if (TrustControl1.isRole("ADMIN"))
        //    {
        //        DetailsView1.Fields[DetailsView1.Fields.Count - 1].Visible = true;
        //        DetailsView1.Fields[DetailsView1.Fields.Count - 2].Visible = true;
        //    }
        //}
        //catch (Exception) { }
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.Rows[e.RowIndex].Focus();
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.Rows[e.NewEditIndex].Focus();
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView1.Rows[e.RowIndex].Focus();
    }
    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            modal.Show();
            //hidCardNumber.Value= GridView1.
        }
        catch (Exception exx) { }
    }

    //protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    //{
    //    string Msg = e.Command.Parameters["@Msg"].Value.ToString();
    //    TrustControl1.ClientMsg(Msg);
    //}

    protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        string Msg = e.Command.Parameters["@Msg"].Value.ToString();
        TrustControl1.ClientMsg(Msg);
        GridView1.DataBind();
    }

    protected void GridView2_DataBound(object sender, EventArgs e)
    {
        decimal TotalCards = 0;
        try
        {
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                TotalCards += checkValue(GridView2.Rows[i].Cells[1].Text);
            }
            GridView2.FooterRow.Cells[0].Text = "Total";
            GridView2.FooterRow.Cells[0].HorizontalAlign= HorizontalAlign.Right;
            GridView2.FooterRow.Cells[1].Text = TotalCards.ToString();
            GridView2.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Right;
        }
        catch (Exception exx)
        {
            //TrustControl1.ClientMsg(exx.Message.ToString());
        }
    }
    private decimal checkValue(string Value)
    {
        if (Value == "&nbsp;")
            return 0;
        else
            return decimal.Parse(Value);

    }
}