using System;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;


public partial class SMS_Inbox : System.Web.UI.Page
{
    int ApplicationID;

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (!TrustControl1.isRole("ADMIN"))
        {
            if (Session["DEPTID"].ToString() != "7")    //Not IT & Cards
            {
                Response.Write("No Permission.<br><br><a href=''>Home</a>");
                Response.End();
            }
        }
        ApplicationID = int.Parse(System.Configuration.ConfigurationManager.AppSettings["ApplicationID"].ToString().Trim());

        Title = "SMS Inbox";
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {        
        if (e.CommandName == "ACTION")
        {            
            string[] s = Regex.Split(e.CommandArgument.ToString(), "###");
            try
            {
                string CardNo = "";
                try
                {
                    CardNo = (s[2].Split(' '))[1];
                }
                catch (Exception)
                {
                }

                if (e.CommandArgument.ToString().StartsWith("activated"))
                {
                    ModalTitle.Text = string.Format("Reply SMS ({0} # {1})", s[0], s[1]);
                    hidTyle.Value = s[0];
                    hidID.Value = s[1];
                    txtSMS.Text = string.Format("Trust Bank: Your Debit Card No. {0} is now activated. Thank you.", CardNo);
                    txtSMS.Visible = true;
                    cmdSend.Text = "Send";
                    lblSMSCount.Text = (160 - txtSMS.Text.Length).ToString();
                    modal.Show();
                }
                if (e.CommandArgument.ToString().StartsWith("invalid"))
                {
                    ModalTitle.Text = string.Format("Reply SMS ({0} # {1})", s[0], s[1]);
                    hidTyle.Value = s[0];
                    hidID.Value = s[1];
                    txtSMS.Text = string.Format("Trust Bank: Please provide correct information to activate your card. Thank you.");
                    txtSMS.Visible = true;
                    cmdSend.Text = "Send";
                    lblSMSCount.Text = (160 - txtSMS.Text.Length).ToString();
                    modal.Show();
                }
                if (e.CommandArgument.ToString().StartsWith("wrong"))
                {
                    ModalTitle.Text = string.Format("Reply SMS ({0} # {1})", s[0], s[1]);
                    hidTyle.Value = s[0];
                    hidID.Value = s[1];
                    txtSMS.Text = string.Format("");
                    txtSMS.Visible = false;
                    cmdSend.Text = "Reject";
                    lblSMSCount.Text = (160 - txtSMS.Text.Length).ToString();
                    modal.Show();
                }
            }
            catch (Exception ex)
            {
                TrustControl1.ClientMsg("Error: " + ex.Message);
            }
        }
    }

    protected void SqlDataSource1_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {

        GridView1.Columns[7].Visible = (cboStatus.SelectedValue == "NEW");
        lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }

    protected void cmdSend_Click(object sender, EventArgs e)
    {
        //TrustControl1.ClientMsg(hidID.Value.ToString());
        //TrustControl1.ClientMsg(hidTyle.Value.ToString());
        try
        {
            //string ApplicationID = System.Configuration.ConfigurationManager.AppSettings["ApplicationID"].ToString();

            //SqlDataSourceSMS_Out.SelectParameters["Msg"].DefaultValue = txtSMS.Text;
            SqlDataSourceSMS_Out.Select(System.Web.UI.DataSourceSelectArguments.Empty);
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            TrustControl1.ClientMsg(ex.Message);
        }      
    }

    protected void cboStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void SqlDataSourceSMS_Out_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {        
        
    }
}