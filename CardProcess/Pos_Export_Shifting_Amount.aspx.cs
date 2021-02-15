using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.UI;

public partial class Pos_Export_Shifting_Amount : System.Web.UI.Page
{
    public DataSet ds = new DataSet();
    public decimal TotalDr = 0;
    public decimal TotalCr = 0;
    string batch;
    string type;


    protected void Page_Load(object sender, EventArgs e)
    {
        batch = Request.QueryString["batch"];
        type = Request.QueryString["type"];

        TrustControl1.getUserRoles();

        

        string oConnStrings = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
        SqlConnection oConns = new SqlConnection(oConnStrings);
        SqlCommand oCommands = new SqlCommand("SELECT ShiftingDownloadCount FROM dbo.PosDownloadLog WHERE Batch=@DownloadBatch", oConns);
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

        if (!IsPostBack && batch!= null && type=="txt")
        {
            string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
            SqlConnection oConn = new SqlConnection(oConnString);
            SqlCommand oCommand = new SqlCommand("s_Pos_Download_Batch", oConn);
            oCommand.CommandType = CommandType.StoredProcedure;
            oCommand.Parameters.AddWithValue("DownloadBatch", batch);
            oCommand.Parameters.AddWithValue("Type", "SA");
            //oCommand.Parameters.AddWithValue("done","").Direction=ParameterDirection.Output;
            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(oCommand);
            //ds = new DataSet();
            ds.Clear();
            da.Fill(ds);


            //Start On-Us file processing of 1st download

            string FileName = System.IO.Path.GetRandomFileName();
            //string sGenName = "Friendly.txt";

            StringBuilder SW = new StringBuilder();

          
            {
                string line0 = "AccountNo" + "," + "Amount_tk" + "," + "Dr_Cr" + "," + "Tm_br_code";
                SW.Append(line0).AppendLine();
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    string line = dr[0].ToString() + "," + dr[1].ToString() + "," + dr[2].ToString() + "," + dr[3].ToString();
                    SW.Append(line).AppendLine();
                }
            }
            
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

        if (!IsPostBack && batch != null && type == "SA")
        {
            lblTitle.Text = "Shifting Amount Download Batch#" + batch;
            GridView2.DataBind();
        }
    }


    protected void GridView2_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        // check row type
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (DataBinder.Eval(e.Row.DataItem, "Dr_Cr").ToString() == "DR")
                TotalDr += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount_tk"));
            else
                TotalCr += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount_tk"));
           
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[1].Text = "CR Amount=" + String.Format("{0:N2}", TotalCr);
            e.Row.Cells[2].Text = "DR Amount=" + String.Format("{0:N2}", TotalDr);
           
        }
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {        
        Response.Redirect("Pos_Export_Shifting_Amount.aspx?batch=" + batch + "&type=txt", false);
        
    }
}