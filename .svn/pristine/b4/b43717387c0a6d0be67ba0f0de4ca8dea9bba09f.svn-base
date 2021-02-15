using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.parser;
using System.Text;

public partial class Test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        StringBuilder text = new StringBuilder();
        string Page="";
        using (PdfReader reader = new PdfReader("D:\\ActiveReports Document2.pdf"))
        {
            for (int i = 1; i <= reader.NumberOfPages; i++)
            {
                ITextExtractionStrategy objExtractStrategy = new SimpleTextExtractionStrategy();

                string strLineText = PdfTextExtractor.GetTextFromPage(reader, i, objExtractStrategy);

                strLineText = Encoding.UTF8.GetString(ASCIIEncoding.Convert(Encoding.Default, Encoding.UTF8, Encoding.Default.GetBytes(strLineText)));
            }
        }

        text.ToString();
    }
}