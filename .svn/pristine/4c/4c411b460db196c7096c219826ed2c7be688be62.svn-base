using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public partial class POS_Download_Ready : System.Web.UI.Page
{
    

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.Attributes.Add("enctype", "multipart/form-data");
        TrustControl1.getUserRoles();
        //if (!IsPostBack)
        //{
        //    txtDateFrom.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        //    txtDateTo.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        //    TextBox1.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        //    TextBox2.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        //    TextBox3.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        //    TextBox4.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        //}
        DropDownList1.BackColor = System.Drawing.Color.Yellow;
        DropDownList2.BackColor = System.Drawing.Color.Yellow;
        if (!IsPostBack)
        {
            SetDate_Today();
            RefreshControls();
            //TextBox6.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            //TextBox5.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            //TextBox3.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
            //TextBox4.Text = string.Format("{0:dd/MM/yyyy}", DateTime.Now.Date);
        }


        if (!Directory.Exists(Server.MapPath("Upload")))
        {
            Directory.CreateDirectory(Server.MapPath("Upload"));
        }
       // GridView1.DataBind();

       
        }
    protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        //string Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        TrustControl1.ClientMsg("Deleted Successfully.");
        GridView1.DataBind();
    }
    private void SetDate_Today()
    {
        TextBox1.Text = DateTime.Now.ToString("dd/MM/yyyy");
        TextBox2.Text = DateTime.Now.ToString("dd/MM/yyyy");
        TextBox3.Text = DateTime.Now.ToString("dd/MM/yyyy");
        TextBox4.Text = DateTime.Now.ToString("dd/MM/yyyy");
        TextBox5.Text = DateTime.Now.ToString("dd/MM/yyyy");
        TextBox6.Text = DateTime.Now.ToString("dd/MM/yyyy");
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RefreshControls();
    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        RefreshControls2();
    }
    private void RefreshControls2()
    {
        DateTime T = DateTime.Now.Date;
        DateTime S = T;
        DateTime E = T;

        if (DropDownList2.SelectedItem.Value == "Custom Range")
        {
            DropDownList2.BackColor = System.Drawing.Color.Transparent;
            TextBox3.Enabled = true;
            TextBox4.Enabled = true;
        }
        else
        {
            DropDownList2.BackColor = System.Drawing.Color.Yellow;

            switch (DropDownList2.SelectedItem.Value)
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
                TextBox3.Text = "";
                TextBox4.Text = "";
            }
            else
            {
                TextBox3.Text = S.ToString("dd/MM/yyyy");
                TextBox4.Text = E.ToString("dd/MM/yyyy");
            }

            RefreshLabel();

            GridView3.DataBind();

            TextBox3.Enabled = false;
            TextBox4.Enabled = false;
        }
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
    private void RefreshLabel()
    {

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView3.DataBind();
    }
    protected void btnDownload_Click(object sender, EventArgs e)
    {
        string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
        SqlConnection oConn = new SqlConnection(oConnString);
        SqlCommand oCommand = new SqlCommand("s_Pos_Download_Batch_Update", oConn);
        oCommand.CommandType = CommandType.StoredProcedure;

        oCommand.Parameters.AddWithValue("Emp", Session["EmpID"].ToString());
        ////oCommand.Parameters.AddWithValue("done","").Direction=ParameterDirection.Output;
        //if (oConn.State == ConnectionState.Closed)
        //    oConn.Open();
        SqlDataAdapter da = new SqlDataAdapter(oCommand);
        DataSet ds = new DataSet();
        ds.Clear();
        da.Fill(ds);

        if (ds.Tables[0].Rows.Count > 0)
        {           
            TrustControl1.ClientMsg("Batch Update Successfully");
            btnDownload.Visible = false;
            GridView2.Visible = false;
            GridView1.DataBind();
            GridView1.Visible = true;
            Panel1.Visible = true;
        }
        else
            TrustControl1.ClientMsg("Wrong");

       
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (GridView2.Rows.Count > 0)
            btnDownload.Visible = true;
        else
        {
            btnDownload.Visible = false;
            //GridView1.Visible = false;
            //Panel1.Visible = false;
        }
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();

    }
    

     protected void Button2_Click(object sender, EventArgs e)
     {
         GridView4.DataBind();

     }
    
    protected void tabContainer_ActiveTabChanged(object sender, EventArgs e)
    {
        if (tabContainer.ActiveTabIndex == 1)
            GridView1.DataBind();
        else if (tabContainer.ActiveTabIndex == 2)
            GridView3.DataBind();
        else if (tabContainer.ActiveTabIndex == 3)
            GridView4.DataBind();
        else if (tabContainer.ActiveTabIndex == 4)
            GridView5.DataBind();
    }
}
  

