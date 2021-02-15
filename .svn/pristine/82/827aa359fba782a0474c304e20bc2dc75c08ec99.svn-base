using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Item_Count : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        //if(Session["BRANCHID"].ToString() != "1" || Session["ROLEID"].ToString() =="11")
        {
            //Response.Redirect("./", true);
        }
    
        if (!IsPostBack)
        {
            SetDate_Today();
            
            RefreshControls();
        }

        Title = "Item Count";
    }
    private void SetDate_Today()
    {
        TextBox1.Text = DateTime.Now.ToString("dd/MM/yyyy");
        TextBox2.Text = DateTime.Now.ToString("dd/MM/yyyy");
    }
    protected void cmdShow_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
        RefreshLabel();
        RefreshControls();
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RefreshControls();
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
                    E = new DateTime(T.Year, 12, 31);
                    break;
                case "Last Year":
                    S = T.AddDays(-T.DayOfYear + 1);
                    S = S.AddYears(-1);
                    E = new DateTime(E.Year - 1, 12, 31);
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
                //Test
                //TextBox1.Text = ("01/01/2010");
                //
            }

            RefreshLabel();

            GridView1.DataBind();

            TextBox1.Enabled = false;
            TextBox2.Enabled = false;
        }       
    }

    private void RefreshLabel()
    {
        if (TextBox1.Text.Trim() == TextBox2.Text.Trim() && TextBox1.Text.Trim() != "")
            lblTitle.Text = "Items entry on " + TextBox1.Text;
        else if (TextBox1.Text.Trim() != "" && TextBox2.Text.Trim() != "")
            lblTitle.Text = "Items entry from " + TextBox1.Text + " to " + TextBox2.Text;
        else
            lblTitle.Text = "All items entry";
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            int TotalInsert = 0;
            int TotalModify = 0;

            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                TotalInsert += int.Parse(GridView1.Rows[i].Cells[4].Text);
                TotalModify += int.Parse(GridView1.Rows[i].Cells[5].Text);
            }

            GridView1.FooterRow.Cells[3].Text = "Total:";
            GridView1.FooterRow.Cells[3].HorizontalAlign = HorizontalAlign.Right;

            GridView1.FooterRow.Cells[4].Text = TotalInsert.ToString();
            GridView1.FooterRow.Cells[4].HorizontalAlign = HorizontalAlign.Center;

            GridView1.FooterRow.Cells[5].Text = TotalModify.ToString();
            GridView1.FooterRow.Cells[5].HorizontalAlign = HorizontalAlign.Center;
        }
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        RefreshLabel();
        RefreshControls();
    }
    protected void DropDownListBranch_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem i in DropDownListBranch.Items)
            if (i.Value == Session["BRANCHID"].ToString())
                i.Selected = true;
            else 
                i.Selected = false;

        if (Session["BRANCHID"].ToString() != "1" || !TrustControl1.isRole("ADMIN"))
            DropDownListBranch.Enabled = false;

        GridView1.DataBind();
    }
}
