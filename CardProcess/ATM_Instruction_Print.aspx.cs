using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class ATM_Instruction_Print : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
    }

    protected void CrystalReportViewer1_AfterRender(object source, CrystalDecisions.Web.HtmlReportRender.AfterRenderEvent e)
    {
        ExportToPdf();
    }

    private void ExportToPdf()
    {
        //CrystalReportSource1.ReportDocument.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat
        //    , this.Response, true, string.Format("Remittance_Receipt_{0}", Request.QueryString["id"]));
        ////CrystalReportSource1.ReportDocument.Close();
        ////CrystalReportSource1.ReportDocument.Dispose();

        //Output to PDF
        try
        {
            using (MemoryStream oStream = (MemoryStream)CrystalReportSource1.ReportDocument.ExportToStream(
                    CrystalDecisions.Shared.ExportFormatType.PortableDocFormat))
            {
                //SqlDataSourcePrintLog_Insert.Select(DataSourceSelectArguments.Empty);
                Response.Clear();
                Response.ClearContent();
                Response.ClearHeaders();
                Response.Buffer = true;
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", string.Format("inline;filename=Atm_Cash_Load_{0}.pdf", Request.QueryString["id"]));
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.BinaryWrite(oStream.ToArray());
                Response.End();
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
}