using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using System.IO;
using OfficeOpenXml;

public partial class ForwardingReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();

        //if (!TrustControl1.isRole("ADMIN"))
        //{
        //    if (Session["DEPTID"].ToString() != "7")    //Not IT & Cards
        //    {
        //        Response.Write("No Permission.<br><br><a href=''>Home</a>");
        //        Response.End();
        //    }
        //}
        if (!IsPostBack)
        {
            SetDate_Today();
            RefreshControls();
        }

        Title = "Forwarding Report";
    }
    protected void SqlDataSource7_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        Label1.Text = "<b>Total Record(s):</b>" + e.AffectedRows.ToString();
        Label1.Visible = e.AffectedRows > 0;
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RefreshControls();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    private void RefreshControls()
    {
        DateTime T = DateTime.Now.Date;
        DateTime S = T;
        DateTime E = T;

        if (DropDownList1.SelectedItem.Value == "Custom Range")
        {
            DropDownList1.BackColor = System.Drawing.Color.Transparent;
            TextBox1.Enabled = true;
            TextBox2.Enabled = true;
        }
        else
        {
            DropDownList1.BackColor = System.Drawing.Color.Yellow;

            switch (DropDownList1.SelectedItem.Value)
            {
                case "Today":
                    SetDate_Today();
                    break;
                case "Yesterday":
                    S = T.AddDays(-1);
                    E = T.AddDays(-1);
                    break;
                case "This Week":
                    S = T.AddDays(-int.Parse(T.DayOfWeek.ToString("d")));
                    E = T;
                    break;
                case "Last Week":
                    S = T.AddDays(-7 - int.Parse(T.DayOfWeek.ToString("d")));
                    E = S.AddDays(6);
                    break;
                case "This Month":
                    S = T.AddDays(-T.Day + 1);
                    E = T;
                    break;
                case "Last Month":
                    S = (T.AddDays(-T.Day + 1)).AddMonths(-1);
                    E = T.AddDays(-T.Day);
                    break;
                case "This Year":
                    S = T.AddDays(-T.DayOfYear + 1);
                    E = T;
                    break;
                case "Show All":
                    S = new DateTime(1900, 1, 1);
                    E = S;
                    break;
            }

            if (S == new DateTime(1900, 1, 1))
            {
                TextBox1.Text = "";
                TextBox2.Text = "";
            }
            else
            {
                TextBox1.Text = S.ToString("dd/MM/yyyy");
                TextBox2.Text = E.ToString("dd/MM/yyyy");
            }

            RefreshLabel();

            GridView1.DataBind();

            TextBox1.Enabled = false;
            TextBox2.Enabled = false;
        }
    }
    private void RefreshLabel()
    {

    }
    private void SetDate_Today()
    {
        TextBox1.Text = DateTime.Now.ToString("dd/MM/yyyy");
        TextBox2.Text = DateTime.Now.ToString("dd/MM/yyyy");
    }
   

    private static string SortString(string Branches)
    {
        int[] i_Branches;
        List<int> ints = new List<int>();
        string[] strings = Branches.Split(',');

        foreach (string s in strings)
        {
            int i;
            if (int.TryParse(s.Trim(), out i))
            {
                ints.Add(i);
            }
        }
        i_Branches = ints.ToArray();

        Array.Sort(i_Branches);

        Branches = "";
        foreach (int s in i_Branches)
            Branches += "," + s.ToString();
        if (Branches.Length > 1)
        {
            Branches = Branches.Substring(1);
        }
        return Branches;
    }


    protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        downloadxlsx.Visible = e.AffectedRows > 0;

    }

    protected void downloadxlsx_Click(object sender, EventArgs e)
    {
        string FileName = Path.GetTempFileName();
        try
        {
            FileInfo FI = new FileInfo(FileName);
            if (File.Exists(FileName)) File.Delete(FileName);
            using (ExcelPackage xlPackage = new ExcelPackage(FI))
            {
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets.Add("Forwarding Report");
                int StartRow = 1;

                //Adding Title Row
                worksheet.Column(1).Width = 15;
                worksheet.Column(2).Width = 25;
                worksheet.Column(3).Width = 20;
               
                worksheet.Cells["A1:K1"].Style.Font.Bold = true;
                worksheet.Cells["A1:K1"].Style.WrapText = true;


                //Adding Title Row
                worksheet.Cells[StartRow, 1].Value = "Req Type";
                worksheet.Cells[StartRow, 2].Value = "Location Type";
                worksheet.Cells[StartRow, 3].Value = "Total";
                
                int R;

                DataView DV = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);

                for (int r = 0; r < DV.Table.Rows.Count; r++)
                {
                    R = StartRow + r + 1;

                    if (DV.Table.Rows[r]["ReqTypeName"] != DBNull.Value)
                        worksheet.Cells[R, 1].Value = DV.Table.Rows[r]["ReqTypeName"].ToString();
                    if (DV.Table.Rows[r]["LocationName"] != DBNull.Value)
                        worksheet.Cells[R, 2].Value = DV.Table.Rows[r]["LocationName"].ToString();
                    if (DV.Table.Rows[r]["total"] != DBNull.Value)
                        worksheet.Cells[R, 3].Value = DV.Table.Rows[r]["total"].ToString();
                   

                }

                worksheet.Cells["A1:I"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["I1:I"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["C1:C"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Right;
                worksheet.Cells["E1:E"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                worksheet.Cells["K1:K"].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Left;
                //Adding Properties
                xlPackage.Workbook.Properties.Title = "Forwarding Report" + DateTime.Now.Date.ToString("dd/MM/yyyy");
                xlPackage.Workbook.Properties.Author = "Sadrul(sadrul.email@gmail.com)";
                xlPackage.Workbook.Properties.Company = "Trust Bank Limited";
                xlPackage.Workbook.Properties.LastModifiedBy = string.Format("{0} ({1})", Session["FULLNAME"], "sadrul.email@gmail.com");

                xlPackage.Save();
            }


            //Reading File Content
            byte[] content = File.ReadAllBytes(FileName);
            File.Delete(FileName);

            //Downloading File
            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.ContentType = "application/ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + "Forwarding_Report_" + DateTime.Now.Date.ToString("dd/MM/yyyy") + ".xlsx");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(content);
            Response.End();
        }
        catch (Exception exx) { TrustControl1.ClientMsg(exx.Message); }

    }




}