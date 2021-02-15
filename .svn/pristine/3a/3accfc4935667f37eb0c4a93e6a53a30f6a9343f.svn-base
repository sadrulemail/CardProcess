using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string ToItclPhone(string PhoneNumber)
    {
        try
        {
            string RetVal = PhoneNumber.Trim();
            if (RetVal.Length > 0)
                RetVal = RetVal.Substring(0, 3) + "(" + RetVal.Substring(3, 5) + ")" + RetVal.Substring(8);
            return RetVal;
        }
        catch (Exception)
        { return ""; }
    }
}