﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class NewCardAuth : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
      
        Title = "New Card Authorize Browse";
        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        GridView1.DataBind();

    }
    protected void dboBranchCode_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in dboReqBranch.Items)
            i.Selected = false;

        if (Session["BRANCHID"].ToString() != "1")
        {
            foreach (ListItem ii in dboReqBranch.Items)
            {
                if (ii.Value == Session["BRANCHID"].ToString())
                    ii.Selected = true;
                else
                    ii.Enabled = false;
            }
        }
    }


    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Visible = e.AffectedRows > 0;
        lblStatus.Text = string.Format("Total: <b>{0}</b><br /><br />", e.AffectedRows);

    }
   
   
    protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        string Msg = e.Command.Parameters["@Msg"].Value.ToString();
        TrustControl1.ClientMsg(Msg);
        GridView1.DataBind();
        GridView1.SelectedIndex = -1;
    }
   
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Authorize")
            {
                string ID = e.CommandArgument.ToString();

                string Msg = "";
                bool done = false;

                using (SqlConnection conn = new SqlConnection())
                {
                    string Query = "s_dispute_auth";
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;

                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = Query;
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add("@ID", System.Data.SqlDbType.VarChar).Value = ID;
                        cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                        cmd.Parameters.Add("@BranchID", System.Data.SqlDbType.TinyInt).Value = Session["BranchID"].ToString();

                        SqlParameter Sql_Msg = new SqlParameter("@Msg", System.Data.SqlDbType.VarChar, 255);
                        Sql_Msg.Direction = System.Data.ParameterDirection.InputOutput;
                        Sql_Msg.Value = Msg;
                        cmd.Parameters.Add(Sql_Msg);

                        SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                        SQL_Done.Direction = ParameterDirection.InputOutput;
                        SQL_Done.Value = done;
                        cmd.Parameters.Add(SQL_Done);

                        cmd.Connection = conn;
                        conn.Open();

                        cmd.ExecuteNonQuery();
                        Msg = string.Format("{0}", Sql_Msg.Value);
                    }
                }
                
                TrustControl1.ClientMsg(Msg);
                GridView1.DataBind();

            }
           
        }
        catch(Exception exx) { TrustControl1.ClientMsg(exx.Message); }
    }
}


