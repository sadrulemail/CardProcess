using System;
using System.IO;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public partial class POS_Upload_Log : System.Web.UI.Page
{

 


    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.Attributes.Add("enctype", "multipart/form-data");
        if (TrustControl1.getUserRoles() != "ADMIN")
        {
            if (Session["DEPTID"].ToString() != "7")    //Not IT & Cards
            {
                Response.Write("No Permission.<br><br><a href=''>Home</a>");
                Response.End();
            }
        }
        if (!Directory.Exists(Server.MapPath("Upload")))
        {
            Directory.CreateDirectory(Server.MapPath("Upload"));
        }
        

       
        }

    protected void GridView2_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "CalculateCommission") return;
        int batch = Convert.ToInt32(e.CommandArgument);

        TrustControl1.ClientMsg(batch.ToString());
      
    }
        
    }
  

