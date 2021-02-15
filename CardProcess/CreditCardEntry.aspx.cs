using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CreditCardEntry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();        

        Title = "Credit Card Entry";

        if (!IsPostBack)
        {
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            string ID = string.Format("{0}", Request.QueryString["ID"]);            
            if (ID.Length == 0)
            {
                DetailsView1.DefaultMode = DetailsViewMode.Insert;                
            }
            else
            {
                Page.Title = "Dispute ID # " + ID;
                HidID.Value = ID;                
                DetailsView1.DataBind();
               

            }
        }

    }
    protected void SqlDataSource2_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string msg = e.Command.Parameters["@Msg"].Value.ToString();
        TrustControl1.ClientMsg(msg);
        GridView1.DataBind();
    }
    protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        string msg = e.Command.Parameters["@Msg"].Value.ToString();
        TrustControl1.ClientMsg(msg);
        GridView1.DataBind();
    }
    protected void cmdNew_Click(object sender, EventArgs e)
    {
        DetailsView1.ChangeMode(DetailsViewMode.Insert);
        //cmdNew.Visible = false;
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }
}
