using System;

public partial class Card_Mailer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        Page.Title = "Card Mailer";
    }
    protected void cmdOK_Click(object sender, EventArgs e)
    {
        //if (IsPostBack)
        {
            SqlDataSource1.DataBind();

            CrystalReportSource1.Report.Parameters[0].DefaultValue = Session["EMPID"].ToString();
            CrystalReportSource1.Report.Parameters[1].DefaultValue = txtStartsWith.Text.Trim();
            CrystalReportSource1.Report.Parameters[2].DefaultValue = string.Format("{0}", Request.QueryString["batch"]);

            CrystalReportSource1.DataBind();
            CrystalReportViewer1.Visible = true;
        }
    }
}