using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Search_SMS_Alert_Request : System.Web.UI.Page
{
    

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (!IsPostBack)
        {
            SetDate_Today();
            RefreshControls();
        }

    }


   
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void cboBranch_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in cboBranch.Items)

            i.Selected = false;


        if (Session["BRANCHID"].ToString() != "1")
        {
            foreach (ListItem ii in cboBranch.Items)
            {
                if (ii.Value == Session["BRANCHID"].ToString())
                    ii.Selected = true;
                else
                    ii.Enabled = false;
            }
        }
        GridView1.DataBind();

    }
    protected void cboStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void cboBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            string Msg = "";
            bool done = false;
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "Authorize" || e.CommandName == "Delete1")
            {
                using (SqlConnection conn = new SqlConnection())
                {
                    string Query = "s_SMS_Alert_Request_Auth_Delete";

                    conn.ConnectionString = System.Configuration.ConfigurationManager
                                    .ConnectionStrings["CardDataConnectionString"].ConnectionString;

                    using (SqlCommand cmd = new SqlCommand(Query, conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add("@ReqID", System.Data.SqlDbType.VarChar).Value = id;
                        cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                        cmd.Parameters.Add("@BranchID", System.Data.SqlDbType.VarChar).Value = Session["BRANCHID"].ToString();
                        if (e.CommandName == "Authorize")
                            cmd.Parameters.Add("@ReqType", System.Data.SqlDbType.VarChar).Value = "Authorize";
                        else if (e.CommandName == "Delete1")
                            cmd.Parameters.Add("@ReqType", System.Data.SqlDbType.VarChar).Value = "Delete";

                        SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                        SQL_Msg.Direction = ParameterDirection.InputOutput;
                        SQL_Msg.Value = Msg;
                        cmd.Parameters.Add(SQL_Msg);

                        SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                        SQL_Done.Direction = ParameterDirection.InputOutput;
                        SQL_Done.Value = done;
                        cmd.Parameters.Add(SQL_Done);

                        cmd.Connection = conn;
                        conn.Open();

                        cmd.ExecuteNonQuery();

                        done = (bool)SQL_Done.Value;
                        Msg = string.Format("{0}", SQL_Msg.Value);
                        TrustControl1.ClientMsg(Msg);
                        GridView1.DataBind();
                    }
                }
            }   
        }
       
        catch(Exception exx) { TrustControl1.ClientMsg(exx.ToString()); }
    }
    //protected void cboBranch_DataBound(object sender, EventArgs e)
    //{
    //    foreach (ListItem i in cboBranch.Items)

    //        i.Selected = false;


    //    if (Session["BRANCHID"].ToString() != "1")
    //    {
    //        foreach (ListItem i in cboBranch.Items)
    //            if (i.Value == Session["BRANCHID"].ToString())
    //                i.Selected = true;
    //    }

    //}
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RefreshControls();
    }
    private void RefreshControls()
    {
        DateTime T = DateTime.Now.Date;
        DateTime S = T;
        DateTime E = T;

        if (DropDownList1.SelectedItem.Value == "Custom Range")
        {
            DropDownList1.BackColor = System.Drawing.Color.Transparent;
            TextBox1.Enabled = true;
            TextBox2.Enabled = true;
        }
        else
        {
            DropDownList1.BackColor = System.Drawing.Color.Yellow;

            switch (DropDownList1.SelectedItem.Value)
            {
                case "Today":
                    SetDate_Today();
                    break;
                case "Yesterday":
                    S = T.AddDays(-1);
                    E = T.AddDays(-1);
                    break;
                case "This Week":
                    S = T.AddDays(-int.Parse(T.DayOfWeek.ToString("d")));
                    E = T;
                    break;
                case "Last Week":
                    S = T.AddDays(-7 - int.Parse(T.DayOfWeek.ToString("d")));
                    E = S.AddDays(6);
                    break;
                case "This Month":
                    S = T.AddDays(-T.Day + 1);
                    E = T;
                    break;
                case "Last Month":
                    S = (T.AddDays(-T.Day + 1)).AddMonths(-1);
                    E = T.AddDays(-T.Day);
                    break;
                case "This Year":
                    S = T.AddDays(-T.DayOfYear + 1);
                    E = T;
                    break;
                case "Show All":
                    S = new DateTime(1900, 1, 1);
                    E = S;
                    break;
            }

            if (S == new DateTime(1900, 1, 1))
            {
                TextBox1.Text = "";
                TextBox2.Text = "";
            }
            else
            {
                TextBox1.Text = S.ToString("dd/MM/yyyy");
                TextBox2.Text = E.ToString("dd/MM/yyyy");
            }

            RefreshLabel();

            GridView1.DataBind();

            TextBox1.Enabled = false;
            TextBox2.Enabled = false;
        }
    }
    private void SetDate_Today()
    {
        TextBox1.Text = DateTime.Now.ToString("dd/MM/yyyy");
        TextBox2.Text = DateTime.Now.ToString("dd/MM/yyyy");
    }
    private void RefreshLabel()
    {
        if (TextBox1.Text.Trim() == TextBox2.Text.Trim() && TextBox1.Text.Trim() != "")
            lblTitle.Text = "Items entry on " + TextBox1.Text;
        else if (TextBox1.Text.Trim() != "" && TextBox2.Text.Trim() != "")
            lblTitle.Text = "Items entry from " + TextBox1.Text + " to " + TextBox2.Text;
        else
            lblTitle.Text = "All items entry";
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if(e.AffectedRows>0)
        {
            lblStatus.Text = string.Format("Total: <b>{0:N0}</b>", e.AffectedRows);
        }
        else
        {
            lblStatus.Text = "";
        }
    }
}
    
   
