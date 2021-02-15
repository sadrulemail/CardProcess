using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;

public partial class Pos_Export_Merchant_Amount : System.Web.UI.Page
{
    public DataSet ds=new DataSet();
    public decimal Total = 0;
    string batch;
    string type;


    protected void Page_Load(object sender, EventArgs e)
    {
         batch = Request.QueryString["batch"];
         type = Request.QueryString["type"];

        TrustControl1.getUserRoles();

        string oConnStrings = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
        SqlConnection oConns = new SqlConnection(oConnStrings);
        SqlCommand oCommands = new SqlCommand("SELECT MerchantDownloadCount FROM dbo.PosDownloadLog WHERE Batch=@DownloadBatch", oConns);
        oCommands.CommandType = CommandType.Text;
        oCommands.Parameters.AddWithValue("DownloadBatch", batch);

        if (oConns.State == ConnectionState.Closed)
            oConns.Open();
        SqlDataAdapter daa = new SqlDataAdapter(oCommands);
        DataSet dsss = new DataSet();
        dsss.Clear();
        daa.Fill(dsss);

        if (Convert.ToInt32(dsss.Tables[0].Rows[0][0].ToString()) > 0)
        {
            ddd.Enabled = true;
            lblCount.Text = dsss.Tables[0].Rows[0][0].ToString();
        }
        else
            ddd.Enabled = false;

        if (!IsPostBack && batch != null && type == "txt")
        {
            string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
            SqlConnection oConn = new SqlConnection(oConnString);
            SqlCommand oCommand = new SqlCommand("s_Pos_Download_Batch", oConn);
            oCommand.CommandType = CommandType.StoredProcedure;
            oCommand.Parameters.AddWithValue("DownloadBatch", batch);
            oCommand.Parameters.AddWithValue("Type", "MA");
            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(oCommand);
            //ds = new DataSet();
            DataSet Dss = new DataSet();
            da.Fill(Dss);


            //Start On-Us file processing of 1st download

            string FileName = System.IO.Path.GetRandomFileName();
            //string sGenName = "Friendly.txt";

           StringBuilder SW = new StringBuilder();

                //string line0 = "FromAccountNo" + "," + "ToAccountNo" + "," + "Amount_tk";
                //SW.Append(line0).AppendLine();
                //foreach (DataRow dr in Dss.Tables[0].Rows)
                //{
                //    string line = dr[0].ToString() + "," + dr[1].ToString() + "," + dr[2].ToString();
                //    SW.Append(line).AppendLine();
                //}

           string line0 = "AccountNo" + "," + "Amount_tk" + "," + "Dr_Cr" + "," + "Tm_br_code";
           SW.Append(line0).AppendLine();
           foreach (DataRow dr in Dss.Tables[0].Rows)
           {
               string line = dr[0].ToString() + "," + dr[1].ToString() + "," + dr[2].ToString() + "," + dr[3].ToString();
               SW.Append(line).AppendLine();
           }    
           

            //Downloading File
            string download_file_name = "attachment; filename=OFS" + DateTime.Now.Year + DateTime.Now.ToString("MM") + DateTime.Now.ToString("dd") + DateTime.Now.Hour + DateTime.Now.Minute + ".txt";
            Response.ClearHeaders();
            Response.Clear();
            Response.ClearContent();
            Response.AddHeader("content-disposition", download_file_name);
            Response.ContentType = "text/plain";
            Response.AddHeader("Pragma", "public");

            Response.Write(SW);
            Response.End();
        }

        if (!IsPostBack && batch != null && type == "MA")
        {
            lblTitle.Text = "Marchent Amount Download Batch#" + batch;
            GridView2.DataBind();
        }


    }

    protected void GridView2_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        // check row type
        if (e.Row.RowType == DataControlRowType.DataRow)
        {           
                Total += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount_tk"));
          
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {           

            e.Row.Cells[3].Text = "Total:";
            e.Row.Cells[4].Text =  String.Format("{0:N2}", Total);

        }
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {

        Response.Redirect("Pos_Export_Merchant_Amount.aspx?batch=" + batch + "&type=txt");
    }
   
}