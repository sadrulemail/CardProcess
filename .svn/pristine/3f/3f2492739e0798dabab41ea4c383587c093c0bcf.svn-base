using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Goto_Reissue_Request : System.Web.UI.Page
{
    

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

       
    }


    protected void cmdOK_Click(object sender, EventArgs e)
    {
        Response.Redirect("New_Reissue_Request.aspx?id="+txtFilter.Text);

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
}
    
   
