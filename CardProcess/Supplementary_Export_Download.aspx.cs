﻿using System;
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
using System.Data.SqlClient;

public partial class Supplementary_Export_Download : System.Web.UI.Page
{
    protected void SqlDataSource3_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
            lblStatus.Text = string.Format("Total Cards: <b>{0:N0}</b>", e.AffectedRows);
        else
            lblStatus.Text = "";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (TrustControl1.isRole() == "")
        //    Response.End();
        TrustControl1.getUserRoles();

        if (Session["BRANCHID"].ToString() != "1")
            Response.End();

        if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["batch"]) && !string.IsNullOrEmpty(Request.QueryString["type"]))
        {
            
             if (string.Format("{0}", Request.QueryString["type"]) == "view")
            {
                GridView1.DataBind();
            }
            else if (string.Format("{0}", Request.QueryString["type"]) == "xml")
            {
                try
                {
                    
                    Int32 BatchID = Int32.Parse(Request.QueryString["batch"]);
                    string CardType = Request.QueryString["CardType"];

                    string oConnString = System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString;
                    SqlConnection oConn = new SqlConnection(oConnString);
                    SqlCommand oCommand = new SqlCommand("s_Supplementary_ExportToITCL_xml", oConn);
                    oCommand.CommandType = CommandType.StoredProcedure;
                    oCommand.Parameters.AddWithValue("BatchID", BatchID);
                    
                    if (oConn.State == ConnectionState.Closed)
                        oConn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(oCommand);

                    DataSet Dss = new DataSet();
                    da.Fill(Dss);

                    string FileName = System.IO.Path.GetRandomFileName();


                    StringBuilder SW = new StringBuilder();

                    string line00 = "<?xml version=" + "\"" + "1.0" + "\"" + " encoding=" + "\"" + "UTF-8" + "\"" + "?>";
                    string line0 = "<dataroot xmlns:od=" + "\"" + "urn:schemas-microsoft-com:officedata" + "\" " + "generated=" + "\"" + string.Format("{0}", DateTime.Now.ToString("yyyy-MM-ddTHH:mm:ss")) + "\" " + ">";

                    SW.Append(line00).AppendLine();
                    SW.Append(line0).AppendLine();

                    foreach (DataRow dr in Dss.Tables[0].Rows)
                    {
                        string line = dr[0].ToString();
                        SW.Append(line).AppendLine();
                    }
                    string linelast = "</dataroot>";
                    SW.Append(linelast).AppendLine();

                    //Downloading xml file 
                    string download_file_name = "attachment; filename=New_Supplementary_Issue_"+CardType+"_"+ BatchID + ".xml";
                    Response.ClearHeaders();
                    Response.Clear();
                    Response.ClearContent();
                    Response.AddHeader("content-disposition", download_file_name);
                    Response.ContentType = "text/xml";
                    Response.AddHeader("Pragma", "public");

                    Response.Write(SW);
                    Response.End();
                }
                catch (Exception ex)
                {
                    //lblStatus.Text = ex.Message;
                }

            }
            else if (Request.QueryString["type"].ToString() == "xlsx")
            {
                try
                {
                    string FileName = Path.GetTempFileName();
                    string BatchID = Request.QueryString["batch"].ToString();
                    string CardType = Request.QueryString["CardType"];

                    if (File.Exists(FileName)) File.Delete(FileName);
                    FileInfo FI = new FileInfo(FileName);

                    using (ExcelPackage xlPackage = new ExcelPackage(FI))
                    {
                        ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("Supplementary Card Issue List");
                        int StartRow = 1;
                        //Adding Title Row
                        worksheet.Cells[StartRow, 1].Value = "Accountno";
                        worksheet.Cells[StartRow, 2].Value = "Amount_tk";
                        worksheet.Cells[StartRow, 3].Value = "Dr_Cr";
                        worksheet.Cells[StartRow, 4].Value = "Trn_br_code";

                        worksheet.Column(1).Width = 22;
                        worksheet.Column(2).Width = 20;
                        worksheet.Column(3).Width = 15;
                        worksheet.Column(4).Width = 15;

                        DataView DV = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);

                        for (int r = 0; r < DV.Table.Rows.Count; r++)
                        {
                            int R = StartRow + r + 1;

                            if (DV.Table.Rows[r]["Account"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["Account"].ToString();
                                //worksheet.Cells[R, 1].Style.Numberformat.Format = "MM/dd/yyyy";
                            }


                            if (DV.Table.Rows[r]["Card_IssueFee"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["Card_IssueFee"].ToString();
                                worksheet.Cells[R, 2].Style.Numberformat.Format = "#.##";
                            }

                            worksheet.Cells[R, 3].Value = "Dr";



                            if (DV.Table.Rows[r]["Account"] != DBNull.Value)
                            {
                                worksheet.Cells[R, 4].Value = DV.Table.Rows[r]["Account"].ToString().Trim().Substring(0, 4);
                            }
                        }
                        worksheet.Cells["A1:D1"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                        worksheet.Cells["B1:B"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                        worksheet.Cells["C1:C"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                        worksheet.Cells["D1:D"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                        worksheet.Cells["A1:D"].Style.VerticalAlignment = OfficeOpenXml.Style.ExcelVerticalAlignment.Top;
                        worksheet.Cells["A1:D1"].Style.Font.Bold = true;



                        //Adding Properties
                        xlPackage.Workbook.Properties.Title = "Supplementary_CARD-ISSUE";
                        xlPackage.Workbook.Properties.Author = "Sadrul";
                        xlPackage.Workbook.Properties.Company = "Trust Bank Limited";
                        //xlPackage.Workbook.Properties.LastModifiedBy = string.Format("{0}", Session["EMPNAME"]);

                        xlPackage.Save();
                    }
                    //Reading File Content
                    byte[] content = File.ReadAllBytes(FileName);
                    File.Delete(FileName);

                    //Downloading File
                    Response.Clear();
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.ContentType = "application/xlsx";
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + "Supplementary_CARD_ISSUE_" + CardType + "_"  + BatchID + ".xlsx");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.BinaryWrite(content);
                    Response.End();
                    return;
                }
                catch (Exception ex)
                {
                    //lblStatus.Text = ex.Message;
                }          

            }
        }
        
    }
   
}