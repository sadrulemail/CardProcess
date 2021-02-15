using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using Microsoft.Web.Administration;
public partial class AppPoll : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        if (!TrustControl1.isRole("ADMIN"))
        {            
            Response.Write("No Permission.<br><br><a href=''>Home</a>");
            Response.End();        
        }

        Title = "Application Pools";
        DataTable DT = new DataTable();
        DT.Columns.Add("PoolName", typeof(string));
        DT.Rows.Add("Test");
        try
        {
            ServerManager serverManager = new ServerManager();
            ApplicationPoolCollection appPools = serverManager.ApplicationPools;
            foreach (ApplicationPool ap in appPools)
            {
                //ap.Recycle();
                DT.Rows.Add(ap.ToString());
            }
            DT.AcceptChanges();
            //DataTable dttt = DT;

            GridView1.DataSource = DT;
            GridView1.DataBind();
        }
        
        catch (Exception eee)
        { TrustControl1.ClientMsg(eee.ToString()); }


    }

    protected void cmdNew_Click(object sender, EventArgs e)
    {
        try
        {
            ServerManager serverManager = new ServerManager();
            ApplicationPool appPool = serverManager.ApplicationPools["goAML"];
            if (appPool != null)
            {
                if (appPool.State == ObjectState.Stopped)
                {
                    appPool.Start();
                }
                else
                {
                    appPool.Recycle();
                }
                TrustControl1.ClientMsg("done");

            }
            else
            {
                TrustControl1.ClientMsg("Pool is not available.");
            }
        }
        catch (Exception exx)
        {
            TrustControl1.ClientMsg(exx.ToString());
        }
    }
}
