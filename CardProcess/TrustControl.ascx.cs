﻿using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



/// <summary>
/// Ashik's control for session and role retrival purpose
/// </summary>
public partial class TrustControl : System.Web.UI.UserControl
{
    string UrlPrefix = "";
    //ScriptManager TrustScriptManager;

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection.ClearAllPools();
        //HitCounterUp();
        //TrustScriptManager = new ScriptManager();
        //TrustScriptManager.
        //this.Page.Controls.Add(TrustScriptManager);
    }
    public string FileSize(object val)
    {
        float SizeVal = (float.Parse(val.ToString()));
        string size = "Unknown Size";
        if (SizeVal > 0)
        {
            if (SizeVal >= 1073741824)
                size = String.Format("{0:##.###}", (SizeVal / 1073741824)) + " GB";
            else if (SizeVal >= 1048576)
                size = String.Format("{0:##.##}", (SizeVal / 1048576)) + " MB";
            else if (SizeVal >= 1024)
                size = String.Format("{0:##.##}", (SizeVal / 1024)) + " KB";
            else
                size = String.Format("{0:##}", (SizeVal)) + " Bytes";
        }
        return size;
    }

    public string getAge(object DOB)
    {
        return getAge(DOB, DateTime.Now.Date);
    }

    public string getAge(object FromDate, object ToDate)
    {
        if (ToDate.ToString() == "") return "Till Now";

        try
        {
            //DateTime dateOfBirth = (DateTime)FromDate;
            //DateTime currentDate = (DateTime)ToDate;

            int ageInYears = 0;
            int ageInMonths = 0;
            int ageInDays = 0;
            string dayText = "day";
            string monthText = "month";
            string yearText = "year";

            DateTime Bday = (DateTime)FromDate;
            DateTime Cday = (DateTime)ToDate;

            if ((Cday.Year - Bday.Year) > 0 ||
                (((Cday.Year - Bday.Year) == 0) && ((Bday.Month < Cday.Month) ||
                ((Bday.Month == Cday.Month) && (Bday.Day <= Cday.Day)))))
            {
                int DaysInBdayMonth = DateTime.DaysInMonth(Bday.Year, Bday.Month);
                int DaysRemain = Cday.Day + (DaysInBdayMonth - Bday.Day);

                if (Cday.Month > Bday.Month)
                {
                    ageInYears = Cday.Year - Bday.Year;
                    ageInMonths = Cday.Month - (Bday.Month + 1) + Math.Abs(DaysRemain / DaysInBdayMonth);
                    ageInDays = (DaysRemain % DaysInBdayMonth + DaysInBdayMonth) % DaysInBdayMonth;
                }
                else if (Cday.Month == Bday.Month)
                {
                    if (Cday.Day >= Bday.Day)
                    {
                        ageInYears = Cday.Year - Bday.Year;
                        ageInMonths = 0;
                        ageInDays = Cday.Day - Bday.Day;
                    }
                    else
                    {
                        ageInYears = (Cday.Year - 1) - Bday.Year;
                        ageInMonths = 11;
                        ageInDays = DateTime.DaysInMonth(Bday.Year, Bday.Month) - (Bday.Day - Cday.Day);
                    }
                }
                else
                {
                    ageInYears = (Cday.Year - 1) - Bday.Year;
                    ageInMonths = Cday.Month + (11 - Bday.Month) + Math.Abs(DaysRemain / DaysInBdayMonth);
                    ageInDays = (DaysRemain % DaysInBdayMonth + DaysInBdayMonth) % DaysInBdayMonth;
                }
            }

            if (ageInYears == 0) yearText = "";
            else if (ageInYears == 1) yearText = ", " + ageInYears + " year";
            else yearText = ", " + ageInYears + " years";

            if (ageInMonths == 0) monthText = "";
            else if (ageInMonths == 1) monthText = ", " + ageInMonths + " month";
            else monthText = ", " + ageInMonths + " months";

            if (ageInDays == 0) dayText = "";
            else if (ageInDays == 1) dayText = ", " + ageInDays + " day";
            else dayText = ", " + ageInDays + " days";


            string Retval = string.Format("{0}{1}{2}", yearText, monthText, dayText);
            if (Retval.StartsWith(", ")) Retval = Retval.Substring(2);
            if (Retval.StartsWith(", ")) Retval = Retval.Substring(2);
            if (Retval.StartsWith(", ")) Retval = Retval.Substring(2);

            return Retval;
        }
        catch (Exception)
        { return ""; }
    }
    public bool LoadEmpToSession(bool MenuCheck)
    {
        if (Session.IsNewSession || Session["EMPID"] == null)
        {
            Response.Redirect(UrlPrefix + "Login.aspx?Prev=" + Request.Url.ToString(), true);
        }


        try
        {
            AppSettingsReader oAppRead = new AppSettingsReader();
            string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["TblUserDBConnectionString"].ConnectionString;

            SqlConnection oConn = new SqlConnection(oConnString);
            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            SqlCommand oCommand = new SqlCommand("usp_getEmpInfo", oConn);
            oCommand.CommandType = CommandType.StoredProcedure;
            oCommand.Parameters.Add("@param_EmpID", SqlDbType.VarChar).Value = Session["EMPID"];

            if (oConn.State == ConnectionState.Closed)
                oConn.Open();

            SqlDataReader oReader = oCommand.ExecuteReader();

            string Role = string.Empty;
            while (oReader.Read())
            {
                //Session["BRANCHID"] = (int)oReader["Branch_BranchID"];
                //Session["BRANCHNAME"] = oReader["BRANCHNAME"].ToString();
                //Session["DEPTID"] = (int)oReader["Department_DeptID"];
                //Session["DESIGID"] = (int)oReader["Designation_DesigID"];
                //Session["DESIGNATION"] = oReader["DesigFullName"].ToString();
                //Session["EMPNAME"] = oReader["EmpName"].ToString();
                //Session["BranchPrefix"] = oReader["BranchPrefix"].ToString();

                if ((string.Format("{0}", Session["BRANCHID"])) != string.Format("{0}", oReader["Branch_BranchID"]))
                    Session["BRANCHID"] = (int)oReader["Branch_BranchID"];

                if (string.Format("{0}", Session["BRANCHNAME"]) != string.Format("{0}", oReader["BRANCHNAME"]))
                    Session["BRANCHNAME"] = oReader["BRANCHNAME"].ToString();

                if (string.Format("{0}", Session["DEPTID"]) != string.Format("{0}", oReader["Department_DeptID"]))
                    Session["DEPTID"] = (int)oReader["Department_DeptID"];

                if (string.Format("{0}", Session["DESIGID"]) != string.Format("{0}", oReader["Designation_DesigID"]))
                    Session["DESIGID"] = (int)oReader["Designation_DesigID"];

                if (string.Format("{0}", Session["DESIGNATION"]) != string.Format("{0}", oReader["DesigFullName"]))
                    Session["DESIGNATION"] = oReader["DesigFullName"].ToString();

                if (string.Format("{0}", Session["EMPNAME"]) != string.Format("{0}", oReader["EmpName"]))
                    Session["EMPNAME"] = oReader["EmpName"].ToString();

                if (string.Format("{0}", Session["BranchPrefix"]) != string.Format("{0}", oReader["BranchPrefix"]))
                    Session["BranchPrefix"] = oReader["BranchPrefix"].ToString();

                try
                {
                    ((Label)this.Page.Master.FindControl("BranchName")).Text = oReader["BranchName"].ToString();
                }
                catch (Exception) { }

                try
                {
                    ((Label)this.Page.Master.FindControl("EmpName")).Text = oReader["EmpName"].ToString();
                }
                catch (Exception) { }
            }
            oConn.Close();
            try
            {
                this.Page.Master.FindControl("LoginMenu").Visible = true;
            }
            catch (Exception) { }


            //Check Roles
            CheckMenuPermision(MenuCheck);

            return true;
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + "<br /><br />");
            Response.Write("<a href=\"" + UrlPrefix + "Login.aspx?Prev=" + Request.Url.ToString() + "\">Try Again</a>");
        }
        return false;
    }

    public string getUserRoles()
    {
        return getUserRoles(true);
    }

    public string getUserRoles(bool MenuCheck)
    {
        int ApplicationID = -1;
        try
        {
            ApplicationID = int.Parse(System.Configuration.ConfigurationManager.AppSettings["ApplicationID"].ToString().Trim());
        }
        catch (Exception)
        {
            return string.Empty;
        }
        return getUserRoles(ApplicationID, MenuCheck);
    }
    public string getUserRoles(int ApplicationID, bool MenuCheck)
    {
        Page.Culture = "en-NZ";
        //Page.Culture = "en-BD";

        UrlPrefix = Request.Url.OriginalString.Replace(Request.Url.PathAndQuery, "");
        UrlPrefix += "/" + (Request.Url.Segments[1].Contains(".") ? "" : Request.Url.Segments[1]);

        if (Session.IsNewSession || Session["EMPID"] == null)
        {
            Response.Redirect(UrlPrefix + "Login.aspx?Prev=" + Request.Url.ToString(), true);
        }

        //Should be removed while online
        //Session["EMPID"] = 1;
        //Response.Write(Session["EMPID"].ToString());

        int _AppID = ApplicationID;

        try
        {
            AppSettingsReader oAppRead = new AppSettingsReader();
            string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["TblUserDBConnectionString"].ConnectionString;

            SqlConnection oConn = new SqlConnection(oConnString);
            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            SqlCommand oCommand = new SqlCommand("usp_getRoles", oConn);
            oCommand.CommandType = CommandType.StoredProcedure;
            oCommand.Parameters.Add("@EmpID", SqlDbType.VarChar).Value = Session["EMPID"];
            oCommand.Parameters.Add("@AppID", SqlDbType.Int).Value = _AppID;
            oCommand.Parameters.Add("@PageURL", SqlDbType.VarChar).Value = Request.Url.Segments[Request.Url.Segments.Length - 1];
            oCommand.Parameters.Add("@Query", SqlDbType.VarChar).Value = Request.Url.Query;
            oCommand.Parameters.Add("@IP", SqlDbType.VarChar).Value = getIP_Address();


            if (oConn.State == ConnectionState.Closed)
                oConn.Open();

            SqlDataReader oReader = oCommand.ExecuteReader();
            if (!oReader.HasRows)
            {
                Response.Write("<h1>You have no permission to use this application.</h1><a href='../'>Back</a>");
                Response.End();
            }
            string Role = string.Empty;
            while (oReader.Read())
            {
                //Session["BRANCHID"] = (int)oReader["BRANCHID"];
                //Session["BRANCHNAME"] = oReader["BRANCHNAME"].ToString();
                //Session["DEPTID"] = (int)oReader["DEPTID"];
                //Session["DESIGID"] = (int)oReader["DESIGID"];
                //Session["ROLES"] = oReader["ROLES"];
                //Session["BranchPrefix"] = oReader["BranchPrefix"].ToString();

                if ((string.Format("{0}", Session["BRANCHID"])) != string.Format("{0}", oReader["BRANCHID"]))
                    Session["BRANCHID"] = (int)oReader["BRANCHID"];

                if (string.Format("{0}", Session["BRANCHNAME"]) != string.Format("{0}", oReader["BRANCHNAME"]))
                    Session["BRANCHNAME"] = oReader["BRANCHNAME"].ToString();

                if (string.Format("{0}", Session["DEPTID"]) != string.Format("{0}", oReader["DEPTID"]))
                    Session["DEPTID"] = (int)oReader["DEPTID"];

                if (string.Format("{0}", Session["DESIGID"]) != string.Format("{0}", oReader["DEPTID"]))
                    Session["DESIGID"] = (int)oReader["DEPTID"];

                if (string.Format("{0}", Session["DESIGNATION"]) != string.Format("{0}", oReader["DesigFullName"]))
                    Session["DESIGNATION"] = oReader["DesigFullName"].ToString();

                if (string.Format("{0}", Session["EMPNAME"]) != string.Format("{0}", oReader["EmpName"]))
                    Session["EMPNAME"] = oReader["EmpName"].ToString();

                if (string.Format("{0}", Session["ROLES"]) != string.Format("{0}", oReader["ROLES"]))
                    Session["ROLES"] = oReader["ROLES"];

                if (string.Format("{0}", Session["BranchPrefix"]) != string.Format("{0}", oReader["BranchPrefix"]))
                    Session["BranchPrefix"] = oReader["BranchPrefix"].ToString();

                Role = oReader["Roles"].ToString();


                try
                {
                    ((Label)this.Page.Master.FindControl("lblRole")).Text = Role;
                }
                catch (Exception) { }

                try
                {
                    ((Label)this.Page.Master.FindControl("BranchName")).Text = oReader["BRANCHNAME"].ToString();
                }
                catch (Exception) { }

                try
                {
                    ((Label)this.Page.Master.FindControl("ServerDate")).Text = oReader["SERVERDATE"].ToString();
                }
                catch (Exception) { }

                try
                {
                    ((Label)this.Page.Master.FindControl("EmpName")).Text = oReader["EMPNAME"].ToString();
                }
                catch (Exception) { }
                try
                {
                    ((Label)this.Page.Master.FindControl("ApplicationName")).Text = oReader["ApplicationName"].ToString();
                }
                catch (Exception) { }
                try
                {
                    ((Literal)this.Page.Master.FindControl("ApplicationLogo")).Text = string.Format("<a href='Default.aspx'><img src='{0}' height='40' border='0' /></a>", oReader["Logo"]);
                }
                catch (Exception) { }

                //Fource Password Change
                bool ChangeOnNextLogin = false;
                ChangeOnNextLogin = (bool)oReader["ChangeOnNextLogin"];
                if (ChangeOnNextLogin && !Request.Url.ToString().ToLower().Contains("passwordchange"))
                    Response.Redirect("PasswordChange.aspx?Prev=" + Request.Url.ToString(), true);
            }
            oReader.Close();

            /*
            string Query = "SELECT [ObjectID] AS [OID] FROM Roles_Object WHERE PageName = '" + Request.AppRelativeCurrentExecutionFilePath + "' AND [RoleID] = '" + Session["ROLEID"].ToString().Trim() + "' AND [ApplicationID] = '" + _AppID + "'";
            //Response.Write(Query + "<br>");
            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            SqlCommand oComm = new SqlCommand(Query, oConn);            
            oReader = oComm.ExecuteReader();

            //Response.Write(Query + "<br>");
            while (oReader.Read())
            {                
                Response.Write("<br>(" + oReader["OID"].ToString() + ")<br>");             
                try
                {
                    PermitControl(this.Page, oReader["OID"].ToString().Trim());
                }
                catch (Exception ex)
                {
                    //Response.Write(ex.Message); 
                }
            }           
            */

            oConn.Close();
            try
            {
                this.Page.Master.FindControl("LoginMenu").Visible = true;
            }
            catch (Exception) { }


            //Check Roles

            CheckMenuPermision(MenuCheck);

            return Role;
        }
        catch (Exception)
        {
            //Response.Write(ex.Message + "<br /><br />");            
            //Response.Write("<a href=\"" + UrlPrefix + "Login.aspx?Prev=" + Request.Url.ToString() + "\">Try Again1</a>");            
        }
        return string.Empty;
    }
    private void CheckMenuPermision(bool MenuCheck)
    {
        bool isRoleAssigned = false;
        bool isBranchAssigned = false;

        if (MenuCheck)
        {
            string[] Roles = Session["ROLES"].ToString().Split(',');
            SiteMapNode node = SiteMap.CurrentNode;

            //Check Branch
            if (!string.IsNullOrEmpty(node["branch"]))
            {
                string[] branches = node["branch"].ToString().Split(',');
                for (int i = 0; i < branches.Length; i++)
                    if (branches[i] == Session["BRANCHID"].ToString()
                        || branches[i] == "*")
                    {
                        isBranchAssigned = true;
                    }
            }
            else
            {
                isBranchAssigned = true;
            }

            //Check Role
            for (int i = 0; i < SiteMap.CurrentNode.Roles.Count; i++)
                foreach (string R in Roles)
                    if (SiteMap.CurrentNode.Roles[i].ToString().ToLower() == R.ToLower()
                        || SiteMap.CurrentNode.Roles[i].ToString() == "*")
                    {
                        isRoleAssigned = true;
                    }



            if (!isRoleAssigned || !isBranchAssigned)
            {
                Response.Write("<h1>You have no permission to use this page.</h1>");
                Response.End();
            }
        }
    }
    public string getEmpFromDB(string EmpID)
    {
        string RetVal = "";
        try
        {
            AppSettingsReader oAppRead = new AppSettingsReader();
            string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["TblUserDBConnectionString"].ConnectionString;

            SqlConnection oConn = new SqlConnection(oConnString);
            if (oConn.State == ConnectionState.Closed)
                oConn.Open();
            SqlCommand oCommand = new SqlCommand("usp_getEmpInfo", oConn);
            oCommand.CommandType = CommandType.StoredProcedure;
            oCommand.Parameters.Add("@param_EmpID", SqlDbType.VarChar).Value = EmpID;

            if (oConn.State == ConnectionState.Closed)
                oConn.Open();

            SqlDataReader oReader = oCommand.ExecuteReader();

            string Role = string.Empty;
            while (oReader.Read())
            {
                RetVal = oReader["EMP"].ToString();
            }
            oReader.Close();
            return RetVal;
            
        }
        catch (Exception)
        {
            return string.Empty;
        }
    }
    public bool isRole(string RoleName)
    {
        try
        {
            string[] Roles = Session["ROLES"].ToString().Split(',');
            foreach (string Role in Roles)
                if (Role.Trim().ToLower() == RoleName.Trim().ToLower())
                    return true;
            return false;
        }
        catch (Exception)
        {
            return false;
        }
    }
    public bool isRole(params string[] RoleNames)
    {
        try
        {
            foreach (string RoleName in RoleNames)
            {
                if (isRole(RoleName))
                    return true;
            }
            return false;
        }
        catch (Exception)
        {
            return false;
        }
    }
    public void PermitControl(Control Root, string Id)
    {
        FindCtl(Root, Id, Id);        
    }
    public Control FindCtl(Control Root, string Id, string IdToVisible)
    {
        if (Root.ID == IdToVisible)
            return Root;

        foreach (Control Ctl in Root.Controls)
        {
            if (IdToVisible == Id)
            {
                Ctl.Visible = true;
                try
                {
                    ((Button)Ctl).Enabled = true;
                }
                catch (Exception) { }
            }
            Control FoundCtl = FindCtl(Ctl, Id, IdToVisible);            
            if (FoundCtl != null)
                return FoundCtl;
        }
        return null;
    }
    private void HitCounterUp()
    {
        try
        {
            int ApplicationID = int.Parse(System.Configuration.ConfigurationManager.AppSettings["ApplicationID"].ToString().Trim());
            string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["TblUserDBConnectionString"].ConnectionString;
            System.Data.SqlClient.SqlConnection oConn = new System.Data.SqlClient.SqlConnection(oConnString);
            System.Data.SqlClient.SqlCommand oComm = new System.Data.SqlClient.SqlCommand("usp_Hit", oConn);
            oComm.CommandType = System.Data.CommandType.StoredProcedure;

            oComm.Parameters.Add("@AppID", System.Data.SqlDbType.Int).Value = ApplicationID;
            if (oConn.State == System.Data.ConnectionState.Closed)
                oConn.Open();
            oComm.ExecuteNonQuery();
        }
        catch (Exception) { }        
    }
    public void ClientMsg(string MsgTxt)
    {
        ClientMsg(MsgTxt, "");
    }
    public void ClientMsg(string MsgTxt, string TitleTxt)
    {
        ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "clientScript", "jAlert('" + MsgTxt + "', '" + TitleTxt + "')", true);
    }
    public void ClientScript(string ScriptTxt)
    {
        ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "clientScript", ScriptTxt, true);
    }
    public bool isEmailAddress(string emailAddress)
    {
        //string patternLenient = @"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*";
        //Regex reLenient = new Regex(patternLenient);

        string patternStrict = @"^(([^<>()[\]\\.,;:\s@\""]+"
              + @"(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@"
              + @"((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
              + @"\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+"
              + @"[a-zA-Z]{2,}))$";
        Regex reStrict = new Regex(patternStrict);

        //bool isLenientMatch = reLenient.IsMatch(emailAddress);
        //return isLenientMatch;

        bool isStrictMatch = reStrict.IsMatch(emailAddress);
        return isStrictMatch;
    }
    public void ClientScriptStartup(string ScriptTxt)
    {
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "clientScript", ScriptTxt, true);
    }
    public void ClientIDFocus(string ClientID)
    {
        ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "clientScript", "<script>document.getElementById('" + ClientID + "').focus();document.getElementById('" + ClientID + "').select();</script>", true);
    }
    public string getValueOfKey(string KeyName)
    {
        try
        {
            return System.Configuration.ConfigurationSettings.AppSettings[KeyName].ToString();
        }
        catch (Exception) { return string.Empty; }
    }
    public string ToRelativeDate(object input)
    {
        try
        {
            return ToRelativeDate((DateTime)(input));
        }
        catch (Exception) { return string.Empty; }
    }
    public string ToRelativeDate(DateTime input)
    {
        string suffix = "ago";
        TimeSpan difference = (DateTime.Now - input);
        double millisecondsDifference = difference.TotalMilliseconds;

        if ((millisecondsDifference < 0))
        {
            suffix = "from now";
            millisecondsDifference = Math.Abs(millisecondsDifference);
        }

        double seconds = millisecondsDifference / 1000;
        double minutes = seconds / 60;
        double hours = minutes / 60;
        double days = hours / 24;
        double years = days / 365;

        string relativeDate = string.Empty;

        if ((seconds < 45))
        {
            relativeDate = "less than a minute";
        }
        else if ((seconds < 90))
        {
            relativeDate = "about a minute";
        }
        else if ((minutes < 45))
        {
            relativeDate = string.Format(English, "{0} minutes", Math.Round(minutes));
        }
        else if ((minutes < 90))
        {
            relativeDate = "about an hour";
        }
        else if ((hours < 24))
        {
            relativeDate = string.Format(English, "about {0} hours", Math.Round(hours));
        }
        else if ((hours < 48))
        {
            relativeDate = "a day";
        }
        else if ((days < 30))
        {
            relativeDate = string.Format(English, "{0} days", Math.Floor(days));
        }
        else if ((days < 60))
        {
            relativeDate = "about a month";
        }
        else if ((days < 365))
        {
            relativeDate = string.Format(English, "{0} months", Math.Floor(days / 30));
        }
        else if ((years < 2))
        {
            relativeDate = "about a year";
        }
        else
        {
            relativeDate = string.Format(English, "{0} years", Math.Floor(years));
        }
        return relativeDate + " " + suffix;
    }

    public string ToRelativeDay(object input)
    {
        try
        {
            return ToRelativeDay((DateTime)(input));
        }
        catch (Exception) { return string.Empty; }
    }
    public string ToRelativeDay(DateTime input)
    {
        input = input.Date;
        TimeSpan difference = ( input - DateTime.Now.Date);
        double dayDifference = difference.Days;

        string relativeDate = string.Empty;

        if (dayDifference == 0)
            return "Today";
        else if (dayDifference == 1)
            return "Tomorrow";
        else if (dayDifference == -1)
            return "Yesterday";
        else if (dayDifference < -1)
            return Math.Abs(dayDifference).ToString() + " days ago";
        else
            return dayDifference.ToString() + " days later";

        return "";
    }
    public string ToRecentDateTime(object input)
    {
        try
        {
            return ToRecentDateTime((DateTime)(input));
        }
        catch (Exception) { return string.Empty; }
    }

    public string ToRecentDateTime(DateTime input)
    {
        string RetVal = "";

        TimeSpan difference = (DateTime.Now.Date - input.Date);
        double millisecondsDifference = difference.TotalMilliseconds;
        double seconds = millisecondsDifference / 1000;
        double minutes = seconds / 60;
        double hours = minutes / 60;
        double days = hours / 24;
        double years = days / 365;

        if (input.Date == DateTime.Now.Date)
            RetVal = String.Format(English, "{0:h:mm tt}", input);
        else if (days < 2)
            RetVal = "Yesterday, " + String.Format(English, "{0:h:mm tt}", input);
        else if (days < 7)
            RetVal = String.Format(English, "{0:dddd, h:mm tt}", input);
        else if (DateTime.Now.Year == input.Date.Year)
            RetVal = String.Format(English, "{0:d MMM, h:mm tt}", input);
        else
            RetVal = String.Format(English, "{0:d MMM yyyy, h:mm tt}", input);

        return RetVal.Replace(".", "");
    }

    public string ToRecentDate(object input)
    {
        try
        {
            return ToRecentDate((DateTime)(input));
        }
        catch (Exception) { return string.Empty; }
    }

    public string ToRecentDate(DateTime input)
    {
        TimeSpan difference = (DateTime.Now.Date - input.Date);
        double millisecondsDifference = difference.TotalMilliseconds;
        double seconds = millisecondsDifference / 1000;
        double minutes = seconds / 60;
        double hours = minutes / 60;
        double days = hours / 24;
        double years = days / 365;

        string RetVal = "";
        if (input.Date == DateTime.Now.Date)
            RetVal = "Today";
        else if (days < 2)
            RetVal = "Yesterday";
        else if (days < 7)
            RetVal = String.Format(English, "{0:dddd}", input);
        else if (DateTime.Now.Year == input.Date.Year)
            RetVal = String.Format(English, "{0:d MMMM}", input);
        else
            RetVal = String.Format(English, "{0:d MMMM yyyy}", input);

        return RetVal.Replace(".", "");
    }

    public string ToDateTimeTitle(object input)
    {
        try
        {
            return ToDateTimeTitle((DateTime)(input));
        }
        catch (Exception) { return string.Empty; }
    }

    public string ToDateTimeTitle(DateTime input)
    {
        return string.Format(English, "{0:dddd, \nd MMMM, yyyy \nh:mm:ss tt}", input);
    }

    public string ToTimeAgo(DateTime input)
    {
        return string.Format(English, "{0:yyyy-MM-dd HH:mm:ss}", input);
    }

    public string ToTimeAgo(object input)
    {
        try
        {
            return ToTimeAgo((DateTime)(input));
        }
        catch (Exception) { return string.Empty; }
    }

    public CultureInfo Bangla
    {
        get
        {
            return new CultureInfo("bn-BD");
        }
    }

    public CultureInfo English
    {
        get
        {
            return new CultureInfo("en-NZ");
        }
    }

    private static ImageCodecInfo GetEncoderInfo(String mimeType)
    {
        int j;
        ImageCodecInfo[] encoders;
        encoders = ImageCodecInfo.GetImageEncoders();
        for (j = 0; j < encoders.Length; ++j)
        {
            if (encoders[j].MimeType == mimeType)
                return encoders[j];
        }
        return null;
    }

    public void ResizeImage(Bitmap image, int maxWidth, int maxHeight, int quality, string filePath)
    {
        // Get the image's original width and height
        int originalWidth = image.Width;
        int originalHeight = image.Height;

        // To preserve the aspect ratio
        float ratioX = (float)maxWidth / (float)originalWidth;
        float ratioY = (float)maxHeight / (float)originalHeight;
        float ratio = Math.Min(ratioX, ratioY);

        // New width and height based on aspect ratio
        int newWidth = (int)(originalWidth * ratio);
        int newHeight = (int)(originalHeight * ratio);

        // Convert other formats (including CMYK) to RGB.
        Bitmap newImage = new Bitmap(newWidth, newHeight, PixelFormat.Format24bppRgb);

        // Draws the image in the specified size with quality mode set to HighQuality
        using (Graphics graphics = Graphics.FromImage(newImage))
        {
            graphics.CompositingQuality = CompositingQuality.HighQuality;
            graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphics.SmoothingMode = SmoothingMode.HighQuality;
            graphics.DrawImage(image, 0, 0, newWidth, newHeight);
        }

        // Get an ImageCodecInfo object that represents the JPEG codec.
        ImageCodecInfo imageCodecInfo = GetEncoderInfo("image/jpeg");

        // Create an Encoder object for the Quality parameter.
        Encoder encoder = Encoder.Quality;

        // Create an EncoderParameters object. 
        EncoderParameters encoderParameters = new EncoderParameters(1);

        // Save the image as a JPEG file with quality level.
        EncoderParameter encoderParameter = new EncoderParameter(encoder, quality);
        encoderParameters.Param[0] = encoderParameter;
        newImage.Save(filePath, imageCodecInfo, encoderParameters);
    }
    public byte[] ResizeImage(Bitmap image, int maxWidth, int maxHeight, int quality)
    {
        // Get the image's original width and height
        int originalWidth = image.Width;
        int originalHeight = image.Height;

        // To preserve the aspect ratio
        float ratioX = (float)maxWidth / (float)originalWidth;
        float ratioY = (float)maxHeight / (float)originalHeight;
        float ratio = Math.Min(ratioX, ratioY);

        // New width and height based on aspect ratio
        int newWidth = (int)(originalWidth * ratio);
        int newHeight = (int)(originalHeight * ratio);

        // Convert other formats (including CMYK) to RGB.
        Bitmap newImage = new Bitmap(newWidth, newHeight, PixelFormat.Format24bppRgb);

        // Draws the image in the specified size with quality mode set to HighQuality
        using (Graphics graphics = Graphics.FromImage(newImage))
        {
            graphics.CompositingQuality = CompositingQuality.HighQuality;
            graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphics.SmoothingMode = SmoothingMode.HighQuality;
            graphics.DrawImage(image, 0, 0, newWidth, newHeight);
        }

        // Get an ImageCodecInfo object that represents the JPEG codec.
        ImageCodecInfo imageCodecInfo = GetEncoderInfo("image/jpeg");

        // Create an Encoder object for the Quality parameter.
        Encoder encoder = Encoder.Quality;

        // Create an EncoderParameters object. 
        EncoderParameters encoderParameters = new EncoderParameters(1);

        // Save the image as a JPEG file with quality level.
        EncoderParameter encoderParameter = new EncoderParameter(encoder, quality);
        encoderParameters.Param[0] = encoderParameter;
        MemoryStream ms = new MemoryStream();
        newImage.Save(ms, imageCodecInfo, encoderParameters);

        return ms.ToArray();
    }

    public string getIP_Address()
    {
        string Client_IP_Address = string.Empty;
        try
        {
            Client_IP_Address = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
        }
        catch (Exception)
        {           try
            {
                Client_IP_Address = HttpContext.Current.Request.UserHostAddress;
            }
            catch (Exception)
            {
                Client_IP_Address = Request.ServerVariables["LOCAL_ADDR"].ToString();
            }
        }
        return Client_IP_Address;
    }
}