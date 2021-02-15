﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    Inherits="Dispute" CodeFile="Dispute.aspx.cs" ValidateRequest="false" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
    Dispute #<asp:Label ID="lblTicket" runat="server" Text=""></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="HidPageID" runat="server" Value="" />
            <asp:HiddenField ID="HidDisputeID" runat="server" Value="" />
            <asp:HiddenField ID="HidFileName" ClientIDMode="Static" runat="server" Value="" />
            <asp:HiddenField ID="HidUploadTempFile" runat="server" Value="" />
            <table>
                <tr>
                    <td style="width: 30%" valign="top">
                        <div class="group">
                            <h5>Dispute Information</h5>
                            <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" CssClass="Grid"
                                BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black"
                                GridLines="Vertical" AutoGenerateRows="False" DataKeyNames="ID" EnableViewState="true"
                                DataSourceID="SqlDataSourceDispute" Width="450px" OnDataBound="DetailsView1_DataBound">
                                <Fields>
                                    <asp:TemplateField HeaderText="ID" ShowHeader="true" InsertVisible="false">
                                        <ItemTemplate>
                                            <%# Eval("ID")%>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="true" Font-Size="Larger" ForeColor="Silver" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Trancaction Type">
                                        <ItemTemplate>
                                            <%# Eval("Type")%>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:DropDownList ID="cboType" runat="server" SelectedValue='<%# Bind("Type") %>'
                                                AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="cboType_SelectedIndexChanged">
                                                <asp:ListItem Text="ATM" Value="ATM"></asp:ListItem>
                                                <asp:ListItem Text="POS" Value="POS"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorServiceType" runat="server"
                                                ControlToValidate="cboType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        </InsertItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="cboType" runat="server" SelectedValue='<%# Bind("Type") %>'
                                                AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="cboType_SelectedIndexChanged">
                                                <asp:ListItem Text="ATM" Value="ATM"></asp:ListItem>
                                                <asp:ListItem Text="POS" Value="POS"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorServiceType1" runat="server"
                                                ControlToValidate="cboType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemStyle Font-Bold="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Card Number" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("CardNo")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtCardNo" Width="200px" MaxLength="20" OnTextChanged="txtCardNo_TextChanged"
                                                AutoPostBack="true" runat="server" Text='<%# Bind("CardNo") %>'></asp:TextBox>
                                            <asp:Label runat="server" ID="lblCardNo" Text=""></asp:Label>
                                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtCardNo333"
                                                ValidChars="0123456789-" TargetControlID="txtCardNo"></asp:FilteredTextBoxExtender>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33424fgdgj57457" runat="server"
                                                ControlToValidate="txtCardNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            <asp:Label ID="lblCard" runat="server" Text=""></asp:Label>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtCardNo" Width="200px" MaxLength="19" OnTextChanged="txtCardNo_TextChanged"
                                                AutoPostBack="true" runat="server" Text='<%# Bind("CardNo") %>'></asp:TextBox>
                                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtCardNo123412"
                                                ValidChars="0123456789-" TargetControlID="txtCardNo"></asp:FilteredTextBoxExtender>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3867523sdsad456788" runat="server"
                                                ControlToValidate="txtCardNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            <asp:Label ID="lblCardNo" runat="server" Text=""></asp:Label>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Account Number" ShowHeader="true">
                                        <ItemTemplate>
                                            <span>
                                                <%# Eval("AccNo")%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtAccNo" Width="200px" MaxLength="50" OnTextChanged="txtAccNo_TextChanged"
                                                AutoPostBack="true" runat="server" Text='<%# Bind("AccNo") %>'></asp:TextBox>
                                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo33wew3"
                                                ValidChars="0123456789-" TargetControlID="txtAccNo"></asp:FilteredTextBoxExtender>
                                            <asp:Label ID="lblAcc" runat="server" Text=""></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator334245gfhui7457" runat="server"
                                                ControlToValidate="txtAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            <asp:Label ID="lblAccount" runat="server" Text=""></asp:Label>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtAccNo" OnTextChanged="txtAccNo_TextChanged" AutoPostBack="true"
                                                Width="200px" MaxLength="50" runat="server" Text='<%# Bind("AccNo") %>'></asp:TextBox>
                                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtedsadndertxtAccNoerewr"
                                                ValidChars="0123456789-" TargetControlID="txtAccNo"></asp:FilteredTextBoxExtender>
                                            <asp:Label ID="lblAcc" runat="server" Text=""></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator386752345sadasxz6788" runat="server"
                                                ControlToValidate="txtAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            <asp:Label ID="lblAccount" runat="server" Text=""></asp:Label>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Customer Name" ShowHeader="true">
                                        <ItemTemplate>
                                            <span>
                                                <%# Eval("CustomerName")%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtCustomerName" Width="200px" MaxLength="40" runat="server" Text='<%# Bind("CustomerName") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator334245ghgfxcv7457" runat="server"
                                                ControlToValidate="txtCustomerName" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtCustomerName" Width="200px" MaxLength="40" runat="server" Text='<%# Bind("CustomerName") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3867523sadas456788" runat="server"
                                                ControlToValidate="txtCustomerName" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Txn Date Time" HeaderStyle-Wrap="false">
                                        <ItemTemplate>
                                            <%-- <%# (DateTime.Parse(Eval("TxnDate").ToString())).ToString("dd/MM/yyyy HH:mm") %>--%>
                                            <asp:Label ID="lblTxnDateTime" runat="server" Text='<%# (DateTime.Parse(Eval("TxnDate").ToString())).ToString("dd/MM/yyyy HH:mm") %>'></asp:Label>

                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtTxnDate" Width="200px" MaxLength="30" Class="DateTime1" runat="server"
                                                Text='<%# Bind("TxnDate","{0:dd/MM/yyyy HH:mm}") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator334245fgdfg7457" runat="server"
                                                ControlToValidate="txtTxnDate" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtTxnDate" Class="DateTime1" Width="200px" MaxLength="30" runat="server"
                                                Text='<%# Bind("TxnDate","{0:dd/MM/yyyy HH:mm}") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3867523asdasd456788" runat="server"
                                                ControlToValidate="txtTxnDate" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        </InsertItemTemplate>
                                        <HeaderStyle Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Txn Amount" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("TxnAmount")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtTxnAmount" Width="200px" MaxLength="15" runat="server" Text='<%# Bind("TxnAmount") %>'></asp:TextBox>
                                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo33qwe3"
                                                ValidChars="0123456789." TargetControlID="txtTxnAmount"></asp:FilteredTextBoxExtender>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33424wewew57457" runat="server"
                                                ControlToValidate="txtTxnAmount" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtTxnAmount" Width="200px" MaxLength="19" runat="server" Text='<%# Bind("TxnAmount") %>'></asp:TextBox>
                                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendsdasertxtAccNoerewr"
                                                ValidChars="0123456789." TargetControlID="txtTxnAmount"></asp:FilteredTextBoxExtender>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator38675234asdass56788" runat="server"
                                                ControlToValidate="txtTxnAmount" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Dispute Amount" ShowHeader="true">
                                        <ItemTemplate>

                                            <%# Eval("DisputeAmount")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDisputeAmount" Width="200px" ForeColor="Red" MaxLength="15" runat="server" Text='<%# Bind("DisputeAmount") %>'></asp:TextBox>
                                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtende744rtxtAccNo33qwe3"
                                                ValidChars="0123456789." TargetControlID="txtDisputeAmount"></asp:FilteredTextBoxExtender>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33424wewe555w57457" runat="server"
                                                ControlToValidate="txtDisputeAmount" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            <div>
                                                Suppose you instructed ATM to widthdraw tk 1500 
                            but you received tk 1000. In this case dispute amount will be 
                            tk 500. If you did not receive any amount than dispute 
                            amount will be tk 1500.
                                            </div>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtDisputeAmount" Width="200px" ForeColor="Red" MaxLength="15" runat="server" Text='<%# Bind("DisputeAmount") %>'></asp:TextBox>
                                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtende744rtxtAccNo33qwe3"
                                                ValidChars="0123456789." TargetControlID="txtDisputeAmount"></asp:FilteredTextBoxExtender>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33424wewe555w57457" runat="server"
                                                ControlToValidate="txtDisputeAmount" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            <div>
                                                Suppose you instructed ATM to widthdraw tk 1500 
                            but you received tk 1000. In this case dispute amount will be 
                            tk 500. If you did not receive any amount than dispute 
                            amount will be tk 1500.
                                            </div>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Acquirer Bank" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("BankName")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="cboBanks" DataSourceID="SqlDataSource1" DataValueField="Bank_Code"
                                                DataTextField="Bank_Name" runat="server" SelectedValue='<%# Bind("BankCode")  %>'
                                                AppendDataBoundItems="true" AutoPostBack="false">
                                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:DropDownList ID="cboBanks" DataSourceID="SqlDataSource1" DataValueField="Bank_Code"
                                                DataTextField="Bank_Name" runat="server" SelectedValue='<%# Bind("BankCode")  %>'
                                                AppendDataBoundItems="true" AutoPostBack="false">
                                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                            </asp:DropDownList>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Stan/Trace No" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("TraceNo")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtTraceNo" Width="200px" OnTextChanged="txtTraceNo_TextChanged"
                                                AutoPostBack="true" MaxLength="15" runat="server" Text='<%# Bind("TraceNo") %>'></asp:TextBox>
                                            <asp:Label runat="server" ID="lblTraceNo" Text=""> </asp:Label>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator334sdsd2457457" runat="server"
                                ControlToValidate="txtTraceNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>--%>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtTraceNo" Width="200px" OnTextChanged="txtTraceNo_TextChanged"
                                                AutoPostBack="true" MaxLength="19" runat="server" Text='<%# Bind("TraceNo") %>'></asp:TextBox>
                                            <asp:Label runat="server" ID="lblTraceNo" Text=""> </asp:Label>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator386752345xcwsw6788" runat="server"
                                ControlToValidate="txtTraceNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>--%>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approval Code" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("ApprovalCode")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtApprovalCode" OnTextChanged="txtApprovalCode_TextChanged" AutoPostBack="true"
                                                Width="200px" MaxLength="20" runat="server" Text='<%# Bind("ApprovalCode") %>'></asp:TextBox>
                                            <asp:Label runat="server" ID="lblApprovalCode" Text=""> </asp:Label>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator334245127457" runat="server"
                                ControlToValidate="txtApprovalCode" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>--%>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtApprovalCode" OnTextChanged="txtApprovalCode_TextChanged" AutoPostBack="true"
                                                Width="200px" MaxLength="20" runat="server" Text='<%# Bind("ApprovalCode") %>'></asp:TextBox>
                                            <asp:Label runat="server" ID="lblApprovalCode" Text=""> </asp:Label>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3867523asdcxc456788" runat="server"
                                ControlToValidate="txtApprovalCode" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>--%>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Terminal ID" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("TerminalID")%>
                                            <%-- <div style="color:gray"><%# Eval("ATM_BranchName")%></div>--%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtTerminalID"
                                                Width="200px" MaxLength="20" runat="server" Text='<%# Bind("TerminalID") %>'></asp:TextBox>
                                            <asp:Label runat="server" ID="lblTerminalID" Text=""> </asp:Label>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator334245fg7457" runat="server"
                                ControlToValidate="txtTerminalID" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>--%>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtTerminalID"
                                                Width="200px" MaxLength="20" runat="server" Text='<%# Bind("TerminalID") %>'></asp:TextBox>
                                            <asp:Label runat="server" ID="lblTerminalID" Text=""> </asp:Label>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator38675234dxcxzweq56788" runat="server"
                                ControlToValidate="txtTerminalID" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>--%>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="NPSB/QDMS Code" ShowHeader="true">
                                        <ItemTemplate>
                                            <%# Eval("NPSBCode")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtNPSBCode" OnTextChanged="txtNPSBCode_TextChanged" AutoPostBack="true"
                                                Width="200px" MaxLength="50" runat="server" Text='<%# Bind("NPSBCode") %>'></asp:TextBox>
                                            <asp:Label runat="server" ID="lblNPSBCode" Text=""> </asp:Label>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3342457fgfg457" runat="server"
                                ControlToValidate="txtNPSBCode" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>--%>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="txtNPSBCode" OnTextChanged="txtNPSBCode_TextChanged" AutoPostBack="true"
                                                Width="200px" MaxLength="20" runat="server" Text='<%# Bind("NPSBCode") %>'></asp:TextBox>
                                            <asp:Label runat="server" ID="lblNPSBCode" Text=""> </asp:Label>
                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3867523asdqwew456788" runat="server"
                                ControlToValidate="txtNPSBCode" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>--%>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Insert Info" ShowHeader="true" InsertVisible="false">
                                        <ItemTemplate>
                                            <uc2:EMP ID="EMP214" Username='<%# Eval("InsertBy") %>' runat="server" />
                                            <span class="time-small" title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                                <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Auth Info" ShowHeader="true" InsertVisible="false">
                                        <ItemTemplate>
                                            <%--<%# (bool)Eval("Authorize") ? "<img src='Images/tick.png' width='16' >" : "" %>--%>
                                            <uc2:EMP ID="EMPAuthBy" runat="server" Username='<%# Eval("AuthBY") %>' />
                                            <span title='<%# Eval("AuthDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                                <%# TrustControl1.ToRecentDateTime(Eval("AuthDT"))%>
                                                <time class="timeago time-small-gray" datetime='<%# Eval("AuthDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Verify Info" ShowHeader="true" InsertVisible="false">
                                        <ItemTemplate>
                                            <uc2:EMP ID="EMPUpdateBy" runat="server" Username='<%# Eval("UpdateBY") %>' />
                                            <span title='<%# Eval("UpdateDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                                <%# TrustControl1.ToRecentDateTime(Eval("UpdateDT"))%>
                                                <time class="timeago time-small-gray" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approve Info" ShowHeader="true" InsertVisible="false">
                                        <ItemTemplate>
                                            <%-- <%# (bool)Eval("Approve") ? "<img src='Images/tick.png' width='16' >" : "" %>--%>
                                            <uc2:EMP ID="EMPApproveBy" runat="server" Username='<%# Eval("ApproveBY") %>' />
                                            <span title='<%# Eval("ApproveDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                                <%# TrustControl1.ToRecentDateTime(Eval("ApproveDT"))%>
                                                <time class="timeago time-small-gray" datetime='<%# Eval("ApproveDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Posting Info" ShowHeader="true" InsertVisible="false">
                                        <ItemTemplate>
                                            <uc2:EMP ID="EMPPostingBy" runat="server" Username='<%# Eval("PostingBY") %>' />
                                            <span title='<%# Eval("PostingDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                                <%# TrustControl1.ToRecentDateTime(Eval("PostingDT"))%>
                                                <time class="timeago time-small-gray" datetime='<%# Eval("PostingDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Flora Info(Dispute Posting)" InsertVisible="false" SortExpression="TraceNo">
                                        <ItemTemplate>
                                            <%# Eval("FloraTransactionNumber","Trans No:{0}<br />") %>
                                            <%# Eval("FloraTranDT","Trans Date:{0:dd/MM/yyyy}")%>
                                            <span class="time-small" title='<%# Eval("FloraTranDT", "{0:dddd, dd MMMM yyyy}")%>'>
                                                <time class="timeago" datetime='<%# Eval("FloraTranDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                            </span>
                                            <%# Eval("amount_tk","Amount:<b>{0}</b><br />")%>
                                            <%# Eval("remark","Remark:{0} <br />").Trim()%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Wrap="true" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Last Status" ShowHeader="true" InsertVisible="false">
                                        <ItemTemplate>
                                            <%--<%# Eval("StatusName")%>--%>
                                            <asp:Label ID="lblStatusName" Font-Bold="true" runat="server" Text='<%# Eval("StatusName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="true" Font-Size="Larger" ForeColor="Red" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Authorize" ShowHeader="true" Visible="false" InsertVisible="false">
                                        <ItemTemplate>
                                            <%# Eval("Authorize")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approve" ShowHeader="true" Visible="false" InsertVisible="false">
                                        <ItemTemplate>
                                            <%# Eval("Approve")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ControlStyle-Width="80px">
                                        <EditItemTemplate>
                                            <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="Update" />
                                            <asp:ConfirmButtonExtender ID="conUpdate" runat="server" ConfirmText="Do you want to Update?"
                                                TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                            &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel" />
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:Button ID="cmdInsert" runat="server" CausesValidation="True" CommandName="Insert"
                                                Text="Save" />
                                            <asp:ConfirmButtonExtender ID="conInsert" runat="server" ConfirmText="Do you want to Save?"
                                                TargetControlID="cmdInsert"></asp:ConfirmButtonExtender>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Button ID="cmdEdit" runat="server" CausesValidation="False" CommandName="Edit" Visible='<%# Eval("StatusName").ToString()=="Close"?false:true %>'
                                                Text="Edit" />
                                        </ItemTemplate>
                                        <ControlStyle Width="80px" />
                                    </asp:TemplateField>
                                </Fields>
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle />
                                <EmptyDataTemplate>
                                    No Data Found.
                                </EmptyDataTemplate>
                                <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" />
                                <FooterStyle BackColor="#CCCC99" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle VerticalAlign="Top" BackColor="#F7F7DE" />
                            </asp:DetailsView>
                            <br />
                            <asp:SqlDataSource ID="SqlDataSourceDispute" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="s_Dispute_Select" SelectCommandType="StoredProcedure" InsertCommand="s_Dispute_add_edit"
                                OnSelected="SqlDataSourceDispute_Selected" InsertCommandType="StoredProcedure"
                                UpdateCommand="s_Dispute_add_edit" UpdateCommandType="StoredProcedure" OnDeleted="SqlDataSourceDispute_Deleted"
                                OnInserted="SqlDataSourceDispute_Inserted" OnUpdated="SqlDataSourceDispute_Updated">
                                <SelectParameters>
                                    <%-- <asp:QueryStringParameter QueryStringField="ID" Name="ID" />--%>
                                    <asp:ControlParameter ControlID="HidDisputeID" Name="ID" PropertyName="Value" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ID" Type="Int32" Direction="InputOutput" DefaultValue="0" />
                                    <asp:Parameter Name="Type" Type="String" />
                                    <asp:Parameter Name="CardNo" Type="String" />
                                    <asp:Parameter Name="AccNo" Type="String" />
                                    <asp:Parameter Name="CustomerName" Type="String" />
                                    <asp:Parameter Name="TxnDate" Type="DateTime" />
                                    <asp:Parameter Name="TxnAmount" Type="Decimal" />
                                    <asp:Parameter Name="DisputeAmount" Type="Decimal" />
                                    <asp:Parameter Name="TraceNo" Type="String" />
                                    <asp:Parameter Name="ApprovalCode" Type="String" />
                                    <asp:Parameter Name="TerminalID" Type="String" />
                                    <asp:Parameter Name="BankCode" Type="String" />
                                    <asp:Parameter Name="NPSBCode" Type="String" />
                                    <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                                    <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                                    <asp:SessionParameter Name="RequestBranchID" SessionField="BranchID" Type="Int32" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="ID" Type="Int32" Direction="InputOutput" />
                                    <asp:Parameter Name="Type" Type="String" />
                                    <asp:Parameter Name="CardNo" Type="String" />
                                    <asp:Parameter Name="AccNo" Type="String" />
                                    <asp:Parameter Name="CustomerName" Type="String" />
                                    <asp:Parameter Name="TxnDate" Type="DateTime" />
                                    <asp:Parameter Name="TxnAmount" Type="Decimal" />
                                    <asp:Parameter Name="DisputeAmount" Type="Decimal" />
                                    <asp:Parameter Name="TraceNo" Type="String" />
                                    <asp:Parameter Name="ApprovalCode" Type="String" />
                                    <asp:Parameter Name="TerminalID" Type="String" />
                                    <asp:Parameter Name="BankCode" Type="String" />
                                    <asp:Parameter Name="NPSBCode" Type="String" />
                                    <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                                    <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                                    <asp:SessionParameter Name="RequestBranchID" SessionField="BranchID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </div>
                    </td>
                    <td valign="top">
                        <div class="group" runat="server" id="divFlora" visible="false">
                            <h5>Flora Transaction in Dispute Date</h5>
                            <asp:GridView ID="GridView2" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                                DataKeyNames="traceno" DataSourceID="SqlDataSourceFlora" BackColor="White" BorderColor="#DEDFDE"
                                BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True">
                                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                                <RowStyle BackColor="#F7F7DE" />
                                <Columns>
                                    <asp:TemplateField HeaderText="SL">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="traceno" HeaderText="Transaction Number" SortExpression="traceno" />--%>
                                    <asp:TemplateField HeaderText="Transaction Number" SortExpression="traceno" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <b><a title="Open" target="_blank" href='<%# "https://intraweb.tblbd.com/intraReport/Acc_Trn_Details.aspx?trn=" + Eval("traceno") %>'
                                                class="HoverLink">
                                                <%# Eval("traceno") %></a></b>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="System Date">
                                        <ItemTemplate>
                                            <div>
                                                <%# Eval("tsysdate","{0:dd/MM/yyyy}") %><br />
                                                <%# Eval("SysDay") %>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Transaction Date">
                                        <ItemTemplate>
                                            <div>
                                                <%# Eval("tdate","{0:dd/MM/yyyy}") %><br />
                                                <%# Eval("TxnDay") %>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="dr_cr" HeaderText="Dr/Cr" SortExpression="dr_cr" />
                                    <asp:BoundField DataField="amount_tk" HeaderText="Amount" SortExpression="amount_tk" />
                                </Columns>
                                <EmptyDataTemplate>
                                    No Data Found.
                                </EmptyDataTemplate>
                                <FooterStyle BackColor="#CCCC99" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" Font-Size="X-Large" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>

                            <asp:SqlDataSource ID="SqlDataSourceFlora" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="s_GetFloraTransactionsForDispute" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <%-- <asp:QueryStringParameter QueryStringField="ID" Name="ID" />--%>
                                    <asp:ControlParameter ControlID="HidDisputeID" Name="ID" PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                        </div>
                        <br />
                        <div class="group" runat="server" id="divNotice">
                            <h5>Status Details</h5>
                            <table border="1" style="font-family: Verdana">
                                <tr>
                                    <td>1</td>
                                    <td>Successful</td>
                                    <td>Transaction was successful and card holder has received money during the transaction.</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Unsuccessful</td>
                                    <td>Transaction was unsuccessful and dispute amount will credited to customer account soon.</td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>On process</td>
                                    <td>Dispute investigation is on process, HEAD OFFICE will update accordingly.</td>
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td>Close</td>
                                    <td>Case is close</td>
                                </tr>
                                <tr>
                                    <td>5</td>
                                    <td>Reject</td>
                                    <td>Case is rejected due to incorrect data or HEAD OFFICE didn’t find such transaction (In this case branch have to recheck the issue at their end)</td>
                                </tr>
                                <tr>
                                    <td>6</td>
                                    <td>Date expired</td>
                                    <td>Case is more than 45 days old. And transaction data may not be found.</td>
                                </tr>
                            </table>

                        </div>

                        <div class="group" runat="server" id="div1" visible="false">
                            <h5>Dispute Print Log</h5>
                            <asp:GridView ID="GridView3" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                                DataSourceID="SqlDataSourceDisputePrint" BackColor="White" BorderColor="#DEDFDE"
                                BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True">
                                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                                <RowStyle BackColor="#F7F7DE" />
                                <Columns>
                                    <asp:TemplateField HeaderText="SL">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Print By" SortExpression="PrintBY">
                                        <ItemTemplate>
                                            <uc2:EMP ID="EMP33" Username='<%# Eval("PrintBY") %>' runat="server" />
                                            <span class="time-small" title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                                <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Branch" SortExpression="BranchID">
                                        <ItemTemplate>
                                            <%# Eval("BranchID") %>
                                            <uc3:Branch ID="Branch33" Username='<%# Eval("BranchID") %>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    No Data Found.
                                </EmptyDataTemplate>
                                <FooterStyle BackColor="#CCCC99" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" Font-Size="X-Large" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>

                            <asp:SqlDataSource ID="SqlDataSourceDisputePrint" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="s_Dispute_Print_Log" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HidDisputeID" Name="ID" PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                        </div>
                        <br />

                    </td>
                </tr>
            </table>


            <asp:Panel runat="server" ID="panelVisible" Visible="false">
                <div class="group">
                    <h5>Commnets</h5>

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="s_bank_select" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                    <div class="row" style="display: table; margin: 15px 0; min-width: 200px; border: 1px solid gray; border-radius: 4px; margin: 10px">
                        <div style="color: red">*** Please attach customer filled-up request form as pdf.</div>
                        <div class="group-body">
                            <div class="pointer attachmentAdd bold">
                                <asp:LinkButton runat="server" ID="cmdAddAttach" CausesValidation="false" OnClick="cmdAddAttach_Click">
                            <img src="Images/add-files.png" width="20px" />Add Files</asp:LinkButton>
                            </div>
                            <div style="padding: 5px">
                                <asp:DataList ID="DataList1" runat="server" CellPadding="0" DataKeyField="AID" DataSourceID="SqlDataSourceAttachments"
                                    RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="attachment-list" BorderWidth="0px"
                                    Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" HorizontalAlign="Center" ShowFooter="False" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Image runat="server" CssClass="AttachmentThumb" LoadImg='<%# getLinkImage(Eval("AID"),Eval("FileID"),Eval("Extension")) %>'
                                            ImageUrl="~/Images/Loading.gif" ID="Image1" border="0" BorderColor="Silver" BorderStyle="Solid" />
                                        <asp:HoverMenuExtender ID="Image1_HoverMenuExtender" runat="server" DynamicServicePath=""
                                            Enabled="True" PopupControlID="AttachmentMenu" TargetControlID="Image1" CacheDynamicResults="True"
                                            OffsetX="30" OffsetY="7" PopDelay="50" HoverDelay="300">
                                        </asp:HoverMenuExtender>
                                        <asp:Panel ID="AttachmentMenu" runat="server" BorderColor="Gray" BorderWidth="1px"
                                            Width="120px" Style="padding: 5px; text-align: left;" CssClass="ui-corner-all Shadow Panel1">
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
                                                <asp:HyperLink ID="HyperLink1" CssClass="link" runat="server" NavigateUrl='<%# "Attachment.ashx?aid=" + Eval("AID") + "&key=" + Eval("FileID") %>'
                                                    Font-Size="10pt" Style="color: blue" ToolTip='<%# Eval("FileName") %>'><b>Download</b></asp:HyperLink>
                                            </div>
                                            <div style="font-size: 7pt">
                                                <%# "<b>" + FileSize(Eval("FileSize")) + "</b><br /><span style=\"color:Gray\"><b>Upload On:</b><br>" + Common.ToRecentDateTime(Eval("InsertDT")) + "<br>" + "<time class='timeago' datetime='" + Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") + "'></time>" + "</span>"%>
                                            </div>
                                            <asp:LinkButton ID="cmdDeleteAttachment" CssClass="link" CommandName="DELETE" Font-Bold="true"
                                                CommandArgument='<%# Eval("AID") %>' runat="server" CausesValidation="False"
                                                Text="Delete" OnClick="cmdDeleteAttachment_Click" Enabled="true" Visible="true"
                                                Style="color: #CC0000"></asp:LinkButton>
                                            <asp:ConfirmButtonExtender ID="cmdDeleteAttachment_ConfirmButtonExtender" runat="server"
                                                ConfirmText="Are you sure you want to Delete?" Enabled="True" TargetControlID="cmdDeleteAttachment"></asp:ConfirmButtonExtender>
                                        </asp:Panel>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="SqlDataSourceAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                    SelectCommand="SELECT * FROM v_Attachments_Browse WHERE (SessionID = @SessionID)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HidPageID" Name="SessionID" PropertyName="Value"
                                            Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </div>


                        <div class="row">
                            <div style="float: left">
                                <asp:TextBox ID="txtCommentDtl" MaxLength="1000" TextMode="MultiLine" Rows="4" runat="server"
                                    Style="width: 550px;" ClientIDMode="Static"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div>

                                <asp:DropDownList ID="ddlStatusType" runat="server" AppendDataBoundItems="True" DataTextField="StatusName"
                                    DataValueField="StatusID" DataSourceID="SqlDataSourceStatus">
                                    <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddlStatusType"
                                    ValidationGroup="grpticketStatus" SetFocusOnError="True" runat="server" ForeColor="Red"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                    SelectCommand="SELECT * FROM dbo.DisputeStatus WHERE StatusName<>'New'" SelectCommandType="Text"></asp:SqlDataSource>
                            </div>
                        </div>
                        <div style="clear: left">
                        </div>
                        <div class="row">
                            <asp:Button ID="btnPostReply" runat="server" Text="Post Reply" ValidationGroup="grpticketStatus"
                                OnClick="btnPostReply_Click" />

                        </div>
                    </div>


                    <asp:HiddenField ID="hidSlNo" runat="server" Value="" />

                    <div style="max-width: 800px">
                        <asp:GridView ID="grdvComment" runat="server" DataKeyNames="ID" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSourceComments" CssClass="Grid" BorderStyle="None" BackColor="White"
                            ShowHeader="true" AllowPaging="false" AllowSorting="false" EnableViewState="true"
                            BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                            OnRowDataBound="grdvComment_RowDataBound">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <%# Eval("StatusName")%>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="true" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <span class='bold' title='<%# Eval("CID") %>'>
                                            <%# Eval("Remarks").ToString().Replace("\n", "<br />")%>
                                        </span>
                                        <asp:Literal ID="litAttach" runat="server" EnableViewState="true"></asp:Literal>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Posted on" SortExpression="DT">
                                    <ItemTemplate>
                                        <span title='<%# Eval("DT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                            <%# TrustControl1.ToRecentDateTime( Eval("DT")) %><br />
                                            <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="By" SortExpression="InsertBY">
                                    <ItemTemplate>


                                        <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBY") %>' />

                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                            <FooterStyle BackColor="#CCCC99" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceComments" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_Comments_Select" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceComments_Selected">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HidDisputeID" Name="DisputeID" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="group" runat="server" id="divdischanghistory">
                    <h5>Dispute Information Change History</h5>

                    <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                        DataKeyNames="Serial" DataSourceID="SqlDataSource2" BackColor="White" BorderColor="#DEDFDE"
                        BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                        RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True">
                        <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                        <RowStyle BackColor="#F7F7DE" />
                        <Columns>
                            <asp:TemplateField HeaderText="#" SortExpression="Serial">
                                <ItemTemplate>
                                    <%# Eval("Serial")%></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="A/C Info" SortExpression="AccNo">
                                <ItemTemplate>
                                    <%# Eval("Type","Trns Type:<b>{0}</b><br>") %>
                                    <%# Eval("AccNo","<b>{0}</b><br>") %>
                                    <%# Eval("CustomerName", "{0}<br>")%>
                                    <div style="color: Silver; font-size: 85%">
                                        <%# Eval("CardNumber", "Card: {0}")%>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Trans Info" SortExpression="TxnDate">
                                <ItemTemplate>
                                    <%# Eval("TxnDate","Txn Date:{0:dd/MM/yyyy}<br>") %>
                                    <%# Eval("TxnAmount","Txn Amount:{0}<br>")%>
                                    <%# Eval("DisputeAmount","Dispute Amount:<b>{0}</b><br>")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# Eval("StatusName")%>
                                </ItemTemplate>
                                <ItemStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Others Info" SortExpression="TraceNo">
                                <ItemTemplate>
                                    <%# Eval("TraceNo","Trace No:{0}<br>") %>
                                    <%# Eval("ApprovalCode","Approval Code:{0}<br>")%>
                                    <%# Eval("TerminalID","Terminal ID:{0}<br>")%>
                                    <%# Eval("NPSBCode","NPSBCode:{0}<br>")%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Acquirer Bank">
                                <ItemTemplate>
                                    <%# Eval("Bank_Name")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Request Info" SortExpression="InsertBy">
                                <ItemTemplate>
                                    <span title="insert info">Request by:</span>
                                    <uc2:EMP ID="EMP214" Username='<%# Eval("InsertBy") %>' runat="server" />
                                    <span class="time-small" title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                        <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                    </span>
                                    <br />
                                    <span style="color: Silver; font-size: 85%">
                                        <%# Eval("BranchName","{0}<br>")%>
                                    </span>
                                    <span runat="server" id="divauth" title="Auth Info" visible='<%# (Eval("Authorize").ToString().ToUpper() == "FALSE" ? false:true) %>'>Authorised:
                                        <span><%# Eval("Authorize").ToString().ToUpper() == "TRUE" ? "<img src='Images/tick.png' width='18' >" : "" %></span>
                                        <uc2:EMP ID="EMP247572" Username='<%# Eval("AuthBY") %>'
                                            runat="server" />
                                        <span class="time-small" title='<%# Eval("AuthDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("AuthDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </span>
                                    <span runat="server" id="divposting" title="Posting from branch" visible='<%# (Eval("PostingBY").ToString().ToUpper() == ""?false:true) %>'>Posting By:<br>
                                        <uc2:EMP ID="EMP124234" Username='<%# Eval("PostingBY") %>' runat="server" />
                                        <span class="time-small" title='<%# Eval("PostingDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("PostingDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Verify Info" SortExpression="UpdateBy">
                                <ItemTemplate>
                                    <span runat="server" id="divupdate" title="Verify info" visible='<%# (Eval("UpdateBy").ToString().ToUpper() == ""?false:true) %>'>Verified by:<br>
                                        <uc2:EMP ID="EMP22" Username='<%# Eval("UpdateBy") %>' runat="server" />
                                        <span class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </span>
                                    <span runat="server" id="divApprove" title="Auth Info" visible='<%# (Eval("Approve").ToString().ToUpper() == "FALSE"?false:true) %>'>Approved: 
                                        <span><%# Eval("Authorize").ToString().ToUpper() == "TRUE"  ? "<img src='Images/tick.png' width='18' >" : "" %></span>
                                        <uc2:EMP ID="EMP24722572" Username='<%# Eval("ApproveBY") %>'
                                            runat="server" />
                                        <span class="time-small" title='<%# Eval("ApproveDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("ApproveDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>

                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="s_Dispute_Change_History" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource2_Selected">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HidDisputeID" Name="ID" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div style="height: 400px">
                </div>
            </asp:Panel>

            <span style="visibility: hidden">
                <asp:Button ID="cmdShow" runat="server" CausesValidation="False" />
                <asp:Button ID="cmdShowUpload" runat="server" CausesValidation="False" />
            </span>
            <asp:ModalPopupExtender PopupControlID="ModalPanel1" CancelControlID="ModalClose1"
                ID="modalUpload" runat="server" Enabled="True" TargetControlID="cmdShowUpload"
                PopupDragHandleControlID="ModalTitle1" BackgroundCssClass="ModalPopupBG" RepositionMode="RepositionOnWindowResizeAndScroll">
            </asp:ModalPopupExtender>
            <asp:Panel runat="server" ID="ModalPanel1" Width="610px" CssClass="ModalPanel">
                <div style="background-color: Green; border: 4px solid green">
                    <asp:Panel runat="server" ID="ModalTitle1" CssClass="MoveIcon" HorizontalAlign="Center"
                        Width="100%">
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
                                ThrobberID="myThrobber" Width="400" OnUploadedComplete="FileUpload1_UploadedComplete"
                                OnClientUploadComplete="UploadComplete" OnClientUploadError="UploadError" OnUploadedFileError="FileUpload1_UploadedFileError"
                                OnClientUploadStarted="AsyncFileUpload1_StartUpload" />

                            <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" /><br />
                            <asp:Label ID="lblUploadStatus" tblid="lblUploadStatus" runat="server" Text="" Style="font-size: small;">
                
                            </asp:Label>
                            <div style="display: none; margin-top: 20px" id="UploadBtn">
                                <asp:Button ID="cmdUpload" runat="server" Height="33px" UseSubmitBehavior="true"
                                    CausesValidation="false" Style="font-weight: 700" Text="Attach" Width="100px"
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
