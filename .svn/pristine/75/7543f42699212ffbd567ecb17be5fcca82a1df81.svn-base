using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class PartySetup : System.Web.UI.Page
{
    string PartyID = "";
    bool isValidAcc = false;

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



    protected void SqlDataSourcePartySetup_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        PartyID = string.Format("{0}", e.Command.Parameters["@PartyID"].Value);
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);

        if (PartyID == "-1")
        {
            TrustControl1.ClientMsg(msg);
        }
        else
        {
            TrustControl1.ClientMsg(msg);
            //Response.Redirect("New_Reissue_Request.aspx?id=" + ReqID, true);
        }
        GridView1.DataBind();
        hidPartyID.Value = PartyID;
        //DetailsMerchantSetup.Visible = true;
        DetailsPartySetup.ChangeMode(DetailsViewMode.ReadOnly);
        //DetailsPartySetup.DefaultMode = DetailsViewMode.ReadOnly;
    }
    protected void SqlDataSourcePartySetup_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        DetailsPartySetup.ChangeMode(DetailsViewMode.ReadOnly);
        DetailsPartySetup.DefaultMode = DetailsViewMode.ReadOnly;
        //GridView1.Visible = false;
        PartyID = string.Format("{0}", e.Command.Parameters["@PartyID"].Value);
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);
        if (PartyID == "-1")
        {
            TrustControl1.ClientMsg(msg);
        }
        else
        {
            TrustControl1.ClientMsg(msg);
            //Response.Redirect("New_Reissue_Request.aspx?id=" + ReqID, true);
        }
        GridView1.DataBind();
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DetailsPartySetup.Visible = true;
        DetailsPartySetup.ChangeMode(DetailsViewMode.ReadOnly);
        //((TextBox)DetailsPartySetup.FindControl("txtPartyName")).Text = GridView1.SelectedRow.Cells[3].Text.ToString();
        //((TextBox)DetailsPartySetup.FindControl("txtCommissionPercent")).Text = GridView1.SelectedRow.Cells[4].Text.ToString();
        //((TextBox)DetailsPartySetup.FindControl("txtAccountNo")).Text = GridView1.SelectedRow.Cells[5].Text.ToString();
        //((DropDownList)DetailsPartySetup.FindControl("ddlTransType")).SelectedValue = GridView1.SelectedRow.Cells[6].Text.ToString();

        //((TextBox)DetailsPartySetup.FindControl("ctl00$ContentPlaceHolder2$DetailsPartySetup$txtPartyName")).Text = GridView1.SelectedRow.Cells[3].Text.ToString();
        //((TextBox)DetailsPartySetup.FindControl("ctl00$ContentPlaceHolder2$DetailsPartySetup$txtCommissionPercent")).Text = GridView1.SelectedRow.Cells[4].Text.ToString();
        //((TextBox)DetailsPartySetup.FindControl("ctl00$ContentPlaceHolder2$DetailsPartySetup$txtAccountNo")).Text = GridView1.SelectedRow.Cells[5].Text.ToString();
        //((DropDownList)DetailsPartySetup.FindControl("ctl00$ContentPlaceHolder2$DetailsPartySetup$ddlTransType")).SelectedValue = GridView1.SelectedRow.Cells[6].Text.ToString();

        hidPartyID.Value = GridView1.SelectedRow.Cells[2].Text.ToString();
        // DetailsPartySetup.DefaultMode = DetailsViewMode.ReadOnly;
        //GridView1.DataBind();
        GridView1.SelectedIndex = -1;
    }
    protected void cmdValidateAccount_Click(object sender, EventArgs e)
    {
        string AccNo = ((TextBox)(DetailsPartySetup.FindControl("txtAccountNo"))).Text.Trim();
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
                 ((TextBox)(DetailsPartySetup.FindControl("txtAccountNo"))).Enabled = false;
                 ((Button)(DetailsPartySetup.FindControl("cmdValidateAccount"))).Enabled = false;

                 if (DetailsPartySetup.CurrentMode == DetailsViewMode.Insert)
                 {
                     ((Button)(DetailsPartySetup.FindControl("cmdInsert"))).Enabled = true;
                 }
                 if (DetailsPartySetup.CurrentMode == DetailsViewMode.Edit)
                    ((Button)(DetailsPartySetup.FindControl("cmdUpdate"))).Enabled = true;
             }
         }

    }
    protected void SqlDataSourcePartySetup_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //((Button)(DetailsPartySetup.FindControl("cmdInsert"))).Enabled=false;
    }
}