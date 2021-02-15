<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SMS_Alert.aspx.cs" Inherits="SMS_Alert" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .W1 {
            min-width: 400px;
        }
    </style>
    <script type="text/javascript">
        function AsyncFileUpload1_StartUpload(sender, args) {
            var filename = args.get_fileName();
            var ext = filename.substring(filename.lastIndexOf(".") + 1);

            if (ext.toLowerCase() == 'jpg' || ext.toLowerCase() == 'pdf') {
                $('[tblid=lblUploadStatus]').html("<b>" + args.get_fileName() + "</b> is uploading...");
            }
            else {
                $('[tblid=lblUploadStatus]').html("Only <b>PDF</b> and <b>JPG</b> files can be uploaded.");
                throw {
                    name: "Invalid File Type",
                    level: "Error",
                    message: "",
                    htmlMessage: ""
                }
                return false;
            }
        }

        function UploadError() {
            $('#UploadBtn').hide();
        }

        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var contentType = args.get_contentType();
            var img = '';
            var imgurl = '';
            var text = "Size of " + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += " and content type is '" + contentType + "'.";
            }
            //alert(text);
            if (contentType == "application/pdf") {
                img = "ext/pdf.gif";
            }
            else if (contentType == "image/jpeg") {
                img = "ext/jpg.gif";
            }
            else {
                $('#UploadBtn').hide();
                $('[tblid=lblUploadStatus]').html('Only PDF and JPG files are allowed to upload.');
            }
            if (img != '') imgurl = '<img src="Images/' + img + '"/> ';
            $('#UploadBtn').show('Slow');
            $('[tblid=lblUploadStatus]').html(imgurl + '<b>' + filename + '</b><br>File uploaded successfully. Please click Attach.');
            $('#HidFileName').val(filename);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="SMS Service Request"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hidReqID" runat="server" Value="-1" />
            <asp:HiddenField ID="HidRefID" runat="server" Value="" />
            <asp:HiddenField ID="HidPageID" runat="server" Value="" />
            <asp:HiddenField ID="HidFileName" ClientIDMode="Static" runat="server" Value="" />
            <asp:HiddenField ID="HidUploadTempFile" runat="server" Value="" />
            <asp:Panel ID="Panel1" runat="server">
                <table class="Panel1 ui-corner-all">
                    <tr>
                        <td>
                            <b>Account No.: </b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFilter" runat="server" Width="150px" TabIndex="0"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="cmdOK" runat="server" Text="Search" Width="80px" OnClick="cmdOK_Click"
                                CausesValidation="false" />
                        </td>
                    </tr>
                </table>
                <br />
            </asp:Panel>
            <table>
                <tr>
                    <td>
                        <asp:DetailsView ID="DetailsViewMaster" runat="server" BackColor="White" CssClass="Grid"
                            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black"
                            GridLines="Vertical" DataSourceID="SqlDataSourceMaster" AutoGenerateRows="False"
                            DataKeyNames="ReqID" DefaultMode="Insert">
                            <AlternatingRowStyle BackColor="White" />
                            <Fields>
                                <asp:BoundField DataField="ReqID" HeaderText="Req ID" InsertVisible="False" ReadOnly="True"
                                    SortExpression="ReqID" ItemStyle-Font-Size="150%" ItemStyle-Font-Bold="true" />
                                <asp:TemplateField HeaderText="Account" SortExpression="Account">
                                    <EditItemTemplate>
                                        <asp:Label ID="lblAccount" runat="server" Text='<%# Bind("Account") %>'></asp:Label>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Label ID="lblAccount" runat="server" Text='<%# Bind("Account") %>'></asp:Label>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblAccount" runat="server" Text='<%# Bind("Account") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="true" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Account Name" SortExpression="AccountName">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtName" Width="300px" MaxLength="50" runat="server" ValidationGroup="Part1"
                                            Text='<%# Bind("AccountName") %>'></asp:TextBox>
                                        <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtName"
                                ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$"
                                Display="Dynamic">Invalid</asp:RegularExpressionValidator>--%>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3qwerqw23" runat="server" ControlToValidate="txtName"
                                            ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txtName" MaxLength="50" Width="300px" ValidationGroup="Part1" runat="server"
                                            Text='<%# Bind("AccountName") %>'></asp:TextBox>
                                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtName"
                                ValidationGroup="Part1" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$"
                                Display="Dynamic">Invalid</asp:RegularExpressionValidator>--%>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorqweqwesd3" runat="server" ControlToValidate="txtName"
                                            ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblNamess" Width="300px" runat="server" Text='<%# Bind("AccountName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mother Name" SortExpression="MotherName">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtMotherName" ValidationGroup="Part1" Width="300px" MaxLength="50"
                                            runat="server" Text='<%# Bind("MotherName") %>'></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorasasaww1" runat="server"
                                            ControlToValidate="txtMotherName" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$"
                                            Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3qweqweqweqwe" runat="server"
                                            ControlToValidate="txtMotherName" ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txtMotherName" ValidationGroup="Part1" MaxLength="50" Width="300px"
                                            runat="server" Text='<%# Bind("MotherName") %>'></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatoasar1" runat="server"
                                            ControlToValidate="txtMotherName" ValidationGroup="Part1" ErrorMessage="RegularExpressionValidator"
                                            ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$" Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12312asdd3" runat="server"
                                            ControlToValidate="txtMotherName" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblNameqweq" Width="300px" runat="server" Text='<%# Bind("MotherName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtAddress" ValidationGroup="Part1" Width="400px" runat="server"
                                            Text='<%# Bind("Address") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator334343433" runat="server" ControlToValidate="txtAddress"
                                            ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txtAddress" ValidationGroup="Part1" Width="400px" runat="server"
                                            Text='<%# Bind("Address") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator33324523543" runat="server"
                                            ValidationGroup="Part1" ControlToValidate="txtAddress" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblAddress" Width="400px" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mobile" SortExpression="Mobile">
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" ID="txtMobile" ValidationGroup="Part1" Text='<%# Bind("Mobile") %>'
                                            MaxLength="20" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4dsd" runat="server" ControlToValidate="txtMobile"
                                            ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{6,15}$"
                                            ValidationGroup="Part1" ControlToValidate="txtMobile" ErrorMessage="RegularExpressionValidator">Invalid</asp:RegularExpressionValidator>
                                        Ex: 8801740577398(13 digit with 880)
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtMobile" ValidationGroup="Part1" Text='<%# Bind("Mobile") %>'
                                            MaxLength="20" Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4wewq" runat="server" ControlToValidate="txtMobile"
                                            ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{6,15}$"
                                            ControlToValidate="txtMobile" ValidationGroup="Part1" ErrorMessage="RegularExpressionValidator" ForeColor="Red">Invalid</asp:RegularExpressionValidator>
                                        Ex: 8801740577398(13 digit with 880)
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblMobile" runat="server" Text='<%# Bind("Mobile") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email" SortExpression="Email">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmail" ValidationGroup="Part1" runat="server" Text='<%# Bind("Email") %>'
                                            MaxLength="40" Width="400px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" runat="server"
                                            ControlToValidate="txtEmail" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txtEmail" ValidationGroup="Part1" runat="server" Text='<%# Bind("Email") %>'
                                            MaxLength="40" Width="400px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" runat="server"
                                            ControlToValidate="txtEmail" ErrorMessage="Invalid Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date of Birth" SortExpression="DOB">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDOB" ValidationGroup="Part1" CssClass="Date" runat="server" Text='<%# Bind("DOB","{0:dd/MM/yyyy}") %>'
                                            MaxLength="80" Width="85px"></asp:TextBox>
                                        dd/mm/yyyy
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3343" runat="server" ControlToValidate="txtDOB"
                                ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txtDOB" ValidationGroup="Part1" CssClass="Date" runat="server" Text='<%# Bind("DOB","{0:dd/MM/yyyy}") %>'
                                            MaxLength="80" Width="85px"></asp:TextBox>
                                        dd/mm/yyyy
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3s343" runat="server" ControlToValidate="txtDOB"
                                ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("DOB","{0:dd/MM/yyyy}") %>
                                        <span class="time-small" style="margin-left: 20px" title="Age">
                                            <%# Common.getAge(Eval("DOB")) %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" InsertVisible="False" SortExpression="Status">
                                    <ItemTemplate>
                                        <%# Eval("StatusName")%>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="true" Font-Size="Large" ForeColor="red" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Insert By" InsertVisible="False" SortExpression="InsertBy">
                                    <ItemTemplate>
                                        <uc3:EMP ID="EMP1" Username='<%# Eval("InsertBy") %>' runat="server" />
                                        <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Update By" InsertVisible="False" SortExpression="UpdateBy">
                                    <ItemTemplate>
                                        <uc3:EMP ID="EMP2" Username='<%# Eval("UpdateBy") %>' runat="server" />
                                        <span class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Authorize By" InsertVisible="False" SortExpression="AuthorizeBY">
                                    <ItemTemplate>
                                        <uc3:EMP ID="EMP22" Username='<%# Eval("AuthorizeBY") %>' runat="server" />
                                        <span class="time-small" title='<%# Eval("AuthorizeDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("AuthorizeDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ShowHeader="False" ControlStyle-Width="80px">
                                    <EditItemTemplate>
                                        <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" ValidationGroup="Part1"
                                            CommandName="Update" Text="Update" />
                                        <asp:ConfirmButtonExtender ID="conUpdate" runat="server" ConfirmText="Do you want to Update?"
                                            TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                        &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="False" ValidationGroup="Part1"
                                            CommandName="Cancel" Text="Cancel" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Button ID="cmdInsert" runat="server" CausesValidation="True" ValidationGroup="Part1"
                                            CommandName="Insert" Text="Save" />
                                        <asp:ConfirmButtonExtender ID="conInsert" runat="server" ConfirmText="Do you want to Save?"
                                            TargetControlID="cmdInsert"></asp:ConfirmButtonExtender>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Button ID="cmdEdit" runat="server" Enabled='<%#  Eval("Authorize").ToString() =="True" ? false : true %>'
                                            CausesValidation="True" ValidationGroup="Part1" CommandName="Edit" Text="Edit" />
                                        <asp:Button ID="cmdDelete" runat="server" Enabled='<%# Eval("Authorize").ToString() =="True" ? false : true %>'
                                            CausesValidation="True" ValidationGroup="Part1" CommandName="Delete" Text="Delete" />
                                        <asp:ConfirmButtonExtender ID="conDelete" runat="server" ConfirmText="Do you want to Delete?"
                                            TargetControlID="cmdDelete"></asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="SqlDataSourceMaster" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_SMS_Alert_Request_browse" SelectCommandType="StoredProcedure"
                            InsertCommand="s_SMS_Alert_Request_Add_Edit" InsertCommandType="StoredProcedure"
                            UpdateCommand="s_SMS_Alert_Request_Add_Edit" DeleteCommand="s_SMS_ALert_Requests_Delete"
                            DeleteCommandType="StoredProcedure" OnDeleted="SqlDataSourceMaster_OnDeleted"
                            UpdateCommandType="StoredProcedure"
                            OnInserted="SqlDataSourceMaster_Inserted"
                            OnUpdated="SqlDataSourceMaster_Updated" OnSelected="SqlDataSourceMaster_Selected">
                            <InsertParameters>
                                <asp:Parameter Name="Account" Type="String" />
                                <asp:Parameter Name="AccountName" Type="String" />
                                <asp:Parameter Name="MotherName" Type="String" />
                                <asp:Parameter Name="Address" Type="String" />
                                <asp:Parameter Name="Mobile" Type="String" />
                                <asp:Parameter Name="Email" Type="String" />
                                <%-- <asp:Parameter Name="SMSAlertTypes" Type="String" />--%>
                                <%--<asp:Parameter Name="ServiceType" />--%>
                                <asp:Parameter DbType="Date" Name="DOB" />
                                <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                                <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                                <asp:Parameter Direction="InputOutput" Name="ReqID" Type="Int32" DefaultValue="0" />
                                <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hidReqID" Name="ReqID" PropertyName="Value" DefaultValue="-1" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                <asp:ControlParameter ControlID="hidReqID" Name="ReqID" PropertyName="Value" Type="Int32" />
                                <asp:Parameter Name="Account" Type="String" />
                                <asp:Parameter Name="AccountName" Type="String" />
                                <asp:Parameter Name="MotherName" Type="String" />
                                <%--<asp:Parameter Name="SMSAlertTypes" Type="String" />--%>
                                <asp:Parameter Name="Address" Type="String" />
                                <%-- <asp:Parameter Name="ServiceType" />--%>
                                <asp:Parameter Name="Mobile" Type="String" />
                                <asp:Parameter Name="Email" Type="String" />
                                <asp:Parameter DbType="Date" Name="DOB" />
                                <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                                <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                                <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="hidReqID" Name="ReqID" PropertyName="Value" DefaultValue="-1" />
                                <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td valign="top">
                        <div runat="server" id="divAttachments" visible="false" class="hidden-print" style="display: table; margin: 15px 0; min-width: 200px">
                            <h5>Attachments</h5>
                            <div class="">
                                <div class="pointer attachmentAdd bold">
                                    <asp:LinkButton runat="server" ID="cmdAddAttach" CausesValidation="false" OnClick="cmdAddAttach_Click">
                            <img src="Images/add-files.png" width="20px" />Add Files</asp:LinkButton>
                                </div>

                                <div style="padding: 5px">
                                    <asp:DataList ID="DataList1" runat="server" CellPadding="0" DataKeyField="AID" DataSourceID="SqlDataSourceAttachments"
                                        RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="attachment-list" BorderWidth="0px" Font-Bold="False"
                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"
                                        HorizontalAlign="Center" ShowFooter="False" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Image runat="server" CssClass="AttachmentThumb" ClientIDMode="Predictable"
                                                LoadImg='<%# getLinkImage(Eval("AID"), Eval("FileID"), Eval("Extension")) %>'
                                                ImageUrl="~/Images/Loading.gif" ID="ImageThumb1" border="0" BorderColor="Silver" BorderStyle="Solid" />
                                            <asp:Panel ID="AttachmentMenu" ClientIDMode="Predictable" runat="server" BorderColor="Gray" BorderWidth="1px"
                                                Width="120px" Style="padding: 5px; text-align: left;" CssClass="box">
                                                <div>
                                                    <asp:HyperLink ID="HyperLink3" CssClass="link" runat="server" Font-Size="10pt" ToolTip="View in PDF Viewer"
                                                        NavigateUrl='<%# "Attachment.ashx?aid=" + Eval("AID") + "&key=" + Eval("FileID") + "&view=yes" %>'
                                                        Style="color: blue" Target="_blank"><b>View File</b></asp:HyperLink><br />
                                                </div>
                                                <div style="margin-top: 5px" class='<%# (Eval("Extension").ToString().ToLower() =="pdf" ? "" : "hidden") %>'>
                                                    <asp:HyperLink ID="HyperLink2" CssClass="link" runat="server" Font-Size="10pt" ToolTip="View as HTML"
                                                        NavigateUrl='<%# "pdf.aspx?aid=" + Eval("AID") + "&key=" + Eval("FileID") %>'
                                                        Style="color: blue" Target="_blank"><b>View as HTML</b></asp:HyperLink><br />
                                                </div>
                                                <div style="margin-top: 5px">
                                                    <asp:HyperLink ID="HyperLink1" CssClass="link" runat="server"
                                                        NavigateUrl='<%# "Attachment.ashx?aid=" + Eval("AID") + "&key=" + Eval("FileID") %>'
                                                        Font-Size="10pt" Style="color: blue" ToolTip='<%# Eval("FileName") %>'><b>Download</b></asp:HyperLink>
                                                </div>
                                                <div style="font-size: 7pt">
                                                    <%# "<b>" + FileSize(Eval("FileSize")) + "</b><br /><span style=\"color:Gray\"><b>Upload On:</b><br>" + Common.ToRecentDateTime(Eval("InsertDT")) + "<br>" + "<time class='timeago' datetime='" + Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") + "'></time>" + "</span>"%>
                                                </div>

                                            </asp:Panel>
                                            <asp:HoverMenuExtender ID="ImageThumb1_HoverMenuExtender" runat="server"
                                                Enabled="True" PopupControlID="AttachmentMenu" TargetControlID="ImageThumb1"
                                                OffsetX="30" OffsetY="7" PopDelay="50" HoverDelay="300">
                                            </asp:HoverMenuExtender>
                                        </ItemTemplate>
                                    </asp:DataList>
                                    <asp:SqlDataSource ID="SqlDataSourceAttachments" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:AttachmentsConnectionString %>"
                                        SelectCommand="SELECT * FROM v_Attachments_ExtendedServices_Browse WHERE (CID = @CID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="HidRefID" Name="CID" PropertyName="Value" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="6" ForeColor="Black" Style="font-size: small"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True"
                CssClass="Grid" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnDataBound="GridView1_DataBound">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" ButtonType="Link" ItemStyle-Font-Bold="true"
                        ItemStyle-ForeColor="Blue" />
                    <asp:BoundField DataField="accountno" HeaderText="Account" ReadOnly="True" SortExpression="accountno"
                        ItemStyle-Wrap="false" ItemStyle-CssClass="bold" />
                    <asp:BoundField DataField="acname" HeaderText="Account Name" ReadOnly="True" SortExpression="acname"
                        ItemStyle-Wrap="false" ItemStyle-CssClass="bold" />
                    <asp:BoundField DataField="father_hus" HeaderText="Father Name" ReadOnly="True" SortExpression="father_hus"
                        ItemStyle-Wrap="false" />
                    <asp:BoundField DataField="mother_name" HeaderText="Mother Name" ReadOnly="True"
                        SortExpression="mother_name" />
                    <asp:BoundField DataField="date_of_birth" HeaderText="Date of Birth" ReadOnly="True"
                        SortExpression="date_of_birth" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="pre_add" HeaderText="Address" ReadOnly="True" SortExpression="pre_add"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="Busi_ph" HeaderText="Mobile" ReadOnly="True" SortExpression="Busi_ph"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status"
                        ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bold" />
                </Columns>
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" PageButtonCount="30" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                    No Record(s) Found.
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Flora_Account_Info" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtFilter" Name="Account" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Panel runat="server" ID="panelAddAccount" Width="100%" Visible="false">
                <div class="group">
                    <h5>Add SMS Alert Account(s)</h5>
                    <%-- <asp:Button ID="cmdNew" runat="server" Text="Add A/C" Width="180px" OnClick="cmdNew_Click" />--%>

                    <asp:DetailsView ID="DetailsViewAddAccount" runat="server" BackColor="White" CssClass="Grid"
                        BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black"
                        GridLines="Vertical" DataSourceID="SqlDataSourceAddAccount" AutoGenerateRows="False"
                        OnDataBound="DetailsViewAddAccount_DataBound1" DataKeyNames="ReqID">
                        <AlternatingRowStyle BackColor="White" />
                        <EmptyDataTemplate>
                            <asp:LinkButton runat="server" ID="cmdcredit" CommandName="New" Visible='<%# getIsEditable() %>'>
                                     Add Account(s)
                            </asp:LinkButton>
                        </EmptyDataTemplate>
                        <EmptyDataRowStyle Height="30px" HorizontalAlign="Center" Font-Size="Large" BackColor="#DDDDDD" />
                        <Fields>
                            <asp:TemplateField HeaderText="ID" ShowHeader="true" InsertVisible="false">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblid" Text='<%# Bind("ID") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle ForeColor="Silver" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account Number" ShowHeader="true">
                                <ItemTemplate>
                                    <span>
                                        <%# Eval("Account")%></span>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAccNo" Width="200px" MaxLength="50" OnTextChanged="txtAccNo_TextChanged"
                                        AutoPostBack="true" runat="server" Text='<%# Bind("Account") %>'></asp:TextBox>
                                    <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo33wew3"
                                        ValidChars="0123456789-" TargetControlID="txtAccNo"></asp:FilteredTextBoxExtender>
                                    <asp:Label ID="lblAcc" runat="server" Text=""></asp:Label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator334245gfhui7457" runat="server"
                                        ControlToValidate="txtAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    <br />
                                    <asp:Label ID="lblAccount" runat="server" Text="" BackColor="SeaGreen"></asp:Label>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="txtAccNo" OnTextChanged="txtAccNo_TextChanged" AutoPostBack="true"
                                        Width="200px" MaxLength="50" runat="server" Text='<%# Bind("Account") %>'></asp:TextBox>
                                    <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtedsadndertxtAccNoerewr"
                                        ValidChars="0123456789-" TargetControlID="txtAccNo"></asp:FilteredTextBoxExtender>
                                    <asp:Label ID="lblAcc" runat="server" Text=""></asp:Label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator386752345sadasxz6788" runat="server"
                                        ControlToValidate="txtAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    <br />
                                    <asp:Label ID="lblAccount" runat="server" Text="" BackColor="SeaGreen"></asp:Label>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SMS Alert Types" HeaderStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <asp:DataList ID="DataList1" DataSourceID="SqlDataSourceAlertTypess" runat="server">
                                        <ItemTemplate>
                                            <li>
                                                <%# Eval("AlertName")%></li>
                                        </ItemTemplate>
                                    </asp:DataList>
                                    <asp:SqlDataSource ID="SqlDataSourceAlertTypess" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                        SelectCommand="s_SMS_Alert_Types_Select" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <%--<asp:ControlParameter Name="ReqID" ControlID="hidReqID" PropertyName="Value" Type="Int32" />--%>
                                            <asp:ControlParameter ControlID="grdvAddAccount" Name="ID" PropertyName="SelectedValue"
                                                Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:CheckBoxList ID="chkSMS" runat="server" ValidationGroup="Part1" DataSourceID="SqlDataSourceSMS"
                                        DataTextField="DescHTML" DataValueField="ID">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="SqlDataSourceSMS" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                        SelectCommand="s_SMS_Alert_Type_browse" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                    <asp:HiddenField ID="HidSMSTypes" runat="server" Value='<%# Eval("SMSAlertTypes") %>' />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:CheckBoxList ID="chkSMS" ValidationGroup="Part1" runat="server" DataSourceID="SqlDataSourceSMS"
                                        DataTextField="DescHTML" DataValueField="ID">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="SqlDataSourceSMS" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                        SelectCommand="s_SMS_Alert_Type_browse" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                    <asp:HiddenField ID="HidSMSTypes" runat="server" Value='<%# Eval("SMSAlertTypes") %>' />
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ControlStyle-Width="80px">
                                <EditItemTemplate>
                                    <asp:Button ID="cmdUpdate" runat="server" CausesValidation="true" CommandName="Update"
                                        Text="Update" ValidationGroup="MasterCredit" />
                                    <asp:ConfirmButtonExtender ID="conUpdate" runat="server" ConfirmText="Do you want to Update?"
                                        TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                    &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="Cancel" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:Button ID="cmdInsert" runat="server" CausesValidation="true" CommandName="Insert"
                                        Text="Save" ValidationGroup="MasterCredit" />
                                    <asp:ConfirmButtonExtender ID="conInsert" runat="server" ConfirmText="Do you want to Save?"
                                        TargetControlID="cmdInsert"></asp:ConfirmButtonExtender>
                                    &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="Cancel" />
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="cmdEdit" runat="server" CssClass="Button" CausesValidation="False" CommandName="Edit"
                                        Text="Edit" />
                                    &nbsp;<asp:Button ID="cmdNew" runat="server" CausesValidation="False" CommandName="New"
                                        Text="New" />
                                </ItemTemplate>
                                <ControlStyle Width="80px" />
                            </asp:TemplateField>
                        </Fields>
                    </asp:DetailsView>

                    <asp:SqlDataSource ID="SqlDataSourceAddAccount" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="s_SMS_Alert_Request_Details_Select" SelectCommandType="StoredProcedure"
                        InsertCommand="s_SMS_Alert_Request_Details_Add_Edit" InsertCommandType="StoredProcedure"
                        UpdateCommand="s_SMS_Alert_Request_Details_Add_Edit" UpdateCommandType="StoredProcedure"
                        OnInserted="SqlDataSourceAddAccount_Inserted" OnUpdated="SqlDataSourceAddAccount_Updated" OnInserting="SqlDataSourceAddAccount_Inserting" OnUpdating="SqlDataSourceAddAccount_Updating">
                        <SelectParameters>
                            <%--<asp:ControlParameter ControlID="grdvDrCrDetails" Name="RefID" PropertyName="SelectedValue" />--%>
                            <asp:ControlParameter ControlID="grdvAddAccount" Name="ID" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="ID" Type="Int32" Direction="InputOutput" DefaultValue="0" />
                            <asp:ControlParameter ControlID="HidReqID" Name="ReqID" PropertyName="Value" />
                            <asp:Parameter Name="Account" />
                            <asp:Parameter Name="SMSAlertTypes" />
                            <asp:Parameter Name="Comments" />
                            <asp:SessionParameter Name="Emp" SessionField="EMPID" />
                            <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                            <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="ID" Type="Int32" Direction="InputOutput" DefaultValue="0" />
                            <asp:ControlParameter ControlID="HidReqID" Name="ReqID" PropertyName="Value" />
                            <asp:Parameter Name="Account" />
                            <asp:Parameter Name="SMSAlertTypes" />
                            <asp:Parameter Name="Comments" />
                            <asp:SessionParameter Name="Emp" SessionField="EMPID" />
                            <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                            <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="grdvAddAccount" runat="server" DataKeyNames="ID" AutoGenerateColumns="False" Width="80%"
                        DataSourceID="SqlDataSourcegrdvAddAccount" CssClass="Grid no-shadow" BorderStyle="None" BackColor="White"
                        ShowHeader="true" AllowPaging="false" AllowSorting="false" EnableViewState="true" ShowFooter="true"
                        BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="5" ForeColor="Black" GridLines="Vertical"
                        OnRowCommand="grdvAddAccount_RowCommand">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkTrnSelect" runat="server" CausesValidation="False" CommandName="Select">
                                                                <img src="Images/edit-label.png" width="20" height="20" border="0" />
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Font-Bold="True" ForeColor="Blue" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account">
                                <ItemTemplate>
                                    <%# Eval("Account") %><br />
                                    <%# Eval("FIO") %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" Wrap="false" />
                            </asp:TemplateField>
                            <%--<asp:BoundField HeaderText="SMSAlertTypes" DataField="SMSAlertTypes" SortExpression="SMSAlertTypes" ItemStyle-HorizontalAlign="Left" />--%>
                            <asp:BoundField HeaderText="SMSAlertName" DataField="SMSAlertName" SortExpression="SMSAlertName" ItemStyle-HorizontalAlign="Left" HtmlEncode="false" ItemStyle-Wrap="false" />
                            <asp:TemplateField HeaderText="Comments">
                                <ItemTemplate>
                                    <%# Eval("Comments") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                        <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                        <FooterStyle BackColor="#CCCC99" Font-Bold="true" HorizontalAlign="Right" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>

                    <asp:SqlDataSource ID="SqlDataSourcegrdvAddAccount" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="s_SMS_Alert_Request_Details_ByReqID" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hidReqID" Name="ReqID" PropertyName="Value" DefaultValue="-1" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>
            <span style="visibility: hidden">
                <asp:Button ID="Button1" runat="server" CausesValidation="False" />
                <asp:Button ID="cmdShowUpload" runat="server" CausesValidation="False" />
            </span>

            <%-- modal popup --%>

            <asp:ModalPopupExtender PopupControlID="ModalPanel1" CancelControlID="ModalClose1"
                ID="modalUpload" runat="server" Enabled="True" TargetControlID="cmdShowUpload"
                PopupDragHandleControlID="ModalTitle1" BackgroundCssClass="ModalPopupBG"
                RepositionMode="RepositionOnWindowResizeAndScroll">
            </asp:ModalPopupExtender>

            <asp:Panel runat="server" ID="ModalPanel1" Width="610px" CssClass="ModalPanel">
                <div style="background-color: Green; border: 4px solid green">
                    <asp:Panel runat="server" ID="ModalTitle1" CssClass="MoveIcon"
                        HorizontalAlign="Center" Width="100%">
                        <table width="100%">
                            <tr>
                                <td align="left" style="color: white; font-size: 16pt; font-weight: bolder">
                                    <asp:Literal ID="Label12" runat="server" Text="Add New Attachment"></asp:Literal>
                                </td>
                                <td align="right">
                                    <a href="#" style="cursor: default">
                                        <asp:Image ID="ModalClose1" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close" />
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="Panel3" runat="server" BackColor="#fefdc3" Height="200px">
                        <div style="padding: 20px 20px 20px 20px">
                            <asp:AsyncFileUpload UploaderStyle="Traditional" ID="FileUpload1" runat="server"
                                ThrobberID="myThrobber" Width="400"
                                OnUploadedComplete="FileUpload1_UploadedComplete"
                                OnClientUploadComplete="UploadComplete"
                                OnClientUploadError="UploadError"
                                OnUploadedFileError="FileUpload1_UploadedFileError"
                                OnClientUploadStarted="AsyncFileUpload1_StartUpload" />

                            <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" /><br />
                            <asp:Label ID="lblUploadStatus" tblid="lblUploadStatus" runat="server" Text="" Style="font-size: small;">
                
                            </asp:Label>
                            <div style="display: none; padding-top: 20px" id="UploadBtn">
                                <asp:Button ID="cmdUpload" runat="server" Height="33px"
                                    CssClass="btn"
                                    UseSubmitBehavior="true"
                                    CausesValidation="false" Text="Attach" Width="100px"
                                    OnClick="cmdUpload_Click" />
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="cmdAddAttach" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DynamicLayout="false"
        AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="10">
        <ProgressTemplate>
            <div class="TransparentGrayBackground"></div>
            <asp:Image ID="Image1" runat="server" alt="" ImageUrl="~/Images/processing.gif"
                CssClass="LoadingImage" Width="214" Height="138" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:AlwaysVisibleControlExtender ID="UpdateProgress1_AlwaysVisibleControlExtender"
        runat="server" Enabled="True" HorizontalSide="Center" TargetControlID="Image1"
        UseAnimation="false" VerticalSide="Middle"></asp:AlwaysVisibleControlExtender>
</asp:Content>
