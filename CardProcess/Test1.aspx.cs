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
using System.Data;

public partial class Test1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //DataTable dt = new DataTable();
        //dt.Columns.Add("IssueDate", typeof(DateTime));
        //dt.Rows.Add("01/01/0202");

        //DataRow[] rows = dt.Select("IssueDate < '1/1/1753'");

        // Input string.
        const string input = "Tbl123!";

        // Invoke GetBytes method.
        // ... You can store this array as a field!
        //byte[] array = Encoding.ASCII.GetBytes(input);
        byte[] arr = Encoding.UTF8.GetBytes(input);

        string dd = arr.ToString();

        String ValueToConvert = "Stack overflow";
        //byte[] ConvertedBytes = ValueToConvert.GetBytes("UTF-8");
    }
}