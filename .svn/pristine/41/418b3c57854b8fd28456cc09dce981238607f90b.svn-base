using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VIP_Tours : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        //if (!TrustControl1.isRole("ADMIN"))
        //{            
        //    Response.Write("No Permission.<br><br><a href=''>Home</a>");
        //    Response.End();        
        //}

        if(!IsPostBack)
        {
            hidITCLID.Value = string.Format("{0}", Request.QueryString["ITCLID"]);
        }
        Title = string.Format("{0}. Travel Details", hidITCLID.Value);
        lblTitle.Text = string.Format("Travel Details of ITCL ID: {0}", hidITCLID.Value);
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
        cmdNew.Visible = false;
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
    }


    public string getTravelText(object FromDate, object ToDate)
    {
        DateTime Totay = DateTime.Now;
        DateTime FD = DateTime.Parse(FromDate.ToString());
        DateTime TD = DateTime.Parse(ToDate.ToString());
        return "";
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if ((DataBinder.Eval(e.Row.DataItem, "OnTravel")).ToString() == "1")
            {
                e.Row.BackColor = System.Drawing.Color.Yellow;
            }
        }
    }
}
