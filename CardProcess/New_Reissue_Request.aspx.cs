﻿using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class New_Reissue_Request : System.Web.UI.Page
{
    string ReqID = "";
    string CardType = "";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        //TrustControl1.ClientMsg(Request.QueryString["id"]);
        if (!IsPostBack)
        {
            txtFilter.Focus();
            ReqID = string.Format("{0}", Request.QueryString["id"]);

            if (ReqID.Length == 0)
            {
                masterdiv.Visible = false;
                panel3.Visible = false;                
                Title = "Card Service Request";
                GridView1.Visible = false;
            }
            else
            {
                Title = string.Format("#{0} - Service Request", ReqID);
                hidReqID.Value = ReqID;
                DetailsViewMaster.DefaultMode = DetailsViewMode.ReadOnly;
                GridView1.Visible = false;
                Panel1.Visible = true;
                panel3.Visible = true;
                DetailsView_CardReissue.Visible = true;
                //DetailsView_CardReissue.ChangeMode(DetailsViewMode.Insert);
            }
        }
     
    }
    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)        
    {
        try
        {
            masterdiv.Visible = true;
            ((Label)DetailsViewMaster.FindControl("lblCardNumber")).Text = ((Label)(GridView1.SelectedRow.Cells[2].FindControl("lblCardNumber"))).Text.Replace(" & nbsp;", "").Trim();
            ((Label)DetailsViewMaster.FindControl("lblAccount")).Text = GridView1.SelectedRow.Cells[1].Text.ToString().Replace("&nbsp;", "").Trim();
            ((TextBox)DetailsViewMaster.FindControl("txtNameOnCard")).Text = GridView1.SelectedRow.Cells[3].Text.ToString().Replace("&nbsp;", "").Trim();
            ((Label)DetailsViewMaster.FindControl("lblITCLID")).Text = GridView1.SelectedRow.Cells[10].Text.ToString().Replace("&nbsp;", "").Trim();
            ((TextBox)DetailsViewMaster.FindControl("txtDOB")).Text = GridView1.SelectedRow.Cells[7].Text.ToString().Replace("&nbsp;", "").Trim();
        }
        catch(Exception ex)
        {
            TrustControl1.ClientMsg(ex.Message);
        }
    }
    protected void DetailsViewMaster_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        //panel3.Visible = true;
    }
    protected void SqlDataSourceMaster_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        ReqID = string.Format("{0}", e.Command.Parameters["@ReqID"].Value);
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);
        if (ReqID == "-1")
        {
            TrustControl1.ClientMsg(msg);
        }
        else
        {
            TrustControl1.ClientMsg(msg);
            Response.Redirect("New_Reissue_Request.aspx?id=" + ReqID, true);
        }
       
    }

    protected void SqlDataSourceMaster_OnDeleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);
        TrustControl1.ClientMsg(msg);
        Panel1.Visible = true;
    }

    protected void SqlDataSourceMaster_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        //hidReqID.Value = string.Format("{0}", e.Command.Parameters["@ReqID"].Value);
        DetailsViewMaster.ChangeMode(DetailsViewMode.ReadOnly);
        DetailsViewMaster.DefaultMode = DetailsViewMode.ReadOnly;
        GridView1.Visible = false;
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);
        TrustControl1.ClientMsg(msg);
    }
    protected void cmdOK_Click(object sender, EventArgs e)
    {

        GridView1.DataBind();
        GridView1.Visible = true;
        //masterdiv.Visible = false;
    }
    protected void CmdNew_Click(object sender, EventArgs e)
    {

        Response.Redirect("New_Reissue_Request.aspx",false);
    }
    protected void SqlDataSource_CardReissue_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {

        string msg = e.Command.Parameters["@msg"].Value.ToString();
        string Done = e.Command.Parameters["@Done"].Value.ToString();
        if (Done == "False")
        {
            TrustControl1.ClientMsg(msg);
        }
        else
        {
            TrustControl1.ClientMsg("Insert Successfully.");
        }
        //DetailsView_CardReissue.DefaultMode = DetailsViewMode.ReadOnly;
        //DetailsView_CardReissue.ChangeMode(DetailsViewMode.ReadOnly);
        //chkCardReissue.Enabled = false;
    }
    protected void SqlDataSource_CardReissue_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        //TrustControl1.ClientMsg("Update Successfully.");
        //DetailsView_CardReissue.ChangeMode(DetailsViewMode.ReadOnly);
        string msg = e.Command.Parameters["@msg"].Value.ToString();
        TrustControl1.ClientMsg(msg);
        //chkCardReissue.Enabled = false;
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        GridView1.SelectedIndex = -1;
    }
    protected void SqlDataSource_CardReissue_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {

        if (e.AffectedRows > 0)
        {
            //DetailsView_CardReissue.ChangeMode(DetailsViewMode.ReadOnly);
            ((Button)DetailsViewMaster.FindControl("cmdDelete")).Enabled = false;

        }
        else
            DetailsView_CardReissue.ChangeMode(DetailsViewMode.Insert);
    }
    protected void SqlDataSource_CardReissue_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string msg = e.Command.Parameters["@Msg"].Value.ToString();

        TrustControl1.ClientMsg(msg);
        DetailsViewMaster.DataBind();
      
    }
    protected void DetailsViewMaster_DataBound(object sender, EventArgs e)
    {
       
        try
        {
           

            CardType = DataBinder.Eval(DetailsViewMaster.DataItem, "CardTypeCode").ToString();
            string AccNo = DataBinder.Eval(DetailsViewMaster.DataItem, "Account").ToString();
            string AccTypes = AccNo.Substring(5, 4).ToString();
            AcTypes.Value = AccTypes.ToString();

            //if (TrustControl1.isRole("GUEST"))
            //{
            //    ((Button)DetailsViewMaster.FindControl("cmdEdit")).Enabled = false;
            //    ((Button)DetailsViewMaster.FindControl("cmdDelete")).Enabled = false;
            //    ((Button)DetailsViewMaster.FindControl("cmdInsert")).Enabled = false;
            //}
            //else
            //{
            //    ((Button)DetailsViewMaster.FindControl("cmdEdit")).Enabled = true;
            //    ((Button)DetailsViewMaster.FindControl("cmdDelete")).Enabled = true;
            //    ((Button)DetailsViewMaster.FindControl("cmdInsert")).Enabled = true;
            //}
        }
        catch (Exception) { }
    }
    protected void SqlDataSourceMaster_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //string msg = e.Command.Parameters["@msg"].Value.ToString();
        //TrustControl1.ClientMsg(msg);
        if (e.AffectedRows > 0)
        {
           

        }
    }
    protected void cboServiceType_SelectedIndexChanged(object sender, EventArgs e)
    {
        string val = ((DropDownList)DetailsView_CardReissue.FindControl("cboServiceType")).SelectedItem.Value;
        //TrustControl1.ClientMsg(val);
        if (val == "2")    //PIN Reissue
        {
            ((DropDownList)DetailsView_CardReissue.FindControl("cboCardType")).Enabled = false;
            ((DropDownList)DetailsView_CardReissue.FindControl("cboCardType")).SelectedIndex = 0;
        }
        else if (val == "1")    //Card Reissue
        {
            ((DropDownList)DetailsView_CardReissue.FindControl("cboCardType")).Enabled = true;
        }
    }
    protected void cboCardType_DataBound(object sender, EventArgs e)
    {
        string val = ((DropDownList)DetailsView_CardReissue.FindControl("cboServiceType")).SelectedItem.Value;
        if (val == "2")    //PIN Reissue
        {
            ((DropDownList)DetailsView_CardReissue.FindControl("cboCardType")).Enabled = false;
            ((DropDownList)DetailsView_CardReissue.FindControl("cboCardType")).SelectedIndex = 0;
        }
    }
    protected void cboCardType_DataBound1(object sender, EventArgs e)
    {
        try
        {
            foreach (ListItem LI in ((DropDownList)(DetailsView_CardReissue.FindControl("cboCardType"))).Items)
                LI.Selected = false;

            foreach (ListItem LI in ((DropDownList)(DetailsView_CardReissue.FindControl("cboCardType"))).Items)
                if (LI.Value == CardType)
                    LI.Selected = true;
        }
        catch (Exception) { }
    }

    protected void DetailsView_CardReissue_DataBound(object sender, EventArgs e)
    {
        
        try
        {
            
           

            string ServiceDesc = DataBinder.Eval(DetailsView_CardReissue.DataItem, "ServiceDesc").ToString();
            if (ServiceDesc == "PIN Reissue")
                ((Label)(DetailsView_CardReissue.FindControl("lblCardType"))).Visible = false;
            else
            {
                ((Label)(DetailsView_CardReissue.FindControl("lblCardType"))).Visible = true;
            }

            if (TrustControl1.isRole("GUEST"))
            {
                if (DetailsView_CardReissue.CurrentMode == DetailsViewMode.Insert)
                {
                    ((Button)DetailsView_CardReissue.FindControl("cmdInsert")).Enabled = false;
                }
                else if(DetailsView_CardReissue.CurrentMode == DetailsViewMode.ReadOnly)
                    ((Button)DetailsView_CardReissue.FindControl("cmdDelete")).Enabled = false;
                
            }
            //else
            //{
            //    ((Button)DetailsView_CardReissue.FindControl("cmdDelete")).Enabled = true;
            //    ((Button)DetailsView_CardReissue.FindControl("cmdInsert")).Enabled = true;

            //}
        }
        catch (Exception exxx) { }
    }

    protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //if (e.AffectedRows > 0)
        //    divPending.Visible = true;
        //else
        //    divPending.Visible = false;
    }
}