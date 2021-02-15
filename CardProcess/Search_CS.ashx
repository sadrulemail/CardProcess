<%@ WebHandler Language="C#" Class="Search_CS" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.SessionState;
using System.Threading.Tasks;

public class Search_CS : HttpTaskAsyncHandler, IReadOnlySessionState
{
    public override async Task ProcessRequestAsync(HttpContext context)
    {
        await DoAsync(context);
    }

    private async Task<int> DoAsync(HttpContext context)
    {
        await Task.Run(() =>
        {
            DoTask(context);
        });
        return 0;
    }

    private void DoTask(HttpContext context)
    {
        string prefixText = context.Request.QueryString["term"];

        //System.Threading.Thread.Sleep(2000);
        using (SqlConnection conn = new SqlConnection())
        {
            SqlConnection.ClearAllPools();
            string Query = string.Format("EXEC sp_Emp_Search_Box '{0}', '{1}'", prefixText, context.Session["EMPID"]);
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["TblUserDBConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = Query;
                cmd.Connection = conn;
                StringBuilder sb = new StringBuilder();
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    //while (sdr.Read())
                    //{
                    //    sb.Append(
                    //        string.Format("{0},{1},{2},{3}"
                    //        , sdr["RESULT"].ToString().Replace(",", " ").Replace(Environment.NewLine, " ").Replace("\n", "")
                    //        , sdr["Img"]
                    //        , sdr["ID"]
                    //        , sdr["URL"])
                    //        ).Append(Environment.NewLine);
                    //}
                    while (sdr.Read())
                    {
                        sb.Append("{").Append(
                            string.Format("\"name\":\"{0}\",\"img\":\"{1}\",\"id\":\"{2}\",\"profile\":\"{3}\",\"result\":\"{4}\""
                            , sdr["name"].ToString().Replace(",", " ").Replace(Environment.NewLine, " ").Replace("\n", "")
                            , sdr["Img"]
                            , sdr["ID"]
                            , sdr["URL"]
                            , sdr["result"].ToString().Replace(",", " ").Replace(Environment.NewLine, " ").Replace("\n", "")
                            )
                            ).Append("},");
                    }
                }
                conn.Close();
                try
                {
                    context.Response.Write("[" + sb.ToString().Substring(0, sb.Length - 1) + "]");
                }
                catch (Exception) { context.Response.Write("[]"); }
            }
        }
    }
}