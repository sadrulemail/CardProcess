using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Card_Payment : System.Web.UI.Page
{
    bool Done = false;
    string Msg = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        this.Title = "Credit Card Payment Process";
        
        if (!IsPostBack)
        {
            txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);    
        }
    }

    protected void SqlItemsInsert_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        //bool Done = (bool)e.Command.Parameters["@Done"].Value;    
        TrustControl1.ClientMsg(string.Format("{0}", Msg));
    }



    protected void btnPayment_Click(object sender, EventArgs e)
    {
        SqlItemsInsert.Insert();
        GridView1.DataBind();

        cmdGenerateNewBatch.Visible = true;
        lblDownload.Text = "";
     
    }
    protected void GridView_DataBound(object sender, EventArgs e)
    {

    }
    protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {        
        Done = (bool)e.Command.Parameters["@Done"].Value;
        Msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);   
    }

    protected void tabContainer_ActiveTabChanged(object sender, EventArgs e)
    {
        if (tabContainer.ActiveTabIndex == 0)
        {
            GridView1.DataBind();
        }
        else if (tabContainer.ActiveTabIndex == 1)
        {
            GridView1.DataBind();
        }
    }
    protected void cmdGenerateNewBatch_Click(object sender, EventArgs e)
    {
        //Generate New Batch

        string BatchID = "0";

        string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
        using (SqlConnection oConn = new SqlConnection(oConnString))
        {
            if (oConn.State == ConnectionState.Closed)
                oConn.Open();

            using (SqlCommand oCommand = new SqlCommand("s_CardPaymentCollectionTransactions_GenerateNewBatch", oConn))
            {
                oCommand.CommandType = CommandType.StoredProcedure;
                oCommand.Parameters.Add("@EmpID", SqlDbType.VarChar, 20).Value = Session["EMPID"].ToString();

                SqlParameter SQL_BatchID = new SqlParameter("BatchID", SqlDbType.Int);
                SQL_BatchID.Direction = ParameterDirection.InputOutput;
                SQL_BatchID.Value = BatchID;
                oCommand.Parameters.Add(SQL_BatchID);

                oCommand.ExecuteNonQuery();
                BatchID = string.Format("{0}", SQL_BatchID.Value);
            }
        }

        cmdGenerateNewBatch.Visible = false;
        GridView1.DataBind();

        lblDownload.Text = string.Format("Batch {0}: <a href='Card_Payment_Batch.aspx?batch={0}&type=dbf' target='_blank'>Download</a> | <a href='Card_Payment_Batch.aspx?batch={0}&type=view' target='_blank'>View</a>", BatchID);
    }
    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        cmdGenerateNewBatch.Enabled = (e.AffectedRows > 0);

        if (e.AffectedRows > 0)
            lblStatus1.Text = string.Format("Total Rows: <b>{0}</b><br /><br />", e.AffectedRows);
        else
            lblStatus1.Text = "";
    }

    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        if (!Done)
            e.KeepInEditMode = true;

        TrustControl1.ClientMsg(Msg);
    }



   
}