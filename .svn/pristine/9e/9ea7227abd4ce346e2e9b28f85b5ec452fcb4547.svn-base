using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class CardPrefixWiseShadowAccountSetup : System.Web.UI.Page
{
    string MerchantID = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        //TrustControl1.ClientMsg(Request.QueryString["id"]);
        if (!IsPostBack)
        {
            
        }
        
      
        //string focusScript = "document.getElementById('" + txtFilter.ClientID + "').focus();";
        //TrustControl1.ClientScriptStartup("setTimeout(\"" + focusScript + ";\",100);");
        //Panel1.Visible = false;
    }



    protected void SqlDataSourceMerchantSetup_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        MerchantID = string.Format("{0}", e.Command.Parameters["@MerchantID"].Value);
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);
        if (MerchantID == "-1")
        {
            TrustControl1.ClientMsg(msg);
        }
        else
        {
            TrustControl1.ClientMsg(msg);
            //Response.Redirect("New_Reissue_Request.aspx?id=" + ReqID, true);
        }
        GridView1.DataBind();
        hidMerchantID.Value = MerchantID;
        //DetailsMerchantSetup.Visible = true;
        //DetailsMerchantSetup.ChangeMode(DetailsViewMode.ReadOnly);
        DetailsMerchantSetup.DefaultMode = DetailsViewMode.ReadOnly;
    }
    protected void SqlDataSourceMerchantSetup_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        DetailsMerchantSetup.ChangeMode(DetailsViewMode.ReadOnly);
        DetailsMerchantSetup.DefaultMode = DetailsViewMode.ReadOnly;
        //GridView1.Visible = false;
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);
        TrustControl1.ClientMsg(msg);
        GridView1.DataBind();
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DetailsPartySetup.Visible = true;
        DetailsMerchantSetup.ChangeMode(DetailsViewMode.ReadOnly);
        //((DropDownList)DetailsMerchantSetup.FindControl("ddlTransType")).SelectedValue = GridView1.SelectedRow.Cells[2].Text.ToString();
        //((TextBox)DetailsMerchantSetup.FindControl("txtMerchantName")).Text = GridView1.SelectedRow.Cells[2].Text.ToString();
        //((TextBox)DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo")).Text = GridView1.SelectedRow.Cells[3].Text.ToString();
        //((TextBox)DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo")).Text = GridView1.SelectedRow.Cells[4].Text.ToString();
        //((TextBox)DetailsMerchantSetup.FindControl("txtOnUsCommissionPercent")).Text = GridView1.SelectedRow.Cells[5].Text.ToString();
        //((TextBox)DetailsMerchantSetup.FindControl("txtOfUsCommissionPercent")).Text = GridView1.SelectedRow.Cells[6].Text.ToString();

        hidMerchantID.Value = GridView1.SelectedRow.Cells[1].Text.ToString();
        // DetailsPartySetup.DefaultMode = DetailsViewMode.ReadOnly;
        GridView1.SelectedIndex = -1;
    }
    protected void cmdValidateOrginalAccount_Click(object sender, EventArgs e)
    {
        if (((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Text.Trim().ToString() == ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Text.Trim().ToString())
            TrustControl1.ClientMsg("Merchant Orginal and Shadow Accout are Same");
        else
        {

            string AccNo = ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Text.Trim();
            //modal.Show();
            if (String.IsNullOrEmpty(AccNo))
                TrustControl1.ClientMsg("Please Enter A/C Number.");
            else
            {
                string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
                SqlConnection oConn = new SqlConnection(oConnString);
                if (oConn.State == ConnectionState.Closed) oConn.Open();

                SqlCommand oCommand = new SqlCommand("s_Flora_Acc_Validate", oConn);
                oCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter sql_Account = new SqlParameter("Account", SqlDbType.VarChar, 20);
                sql_Account.Value = AccNo;

                SqlParameter sql_Done = new SqlParameter("@Done", SqlDbType.Bit);
                sql_Done.Direction = ParameterDirection.Output;

                oCommand.Parameters.Add(sql_Account);
                oCommand.Parameters.Add(sql_Done);


                SqlDataReader oReader = oCommand.ExecuteReader();
                string Done = string.Format("{0}", sql_Done.Value);

                if (Done == "False")
                    TrustControl1.ClientMsg("Account Not Valid");
                else
                {
                    ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Enabled = false;
                    ((Button)(DetailsMerchantSetup.FindControl("cmdValidateOrginalAccount"))).Enabled = false;

                    if (DetailsMerchantSetup.CurrentMode == DetailsViewMode.Insert && ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Enabled == false)
                    {
                        ((Button)(DetailsMerchantSetup.FindControl("cmdInsert"))).Enabled = true;
                    }
                    if (DetailsMerchantSetup.CurrentMode == DetailsViewMode.Edit && ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Enabled == false)
                        ((Button)(DetailsMerchantSetup.FindControl("cmdUpdate"))).Enabled = true;
                }
            }
        }
    }
    protected void cmdValidateShadowAccount_Click(object sender, EventArgs e)
    {
        if (((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Text.Trim().ToString() == ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Text.Trim().ToString())
            TrustControl1.ClientMsg("Merchant Orginal and Shadow Accout are Same");
        else
        {
            string AccNo = ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Text.Trim();
            //modal.Show();
            if (String.IsNullOrEmpty(AccNo))
                TrustControl1.ClientMsg("Please Enter A/C Number.");
            else
            {
                string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
                SqlConnection oConn = new SqlConnection(oConnString);
                if (oConn.State == ConnectionState.Closed) oConn.Open();

                SqlCommand oCommand = new SqlCommand("s_Flora_Acc_Validate", oConn);
                oCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter sql_Account = new SqlParameter("Account", SqlDbType.VarChar, 20);
                sql_Account.Value = AccNo;

                SqlParameter sql_Done = new SqlParameter("@Done", SqlDbType.Bit);
                sql_Done.Direction = ParameterDirection.Output;

                oCommand.Parameters.Add(sql_Account);
                oCommand.Parameters.Add(sql_Done);


                SqlDataReader oReader = oCommand.ExecuteReader();
                string Done = string.Format("{0}", sql_Done.Value);

                if (Done == "False")
                    TrustControl1.ClientMsg("Account Not Valid");
                else
                {
                    ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantShadowAccNo"))).Enabled = false;
                    ((Button)(DetailsMerchantSetup.FindControl("cmdValidateShadowAccount"))).Enabled = false;

                    if ((DetailsMerchantSetup.CurrentMode == DetailsViewMode.Insert) && ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Enabled == false)
                    {
                        ((Button)(DetailsMerchantSetup.FindControl("cmdInsert"))).Enabled = true;
                    }
                    if (DetailsMerchantSetup.CurrentMode == DetailsViewMode.Edit && ((TextBox)(DetailsMerchantSetup.FindControl("txtMerchantOrginalAccNo"))).Enabled == false)
                        ((Button)(DetailsMerchantSetup.FindControl("cmdUpdate"))).Enabled = true;
                }
            }
        }
    }
}