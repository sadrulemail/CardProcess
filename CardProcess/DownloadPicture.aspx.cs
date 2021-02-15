//using ICSharpCode.SharpZipLib.Zip;
using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Drawing;
//using System.Web.UI.WebControls;

public partial class DownloadPicture : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BRANCHID"].ToString() != "1")
            Response.End();
        if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["batch"]) && !string.IsNullOrEmpty(Request.QueryString["type"]))
        {
            if (string.Format("{0}", Request.QueryString["type"]) == "New")
            {
                byte[] scalar = null;
                DataSet ds = new DataSet();
                using (SqlConnection conn = new SqlConnection())
                {

                    string Query = "SELECT * FROM [v_CardImage] ";

                    conn.ConnectionString = ConfigurationManager
                            .ConnectionStrings["CardDataConnectionString"].ConnectionString;
                    if (conn.State == ConnectionState.Closed) conn.Open();

                    using (SqlCommand cmd = new SqlCommand(Query, conn))
                    {
                        SqlDataAdapter ad = new SqlDataAdapter(cmd);

                        ad.Fill(ds);
                    }
                }

                using (ZipFile zipFile = new ZipFile())
                {


                    foreach (DataRow DR in ds.Tables[0].Rows)
                    {
                        string pictureName = DR["ID"].ToString() + ".jpg";

                        scalar = (byte[])DR["picture"];
                        scalar = Common.Decompress(scalar);
                        using (MemoryStream tempstream = new MemoryStream())
                        {
                            Image userImage = byteArrayToImage(scalar);
                            userImage.Save(tempstream, System.Drawing.Imaging.ImageFormat.Jpeg);
                            tempstream.Seek(0, SeekOrigin.Begin);
                            byte[] imageData = new byte[tempstream.Length];
                            tempstream.Read(imageData, 0, imageData.Length);
                            zipFile.AddEntry(pictureName, imageData);
                        }
                    }

                    zipFile.Save(Response.OutputStream);
                    Response.Close();
                    //File.ReadAllBytes(zipFile);
                    //downloading image zip file
                    //Response.Clear();
                    //Response.ClearContent();
                    //Response.ClearHeaders();
                    //Response.ContentType = "application/zip";
                    //Response.AddHeader("Content-Disposition", "attachment;filename=" + "ImageFiles.zip");
                    //Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    //Response.WriteFile(zipFile.ToString());
                    //Response.End();
                    //return;

                }
                }
            
        }
    }
    public static Image byteArrayToImage(byte[] byteArrayIn)
    {
        var ms = new MemoryStream(byteArrayIn);
        var returnImage = Image.FromStream(ms);
        return returnImage;
    }
}