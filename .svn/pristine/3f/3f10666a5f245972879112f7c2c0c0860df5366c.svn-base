using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Atm_Cash_Load : System.Web.UI.Page
{
    bool Done = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        this.Title = "ATM Cash Load";
        txtSearch.Focus();

        if (Session["BRANCHID"].ToString() == "1" 
            && Session["DEPTID"].ToString() == "60")
        {
        }
        else
        {
            cmdShowModalHidden.Enabled = false;
            cmdShowModalHidden.Text = "";
        }
    }

    protected void dboBranch_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in dboBranch.Items)
            i.Selected = false;


        if (Session["BRANCHID"].ToString() == "1")
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
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Confirm")
        {
            string ID = e.CommandArgument.ToString();

            string Msg = "";

            using (SqlConnection conn = new SqlConnection())
            {
                string Query = "s_Atm_CashLoad_Confirmation";
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = Query;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ID", System.Data.SqlDbType.Int).Value = ID;
                    cmd.Parameters.Add("@Load_ConfirmBy", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();

                    SqlParameter Sql_Msg = new SqlParameter("@Msg", System.Data.SqlDbType.VarChar, 255);
                    Sql_Msg.Direction = System.Data.ParameterDirection.InputOutput;
                    Sql_Msg.Value = Msg;
                    cmd.Parameters.Add(Sql_Msg);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();
                    Msg = string.Format("{0}", Sql_Msg.Value);
                }
            }

            GridView1.DataBind();

            TrustControl1.ClientMsg(Msg);                     

        }
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
    protected void ButtonNew_Click(object sender, EventArgs e)
    {
     //   GridView2.DataBind();
    }
    //protected void DetailsViewforModal_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    //{
    //   // DetailsView1.ChangeMode(DetailsViewMode.ReadOnly);
    //    modal.Show();
    //}
    protected void cmdPopup_Click(object sender, EventArgs e)
    {
        DetailsViewforModal.DataBind();
        modal.Show();
    }
    protected void SqlDataSource2_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        TrustControl1.ClientMsg(string.Format("{0}", e.Command.Parameters["@Msg"].Value));

        GridView1.DataBind();
    }
}