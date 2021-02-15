using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Forwarding_Details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = string.Format("Forwarding # {0}", Request.QueryString["id"]);      
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        try
        {
            int TotalCards = 0;
            int TotalCardPack = 0;
            int TotalPinPack = 0;

            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                TotalCards += int.Parse(GridView1.Rows[i].Cells[3].Text);
                TotalCardPack += int.Parse(GridView1.Rows[i].Cells[4].Text);
                TotalPinPack += int.Parse(GridView1.Rows[i].Cells[5].Text);
            }

            GridView1.FooterRow.Cells[3].Text = string.Format("{0}", TotalCards);
            GridView1.FooterRow.Cells[4].Text = string.Format("{0}", TotalCardPack);
            GridView1.FooterRow.Cells[5].Text = string.Format("{0}", TotalPinPack);
        }
        catch (Exception) { }
    }
}
