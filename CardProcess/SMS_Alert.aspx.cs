using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using Ghostscript.NET;

public partial class SMS_Alert : System.Web.UI.Page
{
    string ReqID = "";
    string CardType = "";
    string Msg = "";
    bool Done = false;
    int MaxFileSizePerPageKB;
    string UploadPath;


    protected void Page_Load(object sender, EventArgs e)
    {
        TrustControl1.getUserRoles();
        MaxFileSizePerPageKB = int.Parse(TrustControl1.getValueOfKey("MaxFileSizePerPageKB"));
        UploadPath = Server.MapPath("Upload");

        //TrustControl1.ClientMsg(Request.QueryString["id"]);
        if (!IsPostBack)
        {
            ChangeSessionData();
            txtFilter.Focus();
            ReqID = string.Format("{0}", Request.QueryString["id"]);
            HidRefID.Value = ReqID;
            if (ReqID.Length == 0)
            {
                DetailsViewMaster.Visible = false;
                //panel3.Visible = false;                
                Title = "SMS Service Request";
                GridView1.Visible = false;
            }
            else
            {
                Title = string.Format("#{0} - SMS Service Request", ReqID);
                hidReqID.Value = ReqID;
                DetailsViewMaster.DefaultMode = DetailsViewMode.ReadOnly;
                GridView1.Visible = false;
                Panel1.Visible = false;
                DetailsViewAddAccount.DataBind();
                grdvAddAccount.DataBind();
            }
        }     
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
    protected void cmdUpload_Click(object sender, EventArgs e)
    {
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
        }       
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
            objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["AttachmentsConnectionString"].ConnectionString);
            objCom = new SqlCommand("s_Attachments_ExtendedServices_Add", objConn);
            objCom.CommandType = CommandType.StoredProcedure;


            objCom.Parameters.Add("@InsertBy", SqlDbType.VarChar).Value = Session["EMPID"];
            objCom.Parameters.Add("@Attachment", SqlDbType.Image).Value = _content;
            objCom.Parameters.Add("@FileName", SqlDbType.VarChar).Value = FileName;
            objCom.Parameters.Add("@Extension", SqlDbType.VarChar).Value = Extension;
            objCom.Parameters.Add("@FileSize", SqlDbType.Int).Value = content.Length;
            objCom.Parameters.Add("@CID", SqlDbType.VarChar).Value = HidRefID.Value;


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
    protected void FileUpload1_UploadedFileError(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {

    }
    protected void FileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {        
        FileUpload1.SaveAs(Path.Combine(UploadPath, HidPageID.Value));
        FileInfo FI = new FileInfo(Path.Combine(UploadPath, HidPageID.Value));
        FI.CreationTime = DateTime.Now;
    }

    protected void SqlDataSourceAlertType_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {

        if (e.AffectedRows > 0)
        {
           // DetailsViewAlertType.ChangeMode(DetailsViewMode.Insert);
           // panel3.Visible = true;
        }
        else
        {
            //panel3.Visible = false;
            Response.Redirect("SMS_Alert.aspx",true);
        }
    }
    protected void SqlDataSourceMaster_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        string Types = "";
        CheckBoxList CBL = ((CheckBoxList)(DetailsViewMaster.FindControl("chkSMS")));
        foreach (ListItem L in CBL.Items)
            if (L.Selected)
                Types += L.Value + ",";
        if (Types.EndsWith(","))
            Types = Types.Substring(0, Types.Length - 1);
        e.Command.Parameters["@SMSAlertTypes"].Value = Types;
    }

    protected void SqlDataSourceAlertType_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView1.DataBind();
        //GridView2.DataBind();
        TrustControl1.ClientMsg("Successfully Inserted.");
        //RefreshForm();

