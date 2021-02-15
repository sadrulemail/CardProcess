using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Email_Add_Edit : System.Web.UI.Page
{
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
    }
}
