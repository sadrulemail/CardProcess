﻿using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.IO;
using Ghostscript.NET;
using System.Web;
//using Microsoft.Exchange.WebServices.Data;


public partial class Dispute : System.Web.UI.Page
{
    int MaxFileSizePerPageKB;
    string UploadPath;
    string LastStatus = "";
    DateTime DisputeDate ;

    DataSetAttachmentDispute.s_Attachments_DisputeDataTable DT;

    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        Page.Title = "Dispute Request";
        MaxFileSizePerPageKB = int.Parse(TrustControl1.getValueOfKey("MaxFileSizePerPageKB"));
        UploadPath = Server.MapPath("Upload");

        if (Session["BranchID"].ToString() != "1")
        {
            //ddlStatusType.Visible = true;
            ddlStatusType.Visible = false;
            
        }
        else
        {            ddlStatusType.Visible = true;
            
        }
        if (!IsPostBack)
        {
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            string ID = string.Format("{0}", Request.QueryString["ID"]);
            ChangeSessionData();
            if (ID.Length == 0)
            {
                DetailsView1.DefaultMode = DetailsViewMode.Insert;
                divdischanghistory.Visible = false;
                
            }
            else
            {
                Page.Title = "Dispute ID # "+ ID;
                HidDisputeID.Value = ID;
                lblTicket.Text = ID;
                DetailsView1.DataBind();
                divdischanghistory.Visible = true;             

            }
        }
       
    }
    protected void cboType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string val = ((DropDownList)DetailsView1.FindControl("cboType")).SelectedItem.Value;
            //TrustControl1.ClientMsg(val);
            if (val == "POS")
            {
                ((DropDownList)DetailsView1.FindControl("cboBanks")).Enabled = false;
                ((DropDownList)DetailsView1.FindControl("cboBanks")).SelectedIndex = 0;
                ((TextBox)DetailsView1.FindControl("txtTerminalID")).Enabled = false;
            }
            else if (val == "ATM")
            {
                ((DropDownList)DetailsView1.FindControl("cboBanks")).Enabled = true;
                ((TextBox)DetailsView1.FindControl("txtTerminalID")).Enabled = true;
            }
            if (Session["BranchID"].ToString() == "1")
            {
                ((DropDownList)DetailsView1.FindControl("cboBanks")).Enabled = true;
                ((TextBox)DetailsView1.FindControl("txtTerminalID")).Enabled = true;
            }
            if (Session["BranchID"].ToString() != "1")
            {
                ((TextBox)DetailsView1.FindControl("txtTerminalID")).Enabled = false;
                ((TextBox)DetailsView1.FindControl("txtTraceNo")).Enabled = false;
                ((TextBox)DetailsView1.FindControl("txtApprovalCode")).Enabled = false;
                ((TextBox)DetailsView1.FindControl("txtNPSBCode")).Enabled = false;
            }
        }
        catch(Exception exxx) { }
    }
    public void ChangeSessionData()
    {
        if (!Directory.Exists(UploadPath))
        {
            Directory.CreateDirectory(UploadPath);
        }

        Random R = new Random(DateTime.Now.Millisecond +
                        DateTime.Now.Second * 1000 +
                        DateTime.Now.Minute * 60000 +
                        DateTime.Now.Hour * 3600000);

        HidPageID.Value = string.Format("{0}{1}", Session.SessionID, R.Next());
        HidUploadTempFile.Value = Server.MapPath("Upload/" + HidPageID.Value);
    }

    protected void txtCardNo_TextChanged(object sender, EventArgs e)
    {
        using (SqlConnection objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString))
        {
            string query="SELECT TOP 1 * FROM [CardData].[dbo].[v_CardProcess] WHERE CardNumber='" + ((TextBox)DetailsView1.FindControl("txtCardNo")).Text + "'";

            using (SqlDataAdapter da = new SqlDataAdapter(query, objConn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    ((Label)DetailsView1.FindControl("lblCardNo")).Text = dt.Rows[0]["FIO"].ToString();
                }
                else
                    ((Label)DetailsView1.FindControl("lblCardNo")).Text = "";
            }
        }

    }

    protected void txtTraceNo_TextChanged(object sender, EventArgs e)
    {
        using (SqlConnection objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString))
        {
            string query = "SELECT * FROM dbo.Dispute WHERE TraceNo='" + ((TextBox)DetailsView1.FindControl("txtTraceNo")).Text + "' and id<>'" + HidDisputeID.Value + "'";

            using (SqlDataAdapter da = new SqlDataAdapter(query, objConn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    ((Label)DetailsView1.FindControl("lblTraceNo")).Text = "Found in Dispute";
                }
                else
                    ((Label)DetailsView1.FindControl("lblTraceNo")).Text = "";
            }
        }

    }

    protected void txtApprovalCode_TextChanged(object sender, EventArgs e)
    {
        using (SqlConnection objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString))
        {
            string query = "SELECT * FROM dbo.Dispute WHERE ApprovalCode='" + ((TextBox)DetailsView1.FindControl("txtApprovalCode")).Text + "' and id<>'" + HidDisputeID.Value + "'";

            using (SqlDataAdapter da = new SqlDataAdapter(query, objConn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    ((Label)DetailsView1.FindControl("lblApprovalCode")).Text = "Found in Dispute";
                }
                else
                    ((Label)DetailsView1.FindControl("lblApprovalCode")).Text = "";
            }
        }

    }

   

    protected void txtNPSBCode_TextChanged(object sender, EventArgs e)
    {
        using (SqlConnection objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString))
        {
            string query = "SELECT * FROM dbo.Dispute WHERE NPSBCode='" + ((TextBox)DetailsView1.FindControl("txtNPSBCode")).Text + "' and id<>'" + HidDisputeID.Value + "'";

            using (SqlDataAdapter da = new SqlDataAdapter(query, objConn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    ((Label)DetailsView1.FindControl("lblNPSBCode")).Text = "Found in Dispute";
                }
                else
                    ((Label)DetailsView1.FindControl("lblNPSBCode")).Text = "";
            }
        }

    }

    protected void txtAccNo_TextChanged(object sender, EventArgs e)
    {

        SqlCommand cmd = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();
       
            using (SqlConnection objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString))
            {
                string acc = ((TextBox)DetailsView1.FindControl("txtAccNo")).Text;

                cmd = new SqlCommand("s_Flora_Account_Info", objConn);
                cmd.Parameters.Add(new SqlParameter("@Account", acc));
                cmd.CommandType = CommandType.StoredProcedure;
                da.SelectCommand = cmd;
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    ((Label)DetailsView1.FindControl("lblAcc")).Text = dt.Rows[0]["acname"].ToString();
                    ((TextBox)DetailsView1.FindControl("txtCustomerName")).Text = dt.Rows[0]["acname"].ToString();
                }
                else
                    ((Label)DetailsView1.FindControl("lblAcc")).Text = "";
            }
        

    }

    protected void cmdDeleteAttachment_Click(object sender, EventArgs e)
    {
        string AttachmentID = ((LinkButton)(sender)).CommandArgument;

        //if (UserControl1.isRole("USER", "ADMIN"))    //ADMIN or SUPERVISER
        {
            SqlConnection objConn = null;
            SqlCommand objCom = null;
            bool Done = false;
            string Msg = " ";


            try
            {
                //string Q = "DELETE FROM Attachments WHERE AID = " + AttachmentID + " AND DEPTID = " + Session["DEPTID"] + " AND BranchID = " + Session["BRANCHID"];
                objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString);
                string Client_IP_Address = string.Empty;
                try
                {
                    Client_IP_Address = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
                }
                catch (Exception)
                {
                    try
                    {
                        Client_IP_Address = HttpContext.Current.Request.UserHostAddress;
                    }
                    catch (Exception)
                    {
                        Client_IP_Address = Request.ServerVariables["LOCAL_ADDR"].ToString();
                    }
                }
                objCom = new SqlCommand("s_Attachments_Delete", objConn);
                objCom.CommandType = CommandType.StoredProcedure;
                objCom.Parameters.AddWithValue("@AID", AttachmentID);
                objCom.Parameters.AddWithValue("@DeletedBy", Session["EMPID"]);
                objCom.Parameters.AddWithValue("@DeletedFrom", Client_IP_Address);
                //objCom = new SqlCommand(Q, objConn);                

                SqlParameter S_Done = new SqlParameter("@Done", SqlDbType.Bit);
                S_Done.Value = Done;
                S_Done.Direction = ParameterDirection.InputOutput;
                objCom.Parameters.Add(S_Done);

                SqlParameter S_Msg = new SqlParameter("@Msg", SqlDbType.VarChar);
                S_Msg.Value = Msg;
                S_Msg.Direction = ParameterDirection.InputOutput;
                S_Msg.Size = 255;
                objCom.Parameters.Add(S_Msg);

                objConn.Open();
                int i = objCom.ExecuteNonQuery();

                Done = (bool)S_Done.Value;
                Msg = string.Format("{0}", S_Msg.Value);

                objConn.Close();
                if (Done)
                {
                    //GridView1.DataBind();
                    TrustControl1.ClientMsg(Msg);
                    DataList1.DataBind();
                }
                else
                {
                    TrustControl1.ClientMsg(Msg);
                }
            }
            catch (Exception ex)
            {
                TrustControl1.ClientMsg("Error: " + ex.Message);
            }
        }
    }


    public string FileSize(object val)
    {
        float SizeVal = (float.Parse(val.ToString()));
        string size = "Unknown Size";
        if (SizeVal > 0)
        {
            if (SizeVal >= 1073741824)
                size = String.Format("{0:##.###}", (SizeVal / 1073741824)) + " GB";
            else if (SizeVal >= 1048576)
                size = String.Format("{0:##.##}", (SizeVal / 1048576)) + " MB";
            else if (SizeVal >= 1024)
                size = String.Format("{0:##}", (SizeVal / 1024)) + " KB";
            else
                size = String.Format("{0:##}", (SizeVal)) + " Bytes";
        }
        return size;
    }
    protected void cmdAddAttach_Click(object sender, EventArgs e)
    {
        lblUploadStatus.Text = "Select PDF or JPEG file to upload. (max " + MaxFileSizePerPageKB + " KB per page)";
        modalUpload.Show();
    }
    protected void cmdUpload_Click(object sender, EventArgs e)
    {
        //lblUploadStatus.Text = lblUploadStatus.ClientID;
        //modalUpload.Show();
        //return;
        lblUploadStatus.Text = "";

        try
        {
            bool test = File.Exists(Path.Combine(UploadPath, HidPageID.Value));
        }
        catch (Exception ex)
        {
            lblUploadStatus.Text = ex.Message;
            modalUpload.Show();
        }

        {
            try
            {
                string FileName = HidFileName.Value.Trim();
                string Extension = FileName.Substring(FileName.Trim().Length - 4, 4).ToUpper().Replace(".", "");
                switch (Extension)
                {
                    case "JPG":
                    //case "JPEG":
                    //case "GIF":
                    //case "DOC":
                    //case "XSL":
                    //case "PPT":
                    case "PDF":
                        if (InsertData(ReadFile(Path.Combine(UploadPath, HidPageID.Value)), true, FileName, Extension))
                        {
                            //GridView1.DataBind();
                            TrustControl1.ClientMsg("<b>" + FileName + "</b> is successfully attached.");
                            DataList1.DataBind();
                        }
                        break;
                    default:
                        //lblUploadStatus.Text = "Only DOC, XLS, PPT, JPG, GIF and PDF files can be Attached.";                        
                        lblUploadStatus.Text = "Only PDF or JPEG files can be Attached.";
                        modalUpload.Show();
                        //ClientScript.RegisterClientScriptBlock(GetType(), "alertMsg", "<script>alert('File type error.');</script>"); break;
                        break;
                }
            }
            catch (Exception ex)
            {
                lblUploadStatus.Text = ex.Message;
                modalUpload.Show();
            }
            //FileUpload1.PostedFile.FileName
            //lblUploadStatus.Text = FileUpload1.PostedFile.FileName.ToString();
        }
        //else
        //{
        //    lblUploadStatus.Text = "No file found. Please select file to upload.";
        //    modalUpload.Show();
        //}
    }
    protected void FileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        //if (FileUpload1.FileBytes.Length > (300 * 1024))
        //{
        //    throw new Exception("Invalid File Size");
        //}
        FileUpload1.SaveAs(Path.Combine(UploadPath, HidPageID.Value));
        FileInfo FI = new FileInfo(Path.Combine(UploadPath, HidPageID.Value));
        FI.CreationTime = DateTime.Now;
    }
    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

    }
    private bool InsertData(byte[] content, bool IsInsertNew, string FileName, string Extension)
    {
        bool RetVal = true;

        if (Extension == "JPG")
        {
            if (content.Length > MaxFileSizePerPageKB * 1024)
            {
                TrustControl1.ClientMsg(string.Format("JPG file size must be less than {0} kb", MaxFileSizePerPageKB));
                modalUpload.Show();
                return false;
            }
        }
        else if (Extension == "PDF")
        {
            using (Stream str = new MemoryStream(content))
            {
                using (Ghostscript.NET.Rasterizer.GhostscriptRasterizer _rasterizer = new Ghostscript.NET.Rasterizer.GhostscriptRasterizer())
                {
                    _rasterizer.Open(str,
                            GhostscriptVersionInfo.GetLastInstalledVersion(GhostscriptLicense.GPL | GhostscriptLicense.AFPL, GhostscriptLicense.GPL),
                            true);
                    if (content.Length > MaxFileSizePerPageKB * 1024 * _rasterizer.PageCount)
                    {
                        TrustControl1.ClientMsg(string.Format("Each page of PDF file size must be less than {0} kb", MaxFileSizePerPageKB));
                        modalUpload.Show();
                        RetVal = false;
                    }
                }
            }
        }

        if (!RetVal) return RetVal;

        byte[] _content = Common.Compress(content);

        SqlConnection objConn = null;
        SqlCommand objCom = null;
        try
        {
            objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString);
            objCom = new SqlCommand("s_Attachments_Add", objConn);
            objCom.CommandType = CommandType.StoredProcedure;


            objCom.Parameters.Add("@InsertBy", SqlDbType.VarChar).Value = Session["EMPID"];
            objCom.Parameters.Add("@Attachment", SqlDbType.Image).Value = _content;
            objCom.Parameters.Add("@FileName", SqlDbType.VarChar).Value = FileName;
            objCom.Parameters.Add("@Extension", SqlDbType.VarChar).Value = Extension;
            objCom.Parameters.Add("@FileSize", SqlDbType.Int).Value = content.Length;
            objCom.Parameters.Add("@SessionID", SqlDbType.VarChar).Value = HidPageID.Value;


            objConn.Open();
            int i = objCom.ExecuteNonQuery();
            objConn.Close();

            File.Delete(Path.Combine(UploadPath, HidPageID.Value));
            DeleteAllUploadedFiles();

            return true;

            //lblUploadStatus.Text = "File Uploadted and Saved as: <a href=\"Attachment.aspx?a="+ i.ToString() +"\">" + i.ToString() + "." + Extension + "</a>";
        }
        catch (Exception ex)
        {
            TrustControl1.ClientMsg("Error: " + ex.Message);
        }
        //finally
        //{
        //    //objConn.Close();
        //}

        return false;
    }
    private void DeleteAllUploadedFiles()
    {
        string[] UploadFiles = Directory.GetFiles(UploadPath);
        foreach (string uf in UploadFiles)
        {
            FileInfo FI = new FileInfo(uf);
            if (FI.CreationTime.AddHours(6) < DateTime.Now)
                try
                {
                    FI.Delete();
                }
                catch (Exception) { }
        }
    }
    public string[] getExtensionImage(string Extension, string AID, string FileKey)
    {
        string Pre = "Images/ext/";
        string[] RetVal = new string[12];
        RetVal[(int)FileDetails.Img] = Pre + "attach.gif";
        RetVal[(int)FileDetails.Width] = "16px";
        RetVal[(int)FileDetails.CSS] = "noborder";
        RetVal[(int)FileDetails.LoadImg] = "";
        RetVal[(int)FileDetails.ACSS] = "";
        RetVal[(int)FileDetails.Preview] = "";
        RetVal[(int)FileDetails.View] = "";
        RetVal[(int)FileDetails.LightBox] = "";

        switch (Extension.ToUpper().Trim())
        {
            case "DOC":
            case "DOCX":
                RetVal[(int)FileDetails.Img] = Pre + "doc.gif";
                break;
            case "XLS":
            case "XLSX":
            case "XLSM":
            case "XLT":
            case "XLTX":
                RetVal[(int)FileDetails.Img] = Pre + "xls.gif";
                break;
            case "PPT":
            case "PPTX":
            case "PPTM":
            case "POTX":
            case "POTM":
            case "PPS":
            case "PPSX":
                RetVal[(int)FileDetails.Img] = Pre + "ppt.gif";
                break;
            case "ZIP":
            case "RAR":
            case "TAR":
            case "7ZIP":
                RetVal[(int)FileDetails.Img] = Pre + "zip.gif";
                break;
            case "TXT":
            case "INI":
            case "BAT":
                RetVal[(int)FileDetails.Img] = Pre + "txt.gif";
                RetVal[(int)FileDetails.View] = string.Format("Attachment.ashx?aid={0}&key={1}&view=yes", AID, FileKey);
                break;
            case "PDF":
                //RetVal[0] = Pre + "pdf.gif";
                //RetVal[1] = "50px";
                //break;
                RetVal[(int)FileDetails.Img] = "Images/loading.gif";
                RetVal[(int)FileDetails.Width] = "80px";
                RetVal[(int)FileDetails.CSS] = "AttachmentThumb";
                RetVal[(int)FileDetails.LoadImg] = string.Format("ShowImage.ashx?aid={0}&key={1}&W=160&P=1", AID, FileKey);
                RetVal[(int)FileDetails.ACSS] = "lightbox";
                RetVal[(int)FileDetails.View] = string.Format("Attachment.ashx?aid={0}&key={1}&view=yes", AID, FileKey);
                RetVal[(int)FileDetails.Preview] = string.Format("Pdf.aspx?aid={0}&key={1}", AID, FileKey);
                RetVal[(int)FileDetails.LightBox] = string.Format("ShowImage.ashx?aid={0}&key={1}&P=1&Z=1", AID, FileKey);
                break;
            case "JPG":
            case "JPEG":
            case "GIF":
            case "PNG":
            case "BMP":
                RetVal[(int)FileDetails.Img] = "Images/loading.gif";
                RetVal[(int)FileDetails.Width] = "80px";
                RetVal[(int)FileDetails.CSS] = "AttachmentThumb";
                RetVal[(int)FileDetails.LoadImg] = string.Format("ShowImage.ashx?aid={0}&key={1}&W=160&H=200&R=1", AID, FileKey);
                RetVal[(int)FileDetails.ACSS] = "lightbox";
                RetVal[(int)FileDetails.View] = string.Format("Attachment.ashx?aid={0}&key={1}&view=yes", AID, FileKey);
                RetVal[(int)FileDetails.LightBox] = string.Format("ShowImage.ashx?aid={0}&key={1}&Z=0&R=1", AID, FileKey);
                break;
            default:
                RetVal[(int)FileDetails.Img] = Pre + "attach.gif";
                break;
        }
        return RetVal;
    }
    protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
            divdischanghistory.Visible = true;
        else
            divdischanghistory.Visible = false;

    }
     protected void SqlDataSourceComments_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        DT = new DataSetAttachmentDispute.s_Attachments_DisputeDataTable();
        DataSetAttachmentDisputeTableAdapters.s_Attachments_DisputeTableAdapter da
            = new DataSetAttachmentDisputeTableAdapters.s_Attachments_DisputeTableAdapter();
        da.ClearBeforeFill = true;
        //da.Fill(DT, Request.QueryString["id"].ToString());        
        da.Fill(DT, HidDisputeID.Value);

        ((Button)DetailsView1.FindControl("cmdEdit")).Visible = true;
        //TrustControl1.ClientMsg(LastStatus);
        if (e.AffectedRows > 0)
        {
            //string dd = Session["BranchID"].ToString();
            if (Session["BranchID"].ToString() != "1")
                ((Button)DetailsView1.FindControl("cmdEdit")).Visible = false;
            if (LastStatus != "Close" && Session["BranchID"].ToString() == "1")
                ((Button)DetailsView1.FindControl("cmdEdit")).Visible = true;
            if (LastStatus == "Close")
                ((Button)DetailsView1.FindControl("cmdEdit")).Visible = false;
        }

    }
    protected void grdvComment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string CID = DataBinder.Eval(e.Row.DataItem, "CID").ToString();
            StringBuilder sb = new StringBuilder();

            DataSetAttachmentDispute.s_Attachments_DisputeRow[] oRows;
            oRows = (DataSetAttachmentDispute.s_Attachments_DisputeRow[])
                DT.DefaultView.Table.Select("CID=" + CID.ToString());

            if (oRows.Length > 0)
            {
                sb.Append("<div class='filediv'><table class='noborder'>");
                for (int r = 0; r < oRows.Length; r++)
                {
                    string[] ssss = getExtensionImage(
                            string.Format("{0}", oRows[r].Extension),
                            oRows[r].AID.ToString(),
                            oRows[r].FileId.ToLower()
                        );

                    sb.Append("<tr class='hoverTr'>");

                    sb.Append("<td align='right' class='extlogotd' >");

                    if (ssss[(int)FileDetails.LightBox].Length == 0)
                    {
                        sb.Append("<img title='AID:" + oRows[r].AID + "' src='" + ssss[(int)FileDetails.Img] + "' width='" + ssss[(int)FileDetails.Width] + "' class='noborder' />");
                    }
                    else
                    {
                        //sb.Append("<a target='_blank' class='" + ssss[(int)FileDetails.ACSS] + "' href='" + ssss[(int)FileDetails.LightBox] + "'>");
                        sb.Append("<a target='_blank' class='link' href='" + ssss[(int)FileDetails.View] + "'>");
                        sb.Append("<img title='AID:" + oRows[r].AID + "' loadimg=\"" + ssss[(int)FileDetails.LoadImg] + "\" src='" + ssss[(int)FileDetails.Img] + "' width='" + ssss[(int)FileDetails.Width] + "' class='AttachmentThumb' onerror=\"this.src='Images/Error.jpg'\" />");
                        sb.Append("</a>");
                    }

                    sb.Append("</td>");

                    sb.Append("<td class='extlogotd'>");
                    sb.Append("<b>" + oRows[r].FileName + "</b><br /><span class='filesize'>" + TrustControl1.FileSize(oRows[r].FileSize) + "</span>&nbsp;&nbsp;&nbsp;<a target='_blank' href='Attachment.ashx?aid=" + oRows[r].AID + "&key=" + oRows[r].FileId.ToLower() + "'>Download</a>");

                    if (ssss[(int)FileDetails.View].Length > 0)
                        sb.Append("&nbsp;&nbsp;<a target='_blank' href='" + ssss[(int)FileDetails.View] + "' class='link'>View</a>");

                    if (ssss[(int)FileDetails.Preview].Length > 0)
                        sb.Append("<div style='margin:10px'><a target='_blank' href='Pdf.aspx?aid=" + oRows[r].AID.ToString() + "&key=" + oRows[r].FileId.ToLower() + "' title='Preview' class='link'><img src='Images/new_window.png' border='0'></a></div></td>");
                    sb.Append("</tr>");
                }
                sb.Append("</table></div>");
                ((Literal)(e.Row.FindControl("litAttach"))).Text = sb.ToString();
            }
        }
    }
    enum FileDetails
    {
        Img, AID, Name, Size, FileKey, LoadImg, Width, CSS, ACSS, Preview, View, LightBox
    }
    public string getLinkImage(object AID, object FileKey, object Extension)
    {
        string RetVal = "";
        RetVal = "ShowImage.ashx?aid=" + AID.ToString() + "&key=" + FileKey.ToString() + "&w=60&p=1";
        return RetVal;
    }

    protected byte[] ReadFile(string filePath)
    {
        byte[] buffer;
        FileStream fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
        try
        {
            int length = (int)fileStream.Length;  // get file length
            buffer = new byte[length];            // create buffer
            int count;                            // actual number of bytes read
            int sum = 0;                          // total number of bytes read

            // read until Read method returns 0 (end of the stream has been reached)
            while ((count = fileStream.Read(buffer, sum, length - sum)) > 0)
                sum += count;  // sum is a buffer offset for next reading
        }
        finally
        {
            fileStream.Close();
        }
        return buffer;
    }

    protected void SqlDataSourceDispute_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {

        HidDisputeID.Value = string.Format("{0}", e.Command.Parameters["@ID"].Value);
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);
        //if(bit=="True")
        TrustControl1.ClientMsg(msg);

        //DetailsView1.DataBind();
        DetailsView1.DefaultMode = DetailsViewMode.ReadOnly;
        GridView1.DataBind();
        GridView3.DataBind();
    }
    protected void SqlDataSourceDispute_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        //string done = e.Command.Parameters["@Done"].Value.ToString();
        string msg = e.Command.Parameters["@Msg"].Value.ToString();
        //if (done == "True")
            TrustControl1.ClientMsg(msg);
        //else
        //    TrustControl1.ClientMsg(msg);
        GridView1.DataBind();
        GridView3.DataBind();
    }
    protected void SqlDataSourceDispute_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {

    }
    protected void SqlDataSourceDispute_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            panelVisible.Visible = true;
            divdischanghistory.Visible = true;
            divFlora.Visible = true;
            div1.Visible = true;
        }
        else
        {
            panelVisible.Visible = false;
            divdischanghistory.Visible = false;
            divFlora.Visible = false;
            div1.Visible = false;
        }
    }
    //protected void btnGenerateLetter_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("DisputeLetterPrint.aspx?DisputeID="+HidDisputeID.Value.ToString());
    //}
    protected void btnPostReply_Click(object sender, EventArgs e)
    {
        string Msg = "";
        bool done = false;

        using (SqlConnection conn = new SqlConnection())
        {
            if (Session["BranchID"].ToString() != "1" && string.IsNullOrEmpty(txtCommentDtl.Text.Trim()))
            {
                TrustControl1.ClientMsg("Comments Required.");
            }
            else
            {
                string Query = "s_Dispute_Comment_Insert";

                conn.ConnectionString = System.Configuration.ConfigurationManager
                                .ConnectionStrings["CardDataConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(Query, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@DisputeID", System.Data.SqlDbType.VarChar).Value = HidDisputeID.Value;
                    cmd.Parameters.Add("@ApplicationSource", System.Data.SqlDbType.NVarChar).Value = null;
                    cmd.Parameters.Add("@Remarks", System.Data.SqlDbType.VarChar).Value = txtCommentDtl.Text.Trim();
                    cmd.Parameters.Add("@Status", System.Data.SqlDbType.Int).Value = ddlStatusType.SelectedValue;
                    cmd.Parameters.Add("@AttachmentID", System.Data.SqlDbType.Int).Value = null;
                    cmd.Parameters.Add("@CommentBy", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();
                    cmd.Parameters.Add("@BranchID", System.Data.SqlDbType.VarChar).Value = Session["BRANCHID"].ToString();
                    cmd.Parameters.Add("@SessionID", System.Data.SqlDbType.VarChar).Value = HidPageID.Value;


                    SqlParameter SQL_Msg = new SqlParameter("@Msg", SqlDbType.VarChar, 255);
                    SQL_Msg.Direction = ParameterDirection.InputOutput;
                    SQL_Msg.Value = Msg;
                    cmd.Parameters.Add(SQL_Msg);

                    SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    SQL_Done.Direction = ParameterDirection.InputOutput;
                    SQL_Done.Value = done;
                    cmd.Parameters.Add(SQL_Done);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();

                    done = (bool)SQL_Done.Value;
                    Msg = string.Format("{0}", SQL_Msg.Value);

                    txtCommentDtl.Text = "";
                    DataList1.DataBind();
                }
            }

            if (done)
            {
                TrustControl1.ClientMsg(Msg);
                grdvComment.DataBind();
                DetailsView1.DataBind();

                //Response.Redirect("Ticket.aspx?id=" + txtTicketID.Text.Trim(), true);

            }
            else
            {
                TrustControl1.ClientMsg("Insert Failed.");

            }

        }
    }



    protected void DetailsView1_DataBound(object sender, EventArgs e)
    {
        try
        {
            if (DetailsView1.CurrentMode == DetailsViewMode.Insert && Session["BranchID"].ToString() != "1")
            {
                ((TextBox)DetailsView1.FindControl("txtTerminalID")).Enabled = false;
                ((TextBox)DetailsView1.FindControl("txtTraceNo")).Enabled = false;
                ((TextBox)DetailsView1.FindControl("txtApprovalCode")).Enabled = false;
                ((TextBox)DetailsView1.FindControl("txtNPSBCode")).Enabled = false;
            }
            if (TrustControl1.isRole("GUEST"))
            {
                ((Button)DetailsView1.FindControl("cmdEdit")).Enabled = false;
                btnPostReply.Enabled = false;
                cmdAddAttach.Enabled = false;
                txtCommentDtl.Enabled = false;
            }
            else
            {
                ((Button)DetailsView1.FindControl("cmdEdit")).Enabled = true;
                btnPostReply.Enabled = true;
                cmdAddAttach.Enabled = true;
                txtCommentDtl.Enabled = true;
            }
            if (DetailsView1.CurrentMode == DetailsViewMode.Edit)
            {

                string Type = DataBinder.Eval(DetailsView1.DataItem, "type").ToString();
                if (Type == "POS")
                {
                    ((DropDownList)DetailsView1.FindControl("cboBanks")).Enabled = false;
                    ((DropDownList)DetailsView1.FindControl("cboBanks")).SelectedIndex = 0;
                    ((TextBox)DetailsView1.FindControl("txtTerminalID")).Enabled = false;
                }
                else if (Type == "ATM")
                {
                    ((DropDownList)DetailsView1.FindControl("cboBanks")).Enabled = true;
                    ((TextBox)DetailsView1.FindControl("txtTerminalID")).Enabled = true;
                }
                if (Session["BranchID"].ToString() == "1")
                {
                    ((DropDownList)DetailsView1.FindControl("cboBanks")).Enabled = true;
                    ((TextBox)DetailsView1.FindControl("txtTerminalID")).Enabled = true;
                }

                
            }
            LastStatus = ((Label)DetailsView1.FindControl("lblStatusName")).Text.Trim().ToString();

            bool Authorize =(bool)DataBinder.Eval(DetailsView1.DataItem, "Authorize");
            bool Approve = (bool)DataBinder.Eval(DetailsView1.DataItem, "Approve");

            if(Session["BRANCHID"].ToString()!="1")
                ((Button)DetailsView1.FindControl("cmdEdit")).Enabled = !Authorize;
            if (Session["BRANCHID"].ToString() == "1")
                ((Button)DetailsView1.FindControl("cmdEdit")).Enabled = !Approve;
        }
        catch (Exception) { }

            
        
    }
}
