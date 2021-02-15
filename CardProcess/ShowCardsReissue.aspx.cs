using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public partial class ShowCardsReissue : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        string CardType = Request.QueryString["cardtype"];
        string Branch = Request.QueryString["branch"];


        GridView2.DataBind();




    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblmsg.Text = string.Format("Total Records: <b>{0:N0}</b>", e.AffectedRows);
    }
}
  

