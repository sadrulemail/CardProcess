using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;

public partial class Atm_Load_Summary : System.Web.UI.Page
{
    bool Done = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        this.Title = "ATM Load Summary";
        //txtSearch.Focus();

        if (!IsPostBack)
        {
            txtEndDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Today);
            txtStartDate.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Today);
        }
    }

    protected void dboBranch_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in dboBranch.Items)
            i.Selected = false;


        if (Session["BRANCHID"].ToString() == "1" )
        {
        }
        else
        {
            foreach (ListItem ii in dboBranch.Items)
            {
                if (ii.Value == Session["BRANCHID"].ToString())
                {
                    ii.Selected = true;
                }
                else
                    ii.Enabled = false;
            }
        }
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total: <b>{0}</b>", e.AffectedRows);

        //e.Command.Connection.Open();
        //System.Data.Common.DbDataReader oReader = e.Command.ExecuteReader();

        //double BeforeLoadAmount = 0;
        //double LoadAmount = 0;
        //double AfterLoadAmount = 0;

        //while (oReader.Read())
        //{
        //    BeforeLoadAmount += double.Parse(oReader["BeforeLoadAmount"].ToString());
        //    LoadAmount += double.Parse(oReader["LoadAmount"].ToString());
        //    AfterLoadAmount += double.Parse(oReader["AfterLoadAmount"].ToString());
        //}

        lblBeforeLoadAmount.Text = string.Format(TrustControl1.Bangla, "{0:N0}", e.Command.Parameters["@BeforeLoadAmount"].Value);
        lblLoadAmount.Text = string.Format(TrustControl1.Bangla, "{0:N0}", e.Command.Parameters["@LoadAmount"].Value);
        lblAfterLoadAmount.Text = string.Format(TrustControl1.Bangla, "{0:N0}", e.Command.Parameters["@AfterLoadAmount"].Value);
        lblTotalNo.Text = string.Format(TrustControl1.Bangla, "{0:N0}", e.Command.Parameters["@TotalNo"].Value);

        //double number = 123456789123.456;
        //string whatYouWant = number.ToString("N2", TrustControl1.Bangla);
        //lblAfterLoadAmount.Text = whatYouWant;
    }
    protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        Done = (bool)e.Command.Parameters["@Done"].Value;
        TrustControl1.ClientMsg(e.Command.Parameters["@Msg"].Value.ToString());
        GridView1.DataBind();
    }
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        if (!Done)
            e.KeepInEditMode = true;
    }
  

    protected void GridView1_PageIndexChanged(object sender, EventArgs e)
    {
        GridView1.EditIndex = -1;
    }

    protected void GridView1_Sorted(object sender, EventArgs e)
    {
        GridView1.EditIndex = -1;
    }

    protected void cmdSearch_Click(object sender, EventArgs e)
    {
        GridView1.EditIndex = -1;
    }

    protected void cmdPreviousDay_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime DT = DateTime.Parse(txtStartDate.Text);
            txtStartDate.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(-1));
            txtEndDate.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(-1));
            //RefreshData();
        }
        catch (Exception) { }
    }

    protected void cmdNextDay_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime DT = DateTime.Parse(txtStartDate.Text);
            txtStartDate.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(1));
            txtEndDate.Text = string.Format("{0:dd/MM/yyyy}", DT.AddDays(1));
            //RefreshData();
        }
        catch (Exception) { }
    }
}