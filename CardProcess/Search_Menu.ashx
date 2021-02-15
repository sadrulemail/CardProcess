<%@ WebHandler Language="C#" Class="Search_Menu" %>

using System;
using System.Web;
using System.Text;
using System.Web.SessionState;

public class Search_Menu : IHttpHandler, IReadOnlySessionState
{
    public void ProcessRequest(HttpContext context)
    {
        string prefixText = context.Request.QueryString["term"];
        int ID = 1;
        StringBuilder sb = new StringBuilder();

        foreach (SiteMapNode node1 in SiteMap.RootNode.ChildNodes)
        {
            foreach (SiteMapNode node in node1.ChildNodes)
            {
                if (
                        (
                            node.Title.ToLower().IndexOf(prefixText.ToLower()) >= 0
                            || node1.Title.ToLower().IndexOf(prefixText.ToLower()) >= 0
                        )
                        && CheckMenuPermision(context, node) == true)
                {
                    sb.Append("{").Append(
                        string.Format("\"name\":\"{0}\",\"img\":\"{1}\",\"id\":\"{2}\",\"url\":\"{3}\",\"result\":\"{4}\""
                        , node1.Title + " &raquo; " + node.Title.ToString().Replace(",", " ").Replace(Environment.NewLine, " ").Replace("\n", "")
                        , ""
                        , ID++
                        , node.Url
                        , node.Title.ToString().Replace(",", " ").Replace(Environment.NewLine, " ").Replace("\n", "")
                        )
                        ).Append("},");
                }
            }
        }
        //conn.Close();
        try
        {
            context.Response.Write("[" + sb.ToString().Substring(0, sb.Length - 1) + "]");
        }
        catch (Exception) { context.Response.Write("[]"); }
    }

    private bool CheckMenuPermision(HttpContext context, SiteMapNode node)
    {
        bool isRoleAssigned = false;
        bool isBranchAssigned = false;


        string[] Roles = context.Session["ROLES"].ToString().Split(',');

        //Check Branch
        if (!string.IsNullOrEmpty(node["branch"]))
        {
            string[] branches = node["branch"].ToString().Split(',');
            for (int i = 0; i < branches.Length; i++)
                if (branches[i] == context.Session["BRANCHID"].ToString()
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
        for (int i = 0; i < node.Roles.Count; i++)
            foreach (string R in Roles)
                if (node.Roles[i].ToString().ToLower() == R.ToLower()
                    || node.Roles[i].ToString() == "*")
                {
                    isRoleAssigned = true;
                }



        if (!isRoleAssigned || !isBranchAssigned)
        {
            return false;
        }

        return true;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}