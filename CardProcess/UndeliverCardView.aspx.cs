using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using SocialExplorer.IO.FastDBF;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

public partial class UndeliverCardView : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        // SqlDataSource6_Selected(sender,e);
        //SqlDataSource6.DataBind();
        //lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
        //string deleted= string.Format("Total Rows: <b>{0:N0}</b>", e.Command.Parameters["@DeleteCount"]);
        //TrustControl1.ClientMsg(deleted);
        //SqlDataSource6.Select(DataSourceSelectArguments.Empty);

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
   
  

}