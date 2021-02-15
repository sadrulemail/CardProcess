﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Card_Scoring : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        string SL = string.Format("{0}", Request.QueryString["id"]);
        if (!IsPostBack)
        {
            if (SL.Length > 0)
            {
                litTitle.Text = SL + ". Credit Card Scoring & Approval Sheet";
                Title = SL + ". Credit Card Scoring & Approval Sheet";
            }
            else
            {
                DetailsView1.ChangeMode(DetailsViewMode.Insert);
                litTitle.Text = "Add New Credit Card Scoring & Approval Sheet";
                Title = "New Credit Card Scoring & Approval Sheet";

                ((TextBox)DetailsView1.FindControl("txtAC1")).Text = "CR Manager, Retail Credit Risk";
                ((TextBox)DetailsView1.FindControl("txtAC2")).Text = "AVP, Retail Credit Risk";
                ((TextBox)DetailsView1.FindControl("txtAC3")).Text = "EVP, CRM Division, HO";
                ((TextBox)DetailsView1.FindControl("txtAC4")).Text = "Deputy Managing Director";
                ((TextBox)DetailsView1.FindControl("txtAC5")).Text = "Managing Director";
            }
        }
    }

    protected void SqlDataSource1_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        long SL = (long)e.Command.Parameters["@SL"].Value;
        string Msg = e.Command.Parameters["@Msg"].Value.ToString();

        if (SL > 0)
            Response.Redirect(string.Format("Card_Scoring.aspx?id={0}", SL), true);
    }

    protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        string SL = e.Command.Parameters["@SL"].Value.ToString();
        string Msg = e.Command.Parameters["@Msg"].Value.ToString();

        TrustControl1.ClientMsg(Msg);
    }
}