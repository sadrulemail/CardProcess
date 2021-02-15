<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" EnableSessionState="True"
    CodeFile="Card_AddEdit.aspx.cs" Inherits="Card_AddEdit" Culture="en-NZ" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function storeCoords(c) {
            $('#crop_X').val(c.x);
            $('#crop_Y').val(c.y);
            $('#crop_W').val(c.w);
            $('#crop_H').val(c.h);
        };
        function getReadableFileSizeString(fileSizeInBytes) {
            var i = -1;
            var byteUnits = [' KB', ' MB', ' GB', ' TB', 'PB', 'EB', 'ZB', 'YB'];
            do {
                fileSizeInBytes = fileSizeInBytes / 1024;
                i++;
            } while (fileSizeInBytes > 1024);
            return Math.max(fileSizeInBytes, 0.1).toFixed(2) + byteUnits[i];
        }
        function AsyncFileUpload1_StartUpload(sender, args) {
            var filename = args.get_fileName();
            var ext = filename.substring(filename.lastIndexOf(".") + 1);
            if (ext.toLowerCase() == 'jpg') {
                $('#lblUploadStatus').html("<b>" + args.get_fileName() + "</b> is uploading...");
            }
            else {
                $('#UploadBtn').hide('Slow');
                $('#lblUploadStatus').html("Only JPG files can be uploaded.");
                throw {
                    name: "Invalid File Type",
                    level: "Error",
                    message: "Only <b>JPG</b> files can be uploaded. ",
                    htmlMessage: "Only JPG files can be uploaded. "
                }
                return false;
            }
        }
        function UploadError(sender, args) {
            $('#lblUploadStatus').html(args.get_errorMessage() + "File Uploading Error. Please try again.");
            $('#UploadBtn').hide('Slow');
        }
        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var TryAgain = '<br /><br /><a href="Card_AddEdit.aspx" class="Button">Try Again</a>';
            var contentType = args.get_contentType();
            var text = "Size of " + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += " and content type is '" + contentType + "'.";
            }
            if (contentType != 'image/jpeg') {
                $('#UploadBtn').hide();
                $('#lblUploadStatus').html('Only JPG files are allowed to upload.' + TryAgain);
            }
            else if (args.get_length() > (1024 * 1024 * 2)) {
                $('#UploadBtn').hide();
                $('#lblUploadStatus').html('File size must be less than 2 MB.' + TryAgain);
            }
            else {
                $('#UploadBtn').show('Slow');
                $('#lblUploadStatus').html('<b>' + filename + '</b> is successfully uploaded. (' + getReadableFileSizeString(args.get_length()) + ')<br>');
            }
        }
    </script>
    <style>
        .AsyncFileUploadField input {
            width: 98% !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="Card Request"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <uc2:MyControl ID="MyControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <asp:HiddenField ID="ACType" runat="server" Value="" />
            <asp:SqlDataSource ID="SqlDataSourceCardType" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_getCardTypes" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ACType" PropertyName="Value" Name="AccTypes" />
                    <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                    <asp:Parameter Name="ReqType"  Type="String" DefaultValue="I" />
                </SelectParameters>
            </asp:SqlDataSource>
            <table>
                <tr>
                    <td valign="top">
                        <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" BorderColor="#CC9966"
                            BorderStyle="Solid" BorderWidth="1px" CellPadding="2" DataSourceID="SqlDataSourceCardProcessAddEdit"
                            DefaultMode="ReadOnly" Style="font-size: small" AutoGenerateRows="False" DataKeyNames="ID"
                            CssClass="Grid" OnItemUpdated="DetailsView1_ItemUpdated" OnDataBound="DetailsView1_DataBound"
                            OnItemUpdating="DetailsView1_ItemUpdating" OnItemInserting="DetailsView1_ItemInserting">
                            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                            <RowStyle BackColor="White" ForeColor="#330099" />
                            <AlternatingRowStyle BackColor="#E3F9FF" ForeColor="Black" />
                            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                            <Fields>
                                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                    SortExpression="ID" />
                                <asp:TemplateField HeaderText="ACCOUNT NO.">
                                    <ItemTemplate>
                                        <asp:Label ID="lblACCOUNT" Font-Bold="true" Font-Size="Medium" runat="server" Text='<%# Eval("ACCOUNT") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtAccNo" Text='<%# Bind("ACCOUNT") %>' MaxLength="20" AutoPostBack="true" OnTextChanged="txtAccNo_TextChanged"
                                            Width="200px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo"
                                            ValidChars="0123456789-" TargetControlID="txtAccNo"></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAccNo"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        <asp:Button runat="server" ID="cmdGetAccount" Text="Get Account Information" Width="180px"
                                            CausesValidation="false" OnClick="cmdGetAccount_Click" />
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="txtAccNo" runat="server" Text='<%# Bind("ACCOUNT") %>' AutoPostBack="true" OnTextChanged="txtAccNo_TextChanged"
                                            Font-Bold="true" Font-Size="Medium"></asp:Label>

                                        <asp:Button ID="cmdGetAccount" runat="server" Text="Get Account Information" CausesValidation="false"
                                            OnClick="cmdGetAccount_Click" Width="180px" Visible="false" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Card Number" InsertVisible="false">
                                    <ItemTemplate>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblCardNo" runat="server" Text='<%# Eval("CardNumber") %>'></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ITCL ID" InsertVisible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblITCLID" runat="server" Text='<%# Eval("ITCLID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblITCLID" runat="server" Text='<%# Eval("ITCLID") %>'></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Card Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCardType" runat="server" Text='<%# Eval("CardType") %>'></asp:Label>,
                                        <asp:Label ID="lblCardTypeName" runat="server" Text='<%# Eval("CardTypeName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cboCardType" runat="server"
                                            AppendDataBoundItems="false" DataSourceID="SqlDataSourceCardType" DataTextField="CardType"
                                            DataValueField="CardTypeCode" OnDataBound="cboCardType_DataBound">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cboCardType"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>

                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cboCardType" runat="server"
                                            DataSourceID="SqlDataSourceCardType" DataTextField="CardType" DataValueField="CardTypeCode"
                                            OnDataBound="cboCardType_DataBound">
                                        </asp:DropDownList>

                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CUSTOMER NAME">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFIO" Font-Bold="true" Font-Size="Medium" runat="server" Text='<%# Eval("FIO") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtFIO" Text='<%# Bind("FIO") %>' MaxLength="40"
                                            Width="400px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFIO"
                                            ErrorMessage="RequiredFieldValidator" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FTBtxtFIO" TargetControlID="txtFIO"
                                            ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-' "></asp:FilteredTextBoxExtender>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtFIO" runat="server" Text='<%# Bind("FIO") %>' MaxLength="40"
                                            Width="400px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFIO"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FTBtxtFIO" TargetControlID="txtFIO"
                                            ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-' "></asp:FilteredTextBoxExtender>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SEX">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSEX" runat="server" Text='<%# Eval("SEX") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cboSEX" runat="server" SelectedValue='<%# Bind("SEX") %>'>
                                            <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                        </asp:DropDownList>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cboSEX" runat="server" SelectedValue='<%# Bind("SEX") %>'>
                                            <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TITLE">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cmdTitle" runat="server" SelectedValue='<%# Bind("Title") %>'>
                                            <asp:ListItem Text="" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Mr" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Mrs" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Ms" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Dr" Value="4"></asp:ListItem>
                                        </asp:DropDownList>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cmdTitle" runat="server" SelectedValue='<%# Bind("Title") %>'>
                                            <asp:ListItem Text="" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Mr" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Mrs" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Ms" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Dr" Value="4"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="NAME ON CARD">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNAMEONCARD" Font-Bold="true" Font-Size="Medium" runat="server"
                                            Text='<%# Eval("NAMEONCARD") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtNAMEONCARD" Text='<%# Bind("NAMEONCARD") %>' MaxLength="19"
                                            Width="400px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNAMEONCARD"
                                            ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,19}$"
                                            Display="Dynamic" SetFocusOnError="true" BackColor="Yellow">Invalid</asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNAMEONCARD"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        Max 19 Char
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNAMEONCARD" runat="server" Text='<%# Bind("NAMEONCARD") %>' MaxLength="19"
                                            Width="400px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNAMEONCARD"
                                            ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,19}$"
                                            Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNAMEONCARD"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        Max 19 Char
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ACCOUNT TYPE">
                                    <ItemTemplate>
                                        <asp:Label ID="lblACCOUNTTP" runat="server" Text='<%# Eval("ACCOUNTTP") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtACCOUNTTP" Text='<%# Bind("ACCOUNTTP") %>' MaxLength="8"
                                            Width="100px" ReadOnly="true" BackColor="#FFCC66"></asp:TextBox>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtACCOUNTTP" runat="server" Text='<%# Bind("ACCOUNTTP") %>' Width="100px"
                                            ForeColor="White" Font-Bold="true" BackColor="#8EA651"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ACCT STAT">
                                    <ItemTemplate>
                                        <asp:Label ID="lblACCTSTAT" runat="server" Text='<%# Eval("ACCTSTAT") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cmdACCTSTAT" runat="server" SelectedValue='<%# Bind("ACCTSTAT") %>'>
                                            <asp:ListItem Text="3, Primary Open" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cmdACCTSTAT" runat="server" SelectedValue='<%# Bind("ACCTSTAT") %>'>
                                            <asp:ListItem Text="3, Primary Open" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date of Birth">
                                    <ItemTemplate>
                                        <%# string.Format(TrustControl1.English, "{0:dd MMM, yyyy}", Eval("DOB")) %>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txtDOB" runat="server" Text='<%# Bind("DOB","{0:dd-MM-yyyy}") %>'
                                            MaxLength="80" Width="80px" CssClass="Date"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidasdadator3" runat="server" ControlToValidate="txtDOB" ForeColor="Red"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        [dd-mm-yyyy]
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDOB" runat="server" Text='<%# Bind("DOB","{0:dd-MM-yyyy}") %>'
                                            MaxLength="80" Width="80px" CssClass="Date"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValSASAidasdadator3" runat="server" ForeColor="Red" ControlToValidate="txtDOB"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        [dd-mm-yyyy]
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ADDRESS">
                                    <ItemTemplate>
                                        <asp:Label ID="lblADDRESS" runat="server" Text='<%# Eval("ADDRESS") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtADDRESS" Text='<%# Bind("ADDRESS") %>' MaxLength="80"
                                            Width="600px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender_txtADDRESS"
                                            TargetControlID="txtADDRESS" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-,#&/:()' "></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="RequiredFieldVaADAlSASAidasdadator3" ForeColor="Red" runat="server" ControlToValidate="txtADDRESS"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtADDRESS" runat="server" Text='<%# Bind("ADDRESS") %>' MaxLength="65"
                                            Width="600px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender_txtADDRESS"
                                            TargetControlID="txtADDRESS" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-,#&/:()' "></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="RequiredFieldVaADAlSASAidasdadator3" runat="server" ControlToValidate="txtADDRESS"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="COR ADDRESS">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCORADDRESS" runat="server" Text='<%# Eval("CORADDRESS") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtCORADDRESS" Text='<%# Bind("CORADDRESS") %>' MaxLength="65"
                                            Width="600px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender_txtCORADDRESS"
                                            TargetControlID="txtCORADDRESS" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-,#&/:()' "></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="ReqADSAuiredFieldVaADAlSASAidasdadator3" runat="server" ControlToValidate="txtCORADDRESS"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCORADDRESS" runat="server" Text='<%# Bind("CORADDRESS") %>' MaxLength="65"
                                            Width="600px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender_txtCORADDRESS"
                                            TargetControlID="txtCORADDRESS" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-,#&/:()' "></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="ReqADSAuiredFieldVaADAlSASAidasdadator3" runat="server" ControlToValidate="txtCORADDRESS"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RES ADDRESS">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRESADDRESS" runat="server" Text='<%# Eval("RESADDRESS") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtRESADDRESS" Text='<%# Bind("RESADDRESS") %>' MaxLength="66"
                                            Width="600px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender_txtRESADDRESS"
                                            TargetControlID="txtRESADDRESS" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-,#&/:()' "></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="ReqADSAADSWuiredFieldVaADAlSASAidasdadator3" runat="server" ControlToValidate="txtRESADDRESS"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtRESADDRESS" runat="server" Text='<%# Bind("RESADDRESS") %>' MaxLength="66"
                                            Width="600px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtender_txtRESADDRESS"
                                            TargetControlID="txtRESADDRESS" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-,#&/:()' "></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="ReqADSAADSWuiredFieldVaADAlSASAidasdadator3" runat="server" ControlToValidate="txtRESADDRESS"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CNTRY REG">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCNTRYREG" runat="server" Text='<%# Eval("CNTRYREG") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cmdCNTRYREG" runat="server" SelectedValue='<%# Bind("CNTRYREG") %>'>
                                            <asp:ListItem Text="50, BD" Value="50"></asp:ListItem>
                                        </asp:DropDownList>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cmdCNTRYREG" runat="server" SelectedValue='<%# Bind("CNTRYREG") %>'>
                                            <asp:ListItem Text="50, BD" Value="50"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CNTRY CONT">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCNTRYCONT" runat="server" Text='<%# Eval("CNTRYCONT") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cmdCNTRYCONT" runat="server" SelectedValue='<%# Bind("CNTRYCONT") %>'>
                                            <asp:ListItem Text="50, BD" Value="50"></asp:ListItem>
                                        </asp:DropDownList>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cmdCNTRYCONT" runat="server" SelectedValue='<%# Bind("CNTRYCONT") %>'>
                                            <asp:ListItem Text="50, BD" Value="50"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CNTRY LIVE">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCNTRYLIVE" runat="server" Text='<%# Eval("CNTRYLIVE") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cmdCNTRYLIVE" runat="server" SelectedValue='<%# Bind("CNTRYLIVE") %>'>
                                            <asp:ListItem Text="50, BD" Value="50"></asp:ListItem>
                                        </asp:DropDownList>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cmdCNTRYLIVE" runat="server" SelectedValue='<%# Bind("CNTRYLIVE") %>'>
                                            <asp:ListItem Text="50, BD" Value="50"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CELL PHONE">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCELLPHONE" runat="server" Text='<%# toCellPhone(Eval("CELLPHONE")) %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtCELLPHONE" Text='<%# Bind("CELLPHONE") %>' MaxLength="20"
                                            Width="200px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{10}$"
                                            ControlToValidate="txtCELLPHONE" ErrorMessage="RegularExpressionValidator" Font-Bold="true"
                                            ForeColor="Red">Invalid</asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="ReqADSAADDWEWSWuiredFieldVaADAlSASAidasdadator3" runat="server" ControlToValidate="txtCELLPHONE"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        Ex: 8801XXXXXXXXX
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCELLPHONE" runat="server" Text='<%# Bind("CELLPHONE") %>' MaxLength="20"
                                            Width="200px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{10}$"
                                            ControlToValidate="txtCELLPHONE" ErrorMessage="RegularExpressionValidator" Font-Bold="true"
                                            ForeColor="Red">Invalid</asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="ReqADSAADDWEWSWuiredFieldVaADAlSASAidasdadator3" runat="server" ControlToValidate="txtCELLPHONE"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        Ex: 8801XXXXXXXXX
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PHONE">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPHONE" runat="server" Text='<%# Eval("PHONE") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtPHONE" Text='<%# Bind("PHONE") %>' MaxLength="20"
                                            Width="200px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ValidationExpression="^880\d{6,15}$"
                                            ControlToValidate="txtPHONE" ForeColor="Red" ErrorMessage="RegularExpressionValidator">Invalid</asp:RegularExpressionValidator>
                                        Ex: 880XXXXXXXXXX
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPHONE" runat="server" Text='<%# Bind("PHONE") %>' MaxLength="20"
                                            Width="200px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ValidationExpression="^880\d{6,15}$"
                                            ControlToValidate="txtPHONE" ForeColor="Red" ErrorMessage="RegularExpressionValidator">Invalid</asp:RegularExpressionValidator>
                                        Ex: 880XXXXXXXXXX
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="MOTHER'S NAME">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMotherName" runat="server" Text='<%# Eval("MotherName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtMotherName" Text='<%# Bind("MotherName") %>' MaxLength="40"
                                            Width="400px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtMotherName"
                                            TargetControlID="txtMotherName" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.- "></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="SDSReqADSAADDWEWSWuiredFieldVaADAlSASAidasdadator3" runat="server" ControlToValidate="txtMotherName"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtMotherName" runat="server" Text='<%# Bind("MotherName") %>' MaxLength="40"
                                            Width="400px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtMotherName"
                                            TargetControlID="txtMotherName" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.- "></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="SDSReqADSAADDWEWSWuiredFieldVaADAlSASAidasdadator3" runat="server" ControlToValidate="txtMotherName"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FATHER'S NAME">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFatherName" runat="server" Text='<%# Eval("FatherName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtFatherName" Text='<%# Bind("FatherName") %>' MaxLength="40"
                                            Width="400px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtFatherName"
                                            TargetControlID="txtFatherName" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.- "></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="WWSDlSASAidasdadator3" ForeColor="Red" runat="server" ControlToValidate="txtFatherName"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtFatherName" runat="server" Text='<%# Bind("FatherName") %>' MaxLength="40"
                                            Width="400px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtFatherName"
                                            TargetControlID="txtFatherName" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.- "></asp:FilteredTextBoxExtender>
                                        <asp:RequiredFieldValidator ID="WWSDlSASAidasdadator3" runat="server" ForeColor="Red" ControlToValidate="txtFatherName"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="E-Commerce Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblECSTATUS" runat="server" Text='<%# Eval("ECSTATUS") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cboECSTATUS" runat="server" SelectedValue='<%# Bind("ECSTATUS") %>'>
                                            <asp:ListItem Text="" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Enroll" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cboECSTATUS" runat="server" SelectedValue='<%# Bind("ECSTATUS") %>'>
                                            <asp:ListItem Text="" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Enroll" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtEmail" Text='<%# Bind("Email") %>' MaxLength="40"
                                            Width="400px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" runat="server"
                                            ControlToValidate="txtEmail" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' MaxLength="40"
                                            Width="400px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" runat="server"
                                            ControlToValidate="txtEmail" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Other Accounts">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOtherAccounts" Font-Bold="true" Font-Size="Medium" runat="server"
                                            Text='<%# Eval("OtherAccounts") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtOtherAccounts" Text='<%# Bind("OtherAccounts") %>'
                                            MaxLength="40" Width="400px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender ID="txtOtherAccounts_FilteredTextBoxExtender" runat="server"
                                            Enabled="True" TargetControlID="txtOtherAccounts" ValidChars="0123456789-,"></asp:FilteredTextBoxExtender>
                                        Use comma (,) for multiple a/c
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtOtherAccounts" runat="server" Text='<%# Bind("OtherAccounts") %>'
                                            MaxLength="40" Width="400px"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender ID="txtOtherAccounts_FilteredTextBoxExtender" runat="server"
                                            Enabled="True" TargetControlID="txtOtherAccounts" ValidChars="0123456789-,"></asp:FilteredTextBoxExtender>
                                        Use comma (,) for multiple a/c
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Card Delivery Branch">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDeliveryToBranch" runat="server" Text='<%# Eval("DeliveryToBranch") %>'></asp:Label>,
                                        <asp:Label ID="lblDeliveryToBranchName" runat="server" Text='<%# Eval("DeliveryToBranchName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cboDeliveryToBranch" runat="server" SelectedValue='<%# Bind("DeliveryToBranch") %>'
                                            DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID"
                                            AppendDataBoundItems="true" OnDataBound="cboDeliveryToBranch_DataBound">
                                            <asp:ListItem Text="" Value=""></asp:ListItem>
                                            <asp:ListItem Text="My Current Branch" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cboDeliveryToBranch"
                                            ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                            SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranchOnly] order by BranchName"></asp:SqlDataSource>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cboDeliveryToBranch" runat="server" SelectedValue='<%# Bind("DeliveryToBranch") %>'
                                            DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID"
                                            AppendDataBoundItems="true">
                                            <asp:ListItem Text="My Current Branch" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                            SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranchOnly] order by BranchName"></asp:SqlDataSource>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Requested From" InsertVisible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReqBranch" runat="server" Text='<%# Eval("ReqBranch") %>'></asp:Label>,
                                        <asp:Label ID="lblReqBranchName" runat="server" Text='<%# Eval("ReqBranchName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblReqBranch" runat="server" Text='<%# Eval("ReqBranch") %>'></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Modified From" InsertVisible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblModifyBranch" runat="server" Text='<%# Eval("ModifyBranch") %>'></asp:Label>,
                                        <asp:Label ID="lblModifyBranchName" runat="server" Text='<%# Eval("ModifyBranchName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblModifyBranch" runat="server" Text='<%# Eval("ModifyBranch") %>'></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Insert By" InsertVisible="False" SortExpression="InsertBy">
                                    <ItemTemplate>
                                        <uc3:EMP ID="EMP1" Username='<%# Eval("InsertBy") %>' runat="server" />
                                        <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Modify By" InsertVisible="False" SortExpression="InsertBy">
                                    <ItemTemplate>
                                        <uc3:EMP ID="EMP2" Username='<%# Eval("ModifyBy") %>' runat="server" />
                                        <span class="time-small" title='<%# Eval("ModifyDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("ModifyDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Sent to ITCL" InsertVisible="false">
                                    <ItemTemplate>
                                        <asp:CheckBox Enabled="false" runat="server" ID="chkSendToProcess" Checked='<%# SendToProcess(Eval("SendToProcess")) %>' />
                                        <%# Eval("SendOn") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Batch No." InsertVisible="false">
                                    <ItemTemplate>
                                        <%# Eval("BatchNo") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PictureRequired" Visible="false">
                                    <ItemTemplate>
                                        <%# Eval("PictureRequired") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-Width="120px" ControlStyle-Height="30px">
                                    <ItemTemplate>
                                        <asp:Button runat="server" ID="cmdEdit" Text="Edit" CommandName="Edit" Enabled='<%# Eval("SendToProcess").ToString() == "True" ? false : true %>'
                                            CausesValidation="false" />
                                        <asp:Button ID="cmdDelete" runat="server" Enabled='<%# Eval("SendToProcess").ToString() == "True" ? false : true %>'
                                            CausesValidation="false" CommandName="Delete" Text="Delete" />
                                        <asp:ConfirmButtonExtender ID="conDelete" runat="server" ConfirmText="Do you want to Delete?"
                                            TargetControlID="cmdDelete"></asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Button runat="server" ID="cmdUpdate" Text="Update" CommandName="UPDATE" />
                                        <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Do you want to Update?"
                                            Enabled="True" TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                        <asp:Button runat="server" ID="cmdCancel" CommandName="CANCEL" Text="Cancel" CausesValidation="false" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Button runat="server" ID="cmdSave" Text="Save" CommandName="INSERT" OnClick="cmdSave_Click" />
                                    </InsertItemTemplate>
                                    <ControlStyle Height="30px" Width="120px" />
                                </asp:TemplateField>
                            </Fields>
                            <HeaderStyle BackColor="#990000" Font-Bold="false" ForeColor="#FFFFCC" />
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="SqlDataSourceCardProcessAddEdit" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="SELECT * FROM [v_CardProcess_Details] WHERE ([ID] = @ID)" InsertCommand="sp_CardProcess_AddEdit"
                            DeleteCommand="s_CardProcess_Delete" DeleteCommandType="StoredProcedure"
                            InsertCommandType="StoredProcedure" UpdateCommand="sp_CardProcess_AddEdit" UpdateCommandType="StoredProcedure"
                            OnInserted="SqlDataSourceCardProcessAddEdit_Inserted" OnUpdated="SqlDataSourceCardProcessAddEdit_Updated"
                            OnSelected="SqlDataSourceCardProcessAddEdit_Selected" OnInserting="SqlDataSourceCardProcessAddEdit_Inserting" OnUpdating="SqlDataSourceCardProcessAddEdit_Updating" OnDeleted="SqlDataSourceCardProcessAddEdit_Deleted">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hidID" Name="ID" PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="hidID" Name="ID" PropertyName="Value" Type="Int32" />
                                <asp:SessionParameter Name="ReqBranch" SessionField="BRANCHID" Type="Int32" />
                                <asp:Parameter Name="Msg" Type="String" Size="500" Direction="InputOutput" DefaultValue="" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                <asp:ControlParameter ControlID="hidID" Name="ID" PropertyName="Value" Type="Int32"
                                    Direction="InputOutput" />
                                <asp:Parameter Name="FIO" Type="String" />
                                <asp:Parameter Name="SEX" Type="String" />
                                <asp:Parameter Name="Title" Type="String" />
                                <asp:Parameter Name="NameOnCard" Type="String" />
                                <asp:Parameter Name="Account" Type="String" />
                                <asp:Parameter Name="AccountTP" Type="Int32" />
                                <asp:Parameter Name="DOB" Type="DateTime" />
                                <asp:Parameter Name="AcctStat" Type="String" />
                                <asp:Parameter Name="Address" Type="String" Size="80" />
                                <asp:Parameter Name="CorAddress" Type="String" Size="66" />
                                <asp:Parameter Name="ResAddress" Type="String" Size="66" />
                                <asp:Parameter Name="CntryReg" Type="Int32" />
                                <asp:Parameter Name="CntryCont" Type="Int32" />
                                <asp:Parameter Name="CntryLive" Type="Int32" />
                                <asp:Parameter Name="Cellphone" Type="String" />
                                <asp:Parameter Name="Phone" Type="String" />
                                <asp:Parameter Name="MotherName" Type="String" />
                                <asp:Parameter Name="FatherName" Type="String" />
                                <asp:Parameter Name="EcStatus" Type="String" />
                                <asp:Parameter Name="Email" Type="String" />
                                <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                                <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                                <asp:ControlParameter ControlID="hidMsg" PropertyName="Value" Name="Msg" Direction="InputOutput"
                                    DefaultValue="" Size="500" />
                                <asp:Parameter Name="CardType" Type="String" />
                                <asp:Parameter Name="OtherAccounts" Type="String" />
                                <asp:Parameter Name="Comments" Type="String" />
                                <asp:Parameter Name="DeliveryToBranch" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                <asp:ControlParameter ControlID="hidID" Name="ID" PropertyName="Value" Type="Int32"
                                    Direction="InputOutput" />
                                <asp:Parameter Name="FIO" Type="String" />
                                <asp:Parameter Name="SEX" Type="String" />
                                <asp:Parameter Name="Title" Type="String" />
                                <asp:Parameter Name="NameOnCard" Type="String" />
                                <asp:Parameter Name="Account" Type="String" />
                                <asp:Parameter Name="AccountTP" Type="Int32" />
                                <asp:Parameter Name="DOB" Type="DateTime" />
                                <asp:Parameter Name="AcctStat" Type="String" />
                                <asp:Parameter Name="Address" Type="String" Size="80" />
                                <asp:Parameter Name="CorAddress" Type="String" Size="66" />
                                <asp:Parameter Name="ResAddress" Type="String" Size="66" />
                                <asp:Parameter Name="CntryReg" Type="Int32" />
                                <asp:Parameter Name="CntryCont" Type="Int32" />
                                <asp:Parameter Name="CntryLive" Type="Int32" />
                                <asp:Parameter Name="Cellphone" Type="String" />
                                <asp:Parameter Name="Phone" Type="String" />
                                <asp:Parameter Name="MotherName" Type="String" />
                                <asp:Parameter Name="FatherName" Type="String" />
                                <asp:Parameter Name="EcStatus" Type="String" />
                                <asp:Parameter Name="Email" Type="String" />
                                <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                                <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                                <asp:ControlParameter ControlID="hidMsg" PropertyName="Value" Name="Msg" Direction="InputOutput"
                                    DefaultValue="" Size="500" />
                                <%--<asp:Parameter Name="ID" Type="Int32" />--%>
                                <asp:Parameter Name="CardType" Type="String" />
                                <asp:Parameter Name="OtherAccounts" Type="String" />
                                <asp:Parameter Name="Comments" Type="String" />
                                <asp:Parameter Name="DeliveryToBranch" Type="Int32" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="hidID" runat="server" />
                        <asp:HiddenField ID="hidMsg" runat="server" />
                    </td>
                    <td valign="top">
                        <asp:Panel ID="Panel11111" runat="server" Visible="false">
                            <h4>Card Holder Picture</h4>

                            <div class="tab-body">
                                <asp:Panel runat="server" ID="PanelProfileImage" Style="margin-bottom: 10px">
                                    <img src="Images/loader.gif" loadimg='CardImage.ashx?id=<%= hidID.Value %>'
                                        width="200" class="loadimg img-rounded img-responsive img-thumbnail" />
                                </asp:Panel>
                                <asp:HiddenField ID="hidTime" runat="server" />
                                <asp:Panel ID="Panel2" runat="server">
                                    <table class="table table-responsive table-condensed table-bordered">
                                        <tr>
                                            <td class="td-header">
                                                <b>Select JPG File (max 2 MB):</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:AsyncFileUpload ID="FileUpload1" runat="server" UploadingBackColor="Yellow"
                                                    CssClass="AsyncFileUploadField" ThrobberID="myThrobber" OnUploadedComplete="FileUpload1_UploadedComplete"
                                                    OnClientUploadComplete="UploadComplete" OnClientUploadError="UploadError" OnUploadedFileError="FileUpload1_UploadedFileError"
                                                    OnClientUploadStarted="AsyncFileUpload1_StartUpload" UploaderStyle="Traditional" />
                                                <asp:Image ImageUrl="Images/ajax-loader.gif" ID="myThrobber" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:Panel ID="pnlCrop" runat="server" Visible="false" ClientIDMode="Static">
                                    <div class="bold alert alert-success">
                                        Please select the area to crop the image.
                                    </div>
                                    <asp:Image ID="imgCrop" CssClass="loadimg" runat="server" ClientIDMode="Static" />
                                    <br />
                                    <asp:HiddenField ID="crop_X" ClientIDMode="Static" runat="server" />
                                    <asp:HiddenField ID="crop_Y" ClientIDMode="Static" runat="server" />
                                    <asp:HiddenField ID="crop_W" ClientIDMode="Static" runat="server" />
                                    <asp:HiddenField ID="crop_H" ClientIDMode="Static" runat="server" />
                                    <asp:Button ID="btnCrop" Height="30px" runat="server" Text="Crop and Save" Font-Bold="true"
                                        OnClick="btnCrop_Click" />
                                </asp:Panel>
                                <asp:Panel ID="pnlCropped" runat="server" Visible="false">
                                    <asp:Image ID="imgCropped" runat="server" CssClass="img-responsive img-thumbnail img-rounded"
                                        Width="200" />
                                    <%--<div style="margin-bottom: 10px; margin-top: 20px">
                                        <asp:CheckBox ID="ckhAgree" CssClass="bold" runat="server" Text=" I am ensuring that, this is my picture and this picture complies with the instructions." />
                                    </div>--%>
                                    <br />
                                    <asp:Button ID="cmdSave" Width="100px" Height="30px" runat="server" Font-Bold="true"
                                        Text="Save" OnClick="cmdSave1_Click" />
                                    <asp:ConfirmButtonExtender ID="cmdSave_ConfirmButtonExtender" runat="server" ConfirmText="Do you want to Update?"
                                        Enabled="True" TargetControlID="cmdSave"></asp:ConfirmButtonExtender>
                                </asp:Panel>
                                <asp:Label ID="lblUploadStatus" ClientIDMode="Static" runat="server" Text="" Style="font-size: small;"></asp:Label>
                                <span style="display: none; padding-top: 10px" id="UploadBtn">
                                    <br />
                                    <asp:Button ID="cmdUpload" runat="server" CausesValidation="false" Font-Bold="true"
                                        Text="Show" Width="100px" OnClick="cmdUpload_Click" Height="30px" /></span>
                            </div>
                            <br />

                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
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
