using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using OfficeOpenXml;
using System.IO;
using SocialExplorer.IO.FastDBF;
using System.Net;

public partial class SettlementFileDownload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        

        if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["batchid"]) && !string.IsNullOrEmpty(Request.QueryString["type"]))
        {
            //if (string.Format("{0}", Request.QueryString["type"]) == "Dr")
            //{

            //    int i,j,k = 0;
            //    string BatchID = Request.QueryString["batchid"].ToString();
            //    string Type = Request.QueryString["type"].ToString();                
            //    DataSourceSelectArguments args = new DataSourceSelectArguments();
            //    DataView view = (DataView)SqlDataSource2.Select(args);
            //    DataTable dt = view.ToTable();

            //    DataSourceSelectArguments argsDrCr = new DataSourceSelectArguments();
            //    DataView viewDrCr = (DataView)SqlDataSource1.Select(argsDrCr);
            //    DataTable dtDrCr = viewDrCr.ToTable();  
                
            //    Random rnd = new Random();
            //    int dice = rnd.Next(1000, 10000);
                
            //    String newName = "OFS" + DateTime.Now.ToString("yyyyMMdd") + dice + ".txt";
            //    //StringBuilder sb = new StringBuilder();        

                    
            //        using (System.IO.StreamWriter SW = new System.IO.StreamWriter(
            //               Server.MapPath("Upload/" + newName + ".txt")))
            //        {                        
            //            SW.WriteLine("Accountno,Amount_tk,Dr_Cr,Trn_br_code");

            //            for (k = 0; k < dtDrCr.Rows.Count; k++)
            //            {
            //                String AccountNo = "9102306", Amount = "", Dr_Cr = "Cr", Trn_Br_Code = "0001";
            //                Amount = dtDrCr.Rows[k]["Amount"].ToString();
            //                SW.Write(AccountNo);
            //                SW.Write(",");
            //                SW.Write(Amount);
            //                SW.Write(",");
            //                SW.Write(Dr_Cr);
            //                SW.Write(",");
            //                SW.Write(Trn_Br_Code);
            //                SW.WriteLine();
            //            }

                        
            //            for (i = 0; i < dt.Rows.Count; i++)
            //            {
            //                String AccountNo = "", Amount = "",Dr_Cr="", Trn_Br_Code = "0001";
            //                //BankName = dt.Rows[i]["BankName"].ToString();
            //                AccountNo = dt.Rows[i]["AccountNo"].ToString();
            //                Amount = dt.Rows[i]["Amount"].ToString();
            //                Dr_Cr = dt.Rows[i]["DrCr"].ToString();
                            
            //                //SW.Write(BankName);
            //                //SW.Write(",");
            //                SW.Write(AccountNo);
            //                SW.Write(",");
            //                SW.Write(Amount);
            //                SW.Write(",");
            //                SW.Write(Dr_Cr);
            //                SW.Write(",");
            //                SW.Write(Trn_Br_Code);                           
            //                SW.WriteLine();
                           
            //            }
            //            SW.Close();
            //        }

            //        System.IO.FileStream fs = null;
            //        fs = System.IO.File.Open(Server.MapPath("Upload/" +
            //                 newName + ".txt"), System.IO.FileMode.Open);
            //        byte[] btFile = new byte[fs.Length];
            //        fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
            //        fs.Close();
            //        Response.AddHeader("Content-disposition", "attachment; filename=" +
            //                           newName);
            //        Response.ContentType = "application/octet-stream";
            //        Response.BinaryWrite(btFile);
            //        string path = Server.MapPath("Upload/" + newName + ".txt");
            //        if (File.Exists(path))
            //        {
            //            File.Delete(path);
            //        }
            //        Response.End();                 

                
            //}
            //else if (string.Format("{0}", Request.QueryString["type"]) == "Cr")
            {
                int i, j = 0;
                string BatchID = Request.QueryString["batchid"].ToString();
                string Type = Request.QueryString["type"].ToString();
                DataSourceSelectArguments args = new DataSourceSelectArguments();
                DataView view = (DataView)SqlDataSource2.Select(args);
                DataTable dt1 = view.ToTable();                

                Random rnd = new Random();
                int dice = rnd.Next(1000, 10000);

                String newName = "OFS" + DateTime.Now.ToString("yyyyMMddhhmm") + ".txt";
               
                using (System.IO.StreamWriter SW = new System.IO.StreamWriter(
                       Server.MapPath("Upload/" + newName + ".txt")))
                {
                    SW.WriteLine("Accountno,Amount_tk,Dr_Cr,Trn_br_code");
                   

                    for (i = 0; i < dt1.Rows.Count; i++)
                    {
                        String AccountNo = "", Amount = "", Dr_Cr = "", Trn_Br_Code = "";
                        
                        AccountNo = dt1.Rows[i]["AccountNo"].ToString();
                        Amount = dt1.Rows[i]["Amount"].ToString();
                        Dr_Cr = dt1.Rows[i]["DrCr"].ToString();
                        Trn_Br_Code = dt1.Rows[i]["Trn_Br_Code"].ToString();
                        
                        SW.Write(AccountNo);
                        SW.Write(",");
                        SW.Write(Amount);
                        SW.Write(",");
                        SW.Write(Dr_Cr);
                        SW.Write(",");
                        SW.Write(Trn_Br_Code);
                        SW.WriteLine();

                    }
                    SW.Close();
                }

                System.IO.FileStream fs = null;
                fs = System.IO.File.Open(Server.MapPath("Upload/" +
                         newName + ".txt"), System.IO.FileMode.Open);
                byte[] btFile = new byte[fs.Length];
                fs.Read(btFile, 0, Convert.ToInt32(fs.Length));
                fs.Close();
                Response.AddHeader("Content-disposition", "attachment; filename=" +
                                   newName);
                Response.ContentType = "application/octet-stream";
                Response.BinaryWrite(btFile);
                string path = Server.MapPath("Upload/" + newName + ".txt");
                if (File.Exists(path))
                {
                    File.Delete(path);
                }
                Response.End();  

            }
        }

    }

    
}