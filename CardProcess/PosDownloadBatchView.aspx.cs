using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PosDownloadBatchView : System.Web.UI.Page
{
    public decimal SATotalCr = 0;
    public decimal SATotalDr = 0;
    public decimal CATotalDr = 0;
    public decimal CATotalCr = 0;
    public decimal MATotal = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.LoadEmpToSession(false);

        

        //if (Session["BRANCHID"].ToString() != "1")
        //    if (Session["BRANCHID"].ToString() != string.Format("{0}", Request.QueryString["branch"]))
        //    {
        //        Response.End();
        //        return;
        //    }

       

        this.Title = string.Format("Reconciliation Batch: {0}", Request.QueryString["batch"]);
    }
    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        //lblStatus.Text = string.Format("Total Rows: <b>{0:N0}</b>", e.AffectedRows);
    }

    protected void GridView1_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        // check row type
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (DataBinder.Eval(e.Row.DataItem, "Dr_Cr").ToString() == "DR")
                SATotalDr += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount_tk"));
            else
                SATotalCr += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount_tk"));

        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            //lblCr.Text = "CR Amount#" + String.Format("{0:N2}",TotalCr);
            //lblDr.Text = "DR Amount#" +String.Format("{0:N2}", TotalDr);

            e.Row.Cells[0].ColumnSpan = 2;
            e.Row.Cells.RemoveAt(1);
            e.Row.Cells[1].ColumnSpan = 3;
            e.Row.Cells.RemoveAt(2);
            e.Row.Cells.RemoveAt(2);

            e.Row.Cells[0].Text = "CR = " + String.Format("{0:N2}", SATotalCr);
            e.Row.Cells[1].Text = "DR = " + String.Format("{0:N2}", SATotalDr);

        }
    }

    protected void GridView2_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        // check row type
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (DataBinder.Eval(e.Row.DataItem, "Dr_Cr").ToString() == "DR")
                CATotalDr += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount_tk"));
            else
                CATotalCr += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount_tk"));

        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[0].ColumnSpan = 2;
            e.Row.Cells.RemoveAt(1);
            e.Row.Cells[1].ColumnSpan = 3;
            e.Row.Cells.RemoveAt(2);
            e.Row.Cells.RemoveAt(2);

            e.Row.Cells[0].Text = "CR = " + String.Format("{0:N2}", CATotalCr);
            e.Row.Cells[1].Text = "DR = " + String.Format("{0:N2}", CATotalDr);

        }
    }

    protected void GridView3_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        // check row type
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           
                MATotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount_tk"));
           

        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            //lblCr.Text = "CR Amount#" + String.Format("{0:N2}",TotalCr);
            //lblDr.Text = "DR Amount#" +String.Format("{0:N2}", TotalDr);

            e.Row.Cells[0].ColumnSpan = 5;
            e.Row.Cells.RemoveAt(1);
            e.Row.Cells.RemoveAt(1);
            e.Row.Cells.RemoveAt(1);
            e.Row.Cells.RemoveAt(1);            

            //e.Row.Cells[0].Text = "";
            e.Row.Cells[0].Text = String.Format("Total = {0:N2}", MATotal);

        }
    }
}