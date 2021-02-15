﻿using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using SocialExplorer.IO.FastDBF;

public partial class Card_Payment_Batch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        string Batch = string.Format("{0}", Request.QueryString["batch"]);
        string Type = string.Format("{0}", Request.QueryString["type"]);

        lblBatch.Text = string.Format("Card Payment Batch: {0}", Batch);
        this.Title = string.Format("#{0} Card Payment Batch", Batch);

        if (Type.ToLower() == "dbf")
        {
            try
            {
                string FileName = Path.GetTempFileName();
                string BatchID = Request.QueryString["batch"].ToString();

                DbfFile odbf = new DbfFile();
                odbf.Open(FileName, FileMode.Create);

                odbf.Header.AddColumn(new DbfColumn("SBK_PAN", DbfColumn.DbfColumnType.Number, 20, 0));
                odbf.Header.AddColumn(new DbfColumn("SBK_MBR", DbfColumn.DbfColumnType.Number, 20, 0));
                odbf.Header.AddColumn(new DbfColumn("SBK_SUM", DbfColumn.DbfColumnType.Number, 24, 2));
                odbf.Header.AddColumn(new DbfColumn("SBK_ACUR", DbfColumn.DbfColumnType.Number, 4, 0));               
                DbfRecord orec = new DbfRecord(odbf.Header);

                DataView DV = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {

                    //string CardNo = DV.Table.Rows[r]["CardNo"].ToString();

                    //string Amount = DV.Table.Rows[r]["Amount"].ToString();

                    //string CurrencyCode = DV.Table.Rows[r]["CurrencyCode"].ToString();


                    string CardNo = DV.Table.Rows[r]["CardNo"].ToString();
                    orec[0] = CardNo;
                    orec[1] = "0";
                    string Amount = string.Format("{0:N2}", DV.Table.Rows[r]["Amount"]).Replace(",", "");
                    orec[2] = Amount;
                    string CurrencyCode = string.Format("{0:N0}", DV.Table.Rows[r]["CurrencyCode"]).Replace(",", "");
                    orec[3] = CurrencyCode;

                    odbf.Write(orec, true);
                }
                odbf.Close();


                //Reading File Content
                byte[] content = File.ReadAllBytes(FileName);
                File.Delete(FileName);

                //Downloading File
                Response.Clear();
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "application/octet-stream";
                Response.AddHeader("Content-Disposition", "attachment;filename=" + "Card_Payment_" + BatchID + ".dbf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.BinaryWrite(content);
                Response.End();
            }
            catch (Exception ex)
            {
                TrustControl1.ClientMsg(ex.Message);
                
                //Response.Clear();
                //Response.Write(ex.Message);
                //Response.End();
                
            }
        }
    }
    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        lblStatus.Text = string.Format("Total Rows: <b>{0}</b>", e.AffectedRows);
    }

}