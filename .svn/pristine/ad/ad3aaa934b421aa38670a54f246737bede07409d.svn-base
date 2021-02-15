using System;
using System.Web;
using System.Web.UI;
using System.IO;

public partial class DisputeLetterPrint : System.Web.UI.Page
{
    string Type = "";
    string ContentType = "inline";
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

        //if (ReqType.ToLower() == "print") ContentType = "inline";
        //else if (ReqType.ToLower() == "download") ContentType = "attachment";

        //Output to PDF
        try
        {
            using (Stream oStream = (Stream)CrystalReportSource1.ReportDocument.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat))
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    //SqlDataSourcePrintLog_Insert.Select(DataSourceSelectArguments.Empty);
                    oStream.CopyTo(ms);
                    Response.Clear();
                    Response.ClearContent();
                    Response.ClearHeaders();
                    //Response.Buffer = true;
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-Disposition", string.Format("{1};filename=Dispute_Settelment_Letter_{0}.pdf", Request.QueryString["DisputeID"], ContentType));
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.BinaryWrite(ms.ToArray());
                    Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    protected void SqlDataSource1_Selected(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows == 0)
        {
            Response.Clear();
            Response.Write("Invalid Request");
            Response.End();
        }
    }
}