using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Export_Visa_OffUS_Data : System.Web.UI.Page
{
    public DataSet ds=new DataSet();
    decimal TotalTransactionAmount = (decimal)0.0;
    decimal TotalPaymentAmount = (decimal)0.0;
    decimal CommissionAmount = (decimal)0.0;
    decimal TotalITCLCommissionAmount = (decimal)0.0;

    protected void Page_Load(object sender, EventArgs e)
    {
        string batch = Request.QueryString["batch"];

        if (!IsPostBack && batch != null)
        {
            txtBatch.Text = batch;
            cmdOK_Click(sender, e);
        }
        

        //string focusScript = "document.getElementById('" + txtFilter.ClientID + "').focus();";
        //TrustControl1.ClientScriptStartup("setTimeout(\"" + focusScript + ";\",100);");
        //Panel1.Visible = false;
    }

    protected void cmdOK_Click(object sender, EventArgs e)
    {
        //TrustControl1.ClientMsg("Not Completed..");
        //return;
        string batchno = txtBatch.Text;
        if (string.IsNullOrEmpty(txtBatch.Text))
        {
            TrustControl1.ClientMsg("Please Type Batch No.");
        }
        else
        {
            string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
            SqlConnection oConn = new SqlConnection(oConnString);


            SqlCommand oCommand = new SqlCommand("s_POSReconcilationVisaOffUSTrasactionReconcilation", oConn);
                
                    oCommand.CommandType = CommandType.StoredProcedure;
                    oCommand.Parameters.AddWithValue("BatchNo", batchno);
                    //oCommand.Parameters.AddWithValue("done","").Direction=ParameterDirection.Output;
                    if (oConn.State == ConnectionState.Closed)
                        oConn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(oCommand);
                    //ds = new DataSet();
                    ds.Clear();
                    da.Fill(ds);

                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        lblmsg.Visible = true;
                        lblmsg.Text = "Remarks : " + ds.Tables[0].Rows[0][0].ToString();

                        GridView1.DataSource = ds.Tables[1];
                        GridView1.DataBind();
                        GridView1.Visible = true;
                        btnDownload.Visible = true;
                        txtBatch.Enabled = false;
                        Button1.Visible = true;
                        Button2.Visible = true;
                    }
                    else
                    {
                        lblmsg.Text = "";
                        lblmsg.Visible = false;
                        GridView1.DataSource = null;
                        GridView1.DataBind();
                        TrustControl1.ClientMsg("No Record(s) Found.");
                    }
                
            
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // check row type
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotalTransactionAmount += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TransactionAmount"));
            TotalPaymentAmount += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PaymentAmount"));
            CommissionAmount += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "CommissionAmount"));
            //TotalITCLCommissionAmount += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ITCLCommission"));
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[0].Text = "Totals:";
            e.Row.Cells[3].Text = String.Format("{0:N2}", TotalTransactionAmount);
            e.Row.Cells[4].Text = String.Format("{0:N2}", TotalPaymentAmount);
            e.Row.Cells[5].Text = String.Format("{0:N2}", CommissionAmount);
            //e.Row.Cells[6].Text = String.Format("{0:N2}", TotalITCLCommissionAmount);
        }
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {           
            string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
            SqlConnection oConn = new SqlConnection(oConnString);
            SqlCommand oCommand = new SqlCommand("s_POSReconcilationVisaOffUSTrasactionReconcilation", oConn);
            oCommand.CommandType = CommandType.StoredProcedure;
            oCommand.Parameters.AddWithValue("BatchNo", txtBatch.Text.Trim());
            //oCommand.Parameters.AddWithValue("done","").Direction=ParameterDirection.Output;
            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(oCommand);
            //ds = new DataSet();
            ds.Clear();
            da.Fill(ds);


            //Start On-Us file processing of 1st download

            string OnUsFileName = System.IO.Path.GetRandomFileName();
            //string sGenName = "Friendly.txt";

            using (System.IO.StreamWriter SW = new System.IO.StreamWriter(
                   Server.MapPath("TextFiles/" + OnUsFileName + ".txt")))
            {
                string line0 = "AccountNo" + "," + "Amount_tk" + "," + "Dr_Cr" + "," + "Tm_br_code";
                SW.WriteLine(line0); 
                foreach (DataRow dr in ds.Tables[2].Rows)
                {
                    string line = dr[0].ToString() + "," + dr[1].ToString() + "," + dr[2].ToString() + "," + dr[3].ToString();
                    SW.WriteLine(line);                    
                }
                SW.Close();
            }
            //End On-Us file processing of 1st download      
            


            //Reading File Content of 1st download
            byte[] content = File.ReadAllBytes(Server.MapPath("TextFiles/" + OnUsFileName + ".txt"));
            File.Delete(Server.MapPath("TextFiles/" + OnUsFileName + ".txt"));        

            //Downloading File
            string onus_download_file_name = "OFS_Visa_Off_Us" + DateTime.Now.Year + DateTime.Now.ToString("MM") + DateTime.Now.ToString("dd") + DateTime.Now.Hour + DateTime.Now.Minute + ".txt";
            Response.ContentType = "text/plain";
            Response.OutputStream.Write(content, 0, content.Length);
            Response.AddHeader("Content-Disposition", "attachment;filename=" + onus_download_file_name);
            Response.End();

        }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
        SqlConnection oConn = new SqlConnection(oConnString);
        SqlCommand oCommand = new SqlCommand("s_POSReconcilationVisaOffUSTrasactionReconcilation", oConn);
        oCommand.CommandType = CommandType.StoredProcedure;
        oCommand.Parameters.AddWithValue("BatchNo", txtBatch.Text.Trim());
        //oCommand.Parameters.AddWithValue("done","").Direction=ParameterDirection.Output;
        if (oConn.State == ConnectionState.Closed)
            oConn.Open();
        SqlDataAdapter da = new SqlDataAdapter(oCommand);
        //ds = new DataSet();
        ds.Clear();
        da.Fill(ds);


        //Start On-Us file processing of 1st download

        string OnUsFileName = System.IO.Path.GetRandomFileName();
        //string sGenName = "Friendly.txt";

        using (System.IO.StreamWriter SW = new System.IO.StreamWriter(
               Server.MapPath("TextFiles/" + OnUsFileName + ".txt")))
        {
            string line0 = "AccountNo" + "," + "Amount_tk" + "," + "Dr_Cr" + "," + "Tm_br_code";
            SW.WriteLine(line0);
            foreach (DataRow dr in ds.Tables[3].Rows)
            {
                string line = dr[0].ToString() + "," + dr[1].ToString() + "," + dr[2].ToString() + "," + dr[3].ToString();
                SW.WriteLine(line);
            }
            SW.Close();
        }
        //End On-Us file processing of 1st download      



        //Reading File Content of 1st download
        byte[] content = File.ReadAllBytes(Server.MapPath("TextFiles/" + OnUsFileName + ".txt"));
        File.Delete(Server.MapPath("TextFiles/" + OnUsFileName + ".txt"));

        //Downloading File
        string onus_download_file_name = "OFS_Visa_Off_Us" + DateTime.Now.Year + DateTime.Now.ToString("MM") + DateTime.Now.ToString("dd") + DateTime.Now.Hour + DateTime.Now.Minute + ".txt";
        Response.ContentType = "text/plain";
        Response.OutputStream.Write(content, 0, content.Length);
        Response.AddHeader("Content-Disposition", "attachment;filename=" + onus_download_file_name);
        Response.End();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
        SqlConnection oConn = new SqlConnection(oConnString);
        SqlCommand oCommand = new SqlCommand("s_POSReconcilationVisaOffUSTrasactionReconcilation", oConn);
        oCommand.CommandType = CommandType.StoredProcedure;
        oCommand.Parameters.AddWithValue("BatchNo", txtBatch.Text.Trim());
        //oCommand.Parameters.AddWithValue("done","").Direction=ParameterDirection.Output;
        if (oConn.State == ConnectionState.Closed)
            oConn.Open();
        SqlDataAdapter da = new SqlDataAdapter(oCommand);
        //ds = new DataSet();
        ds.Clear();
        da.Fill(ds);


        //Start On-Us file processing of 1st download

        string OnUsFileName = System.IO.Path.GetRandomFileName();
        //string sGenName = "Friendly.txt";

        using (System.IO.StreamWriter SW = new System.IO.StreamWriter(
               Server.MapPath("TextFiles/" + OnUsFileName + ".txt")))
        {
            string line0 = "FromAccountNo" + "," + "ToAccountNo" + "," + "Amount_tk";
            SW.WriteLine(line0);
            foreach (DataRow dr in ds.Tables[4].Rows)
            {
                string line = dr[0].ToString() + "," + dr[1].ToString() + "," + dr[2].ToString();
                SW.WriteLine(line);
            }
            SW.Close();
        }
        //End On-Us file processing of 1st download      



        //Reading File Content of 1st download
        byte[] content = File.ReadAllBytes(Server.MapPath("TextFiles/" + OnUsFileName + ".txt"));
        File.Delete(Server.MapPath("TextFiles/" + OnUsFileName + ".txt"));

        //Downloading File
        string onus_download_file_name = "OFS_Visa_Off_Us" + DateTime.Now.Year + DateTime.Now.ToString("MM") + DateTime.Now.ToString("dd") + DateTime.Now.Hour + DateTime.Now.Minute + ".txt";
        Response.ContentType = "text/plain";
        Response.OutputStream.Write(content, 0, content.Length);
        Response.AddHeader("Content-Disposition", "attachment;filename=" + onus_download_file_name);
        Response.End();
    }
}