        //LoadApps(hidAppID.Value, hidAppName.Value);
    }

    protected void SqlDataSourceAlertType_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView1.DataBind();
        //GridView2.DataBind();
        TrustControl1.ClientMsg("Successfully Updated.");
        //RefreshForm();

        //LoadApps(hidAppID.Value, hidAppName.Value);
    }

    protected void SqlDataSourceMaster_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        string Types = "";
        CheckBoxList CBL = ((CheckBoxList)(DetailsViewMaster.FindControl("chkSMS")));
        foreach (ListItem L in CBL.Items)
            if (L.Selected)
                Types += L.Value + ",";
        if (Types.EndsWith(","))
            Types = Types.Substring(0, Types.Length - 1);
        e.Command.Parameters["@SMSAlertTypes"].Value = Types;
    }
    protected void txtAccNo_TextChanged(object sender, EventArgs e)
    {

        SqlCommand cmd = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();

        using (SqlConnection objConn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CardDataConnectionString"].ConnectionString))
        {
            string acc = ((TextBox)DetailsViewAddAccount.FindControl("txtAccNo")).Text;

            cmd = new SqlCommand("s_Flora_Account_Info", objConn);
            cmd.Parameters.Add(new SqlParameter("@Account", acc));
            cmd.CommandType = CommandType.StoredProcedure;
            da.SelectCommand = cmd;
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ((Label)DetailsViewAddAccount.FindControl("lblAccount")).Text = dt.Rows[0]["acname"].ToString();
                //((TextBox)DetailsViewAddAccount.FindControl("txtCustomerName")).Text = dt.Rows[0]["acname"].ToString();
            }
            else
                ((Label)DetailsViewAddAccount.FindControl("lblAccount")).Text = "";
        }


    }

    protected void DetailsViewAddAccount_DataBound1(object sender, EventArgs e)
    {
        if (DetailsViewAddAccount.CurrentMode == DetailsViewMode.Edit)
        {
            try
            {
                string[] AlertTypes = ((HiddenField)(DetailsViewAddAccount.FindControl("HidSMSTypes"))).Value.Split(",".ToCharArray());
                CheckBoxList CBL = ((CheckBoxList)(DetailsViewAddAccount.FindControl("chkSMS")));
                foreach (ListItem L in CBL.Items)
                    foreach (string Type in AlertTypes)
                        if (Type.ToLower().Trim() == L.Value.ToLower().Trim())
                            L.Selected = true;
            }
            catch (Exception) { }
        }
    }
    protected void txtFilter_TextChanged(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        
    {        
        DetailsViewMaster.Visible = true;

        //((Label)DetailsViewMaster.FindControl("lblCardNumber")).Text = GridView1.SelectedRow.Cells[2].Text.ToString().Replace("&nbsp;", "").Trim();
        ((Label)DetailsViewMaster.FindControl("lblAccount")).Text = GridView1.SelectedRow.Cells[1].Text.ToString().Replace("&nbsp;", "").Trim();        
        ((TextBox)DetailsViewMaster.FindControl("txtName")).Text = GridView1.SelectedRow.Cells[2].Text.ToString().Replace("&nbsp;", "").Trim();
        //((Label)DetailsViewMaster.FindControl("lblITCLID")).Text = GridView1.SelectedRow.Cells[10].Text.ToString().Replace("&nbsp;", "").Trim();
        ((TextBox)DetailsViewMaster.FindControl("txtDOB")).Text = GridView1.SelectedRow.Cells[5].Text.ToString().Replace("&nbsp;", "").Trim();
        ((TextBox)DetailsViewMaster.FindControl("txtAddress")).Text = GridView1.SelectedRow.Cells[6].Text.ToString().Replace("&nbsp;", "").Trim();
        ((TextBox)DetailsViewMaster.FindControl("txtEmail")).Text = "";// GridView1.SelectedRow.Cells[6].Text.ToString().Replace("&nbsp;", "").Trim();
        ((TextBox)DetailsViewMaster.FindControl("txtMobile")).Text = GridView1.SelectedRow.Cells[7].Text.ToString().Replace("&nbsp;", "").Trim();
        ((TextBox)DetailsViewMaster.FindControl("txtAddress")).Text = GridView1.SelectedRow.Cells[6].Text.ToString().Replace("&nbsp;", "").Trim();
        ((TextBox)DetailsViewMaster.FindControl("txtMotherName")).Text = GridView1.SelectedRow.Cells[4].Text.ToString().Replace("&nbsp;", "").Trim();
    }
   
    protected void SqlDataSourceMaster_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        ReqID = string.Format("{0}", e.Command.Parameters["@ReqID"].Value);
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);
        if (ReqID == "-1")
        {
            TrustControl1.ClientMsg(msg);
        }
        else
        {
            TrustControl1.ClientMsg(msg);
            Response.Redirect("SMS_Alert.aspx?id=" + ReqID, true);
        }
       
    }

    protected void SqlDataSourceMaster_OnDeleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);
        TrustControl1.ClientMsg(msg);
        
    }

    protected void SqlDataSourceMaster_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        //hidReqID.Value = string.Format("{0}", e.Command.Parameters["@ReqID"].Value);
        DetailsViewMaster.ChangeMode(DetailsViewMode.ReadOnly);
        DetailsViewMaster.DefaultMode = DetailsViewMode.ReadOnly;
        GridView1.Visible = false;
        string msg = string.Format("{0}", e.Command.Parameters["@msg"].Value);
        TrustControl1.ClientMsg(msg);
    }
    protected void cmdOK_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
        GridView1.Visible = true;
        DetailsViewMaster.Visible = false;
    }
   
    
   
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        GridView1.SelectedIndex = -1;
    }


    public bool getIsEditable() { return true; }
    protected void SqlDataSourceAddAccount_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        Done = (bool)e.Command.Parameters["@Done"].Value;
        if (Done)
        {
            grdvAddAccount.DataBind();
            TrustControl1.ClientMsg(Msg);
           
        }
    }
    protected void cmdAddAttach_Click(object sender, EventArgs e)
    {
        lblUploadStatus.Text = "Select PDF or JPEG file to upload. (max " + MaxFileSizePerPageKB + " KB per page)";
        modalUpload.Show();
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
    public string getLinkImage(object AID, object FileKey, object Extension)
    {
        string RetVal = "";
        RetVal = "ShowImage.ashx?aid=" + AID.ToString() + "&key=" + FileKey.ToString() + "&w=60&p=1";
        return RetVal;
    }
    protected void SqlDataSourceAddAccount_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
         Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
         Done = (bool)e.Command.Parameters["@Done"].Value;
        //grdvDrCrDetails.DataBind();
        if (Done)
        {
            grdvAddAccount.DataBind();
            TrustControl1.ClientMsg(Msg);
            
        }
    }

    protected void grdvAddAccount_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "DELETE")
        {
            string ID = e.CommandArgument.ToString();

            string Msg = "";
            bool done = false;

            using (SqlConnection conn = new SqlConnection())
            {

                string Query = "s_Auto_Trn_DrCr_Delete";
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {

                    cmd.CommandText = Query;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ID", System.Data.SqlDbType.VarChar).Value = ID;
                    // cmd.Parameters.Add("@Emp", System.Data.SqlDbType.VarChar).Value = Session["EMPID"].ToString();

                    SqlParameter Sql_Msg = new SqlParameter("@Msg", System.Data.SqlDbType.VarChar, 255);
                    Sql_Msg.Direction = System.Data.ParameterDirection.InputOutput;
                    Sql_Msg.Value = Msg;
                    cmd.Parameters.Add(Sql_Msg);

                    SqlParameter SQL_Done = new SqlParameter("@Done", SqlDbType.Bit);
                    SQL_Done.Direction = ParameterDirection.InputOutput;
                    SQL_Done.Value = done;
                    cmd.Parameters.Add(SQL_Done);

                    cmd.Connection = conn;
                    conn.Open();

                    cmd.ExecuteNonQuery();
                    Msg = string.Format("{0}", Sql_Msg.Value);
                }
            }

            TrustControl1.ClientMsg(Msg);
            //grdvDrCrDetails.DataBind();
        }

    }
    protected void SqlDataSourceMaster_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
        {
            panelAddAccount.Visible = true;
            divAttachments.Visible = true;
        }
        else
        {
            panelAddAccount.Visible = false;
            divAttachments.Visible = false;
            Response.Redirect("SMS_Alert.aspx", true);
        }
    }
    protected void cmdNew_Click(object sender, EventArgs e)
    {
       // DetailsViewAddAccount.ChangeMode(DetailsViewMode.Insert);
    }
    protected void SqlDataSourceComments_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //if (e.AffectedRows > 0)
        //    DetailsView1.DefaultMode = DetailsViewMode.ReadOnly;
        //else
        //    DetailsView1.DefaultMode = DetailsViewMode.Insert;

    }


    protected void SqlDataSourceComments_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {

        ////DetailsView1.DataBind();
        //string Msg = string.Format("{0}", e.Command.Parameters["@Msg"].Value);
        //bool done = (bool)e.Command.Parameters["@Done"].Value;
       
        //    DetailsView1.Visible = false;
       
        //TrustControl1.ClientMsg(Msg);
        //DetailsViewMaster.DataBind();
    }

    protected void DetailsView1_DataBound(object sender, EventArgs e)
    {
        //    try
        //    {
        //        string Status = DataBinder.Eval(DetailsView1.DataItem, "Status").ToString();
        //        if (Status == "2" || Status=="3") //Completed or Reject
        //        {
        //            DetailsView1.DefaultMode = DetailsViewMode.ReadOnly;
        //        }
        //        else
        //            DetailsView1.DefaultMode = DetailsViewMode.Edit;

        //    }
        //    catch (Exception exx) {
        //        DetailsView1.DefaultMode = DetailsViewMode.Edit;
        //    }
        //}
    }

    protected void SqlDataSourceAddAccount_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        string Types = "";
        CheckBoxList CBL = ((CheckBoxList)(DetailsViewAddAccount.FindControl("chkSMS")));
        foreach (ListItem L in CBL.Items)
            if (L.Selected)
                Types += L.Value + ",";
        if (Types.EndsWith(","))
            Types = Types.Substring(0, Types.Length - 1);
        e.Command.Parameters["@SMSAlertTypes"].Value = Types;
    }

    protected void SqlDataSourceAddAccount_Updating(object sender, SqlDataSourceCommandEventArgs e)
    {
        string Types = "";
        CheckBoxList CBL = ((CheckBoxList)(DetailsViewAddAccount.FindControl("chkSMS")));
        foreach (ListItem L in CBL.Items)
            if (L.Selected)
                Types += L.Value + ",";
        if (Types.EndsWith(","))
            Types = Types.Substring(0, Types.Length - 1);
        e.Command.Parameters["@SMSAlertTypes"].Value = Types;
    }
}