﻿<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReconciliationFile_Upload.aspx.cs" Inherits="ReconciliationFile_Upload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="InternationalTransactionView.aspx.cs" Inherits="InternationalTransactionView" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    International Transaction View
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server">

                <table class="Panel1 ui-corner-all" style="padding-left: 10px">
                    <tr>
                        <td>
                            <b>Client ID :</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSearch" runat="server" Width="150px"></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" Width="80px" CausesValidation="false"
                                OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>

            </asp:Panel>
            <div>
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"
                    OnSelectedIndexChanging="GridView1_SelectedIndexChanging" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                    AllowPaging="True" PageSize="10" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" AutoGenerateColumns="False"
                    CssClass="Grid" EnableSortingAndPagingCallbacks="True" DataKeyNames="ID" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="" HeaderStyle-Font-Bold="true">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="SELECT" CommandArgument='<%# Eval("ID") %>'
                                    Height="20px" ToolTip="Open" CausesValidation="false">
                                <img alt="" height="16px" width="16px" src='Images/new_window.png' border="0" />
                                </asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="BtnDelete" Visible='<%# Eval("Freeze").ToString().ToUpper() == "FALSE" && Eval("Deleted").ToString().ToUpper()=="FALSE" ? true : false %>'
                                    runat="server" CommandArgument='<%# Bind("ID") %>' CommandName="Delete1" ToolTip="Delete this trans">Single Delete
                                </asp:LinkButton>
                                <asp:ConfirmButtonExtender runat="server" ID="BtnDeleteewe" ConfirmText="Do you want to Delete?"
                                    TargetControlID="BtnDelete"></asp:ConfirmButtonExtender>
                                |
                                <asp:LinkButton ID="LinkButton2" Visible='<%# Eval("Freeze").ToString().ToUpper() == "FALSE" && Eval("Deleted").ToString().ToUpper()=="FALSE" ? true : false %>'
                                    runat="server" CommandArgument='<%# Bind("ID") %>' CommandName="DeleteAll" ToolTip="Delete all trans of this client">Delete(Client All Trans)
                                </asp:LinkButton>
                                <asp:ConfirmButtonExtender runat="server" ID="ConfirmButtonExtender1" ConfirmText="Do you want to Delete all trans of this client?"
                                    TargetControlID="LinkButton2"></asp:ConfirmButtonExtender>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="Batch" HeaderText="Batch"
                            SortExpression="Batch" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="YMID" HeaderText="YMID" SortExpression="YMID"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:CheckBoxField DataField="Freeze" HeaderText="Freeze" />
                        <asp:BoundField DataField="ClientID" HeaderText="Client ID" SortExpression="ClientID"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ClientName" HeaderText="Client Name"
                            SortExpression="ClientName" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ClientAddress" HeaderText="Client Address" SortExpression="ClientAddress"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="MobileNo" HeaderText="MobileNo" SortExpression="MobileNo"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="CardType" HeaderText="Card Type" SortExpression="CardType"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="PassportNumber" HeaderText="Passport Number" SortExpression="PassportNumber"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="PreviousPassportNumber" HeaderText="Previous Passport Number" SortExpression="PreviousPassportNumber"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="IssuePlace" HeaderText="Issue Place" SortExpression="IssuePlace"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ADSCode" HeaderText="ADS Code" SortExpression="ADSCode"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="PurposeCode" HeaderText="Purpose Code" SortExpression="PurposeCode"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="IssueDate" HeaderText="Issue Date" DataFormatString="{0:dd/MM/yyyy}"
                            SortExpression="IssueDate" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="PassportRenewalDate" HeaderText="Passport Renewal Date" SortExpression="PassportRenewalDate"
                            ItemStyle-HorizontalAlign="Left" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" SortExpression="ExpiryDate"
                            ItemStyle-HorizontalAlign="Left" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="BBApprovalNo" HeaderText="BB Approval No" SortExpression="BBApprovalNo"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ApprovalDate" HeaderText="Approval Date" SortExpression="ApprovalDate"
                            ItemStyle-HorizontalAlign="Left" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="RMEndDate" HeaderText="RM End Date" SortExpression="RMEndDate"
                            ItemStyle-HorizontalAlign="Left" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="PostingDate" HeaderText="Posting Date" SortExpression="PostingDate"
                            ItemStyle-HorizontalAlign="Left" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="TransactionDateTime" HeaderText="Transaction Date Time" SortExpression="TransactionDateTime"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="TerminalID" HeaderText="Terminal ID" SortExpression="TerminalID"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="SicCode" HeaderText="SIC Code" SortExpression="SicCode"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="CurrencyCode" HeaderText="Currency Code" SortExpression="CurrencyCode"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="CountryCode" HeaderText="Country Code" SortExpression="CountryCode"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="TransactionAmount" HeaderText="Transaction Amount" SortExpression="TransactionAmount"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="CardLimit" HeaderText="Card Limit" SortExpression="CardLimit"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="FCLimitNONSAARC" HeaderText="FC Limit NON SAARC" SortExpression="FCLimitNONSAARC"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="FCLimitSAARC" HeaderText="FC Limit SAARC" SortExpression="FCLimitSAARC"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="CategoryOfFC" HeaderText="Category Of FC" SortExpression="CategoryOfFC"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="EndorsementExpiryDate" HeaderText="Endorsement Expiry Date" SortExpression="EndorsementExpiryDate"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:TemplateField HeaderText="Insert By" SortExpression="InsertBy">
                            <ItemTemplate>
                                <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="InsertDT" HeaderText="Upload Date" SortExpression="InsertDT" DataFormatString="{0:dd-MMM-yyyy}"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:TemplateField HeaderText="Update By" SortExpression="UpdateBy">
                            <ItemTemplate>
                                <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("UpdateBy") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="UpdateDT" HeaderText="Update DT" SortExpression="UpdateDT" DataFormatString="{0:dd-MMM-yyyy}"
                            ItemStyle-HorizontalAlign="Center" />

                    </Columns>
                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                    <FooterStyle BackColor="#CCCC99" />
                    <EmptyDataTemplate>
                        No Record Found.
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                </asp:GridView>
                <br />

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_InternationalTransaction_Browse" SelectCommandType="StoredProcedure"
                    OnSelected="SqlDataSource1_Selected">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Batch" QueryStringField="batchId" Type="Int32" />
                        <asp:ControlParameter ControlID="txtSearch" Name="ClientID" PropertyName="Text" Type="String"
                            DefaultValue="ALL" />
                    </SelectParameters>

                </asp:SqlDataSource>

            </div>
            <%--  modal popup--%>
            <div>
                <span style="visibility: hidden">
                    <asp:Button runat="server" ID="cmdPopup" /></span>
                <asp:ModalPopupExtender ID="modal" runat="server" CancelControlID="ModalClose"
                    TargetControlID="cmdPopup"
                    PopupControlID="ModalPanel"
                    BackgroundCssClass="ModalPopupBG"
                    RepositionMode="None"
                    Y="0"
                    CacheDynamicResults="False"
                    Drag="true">
                </asp:ModalPopupExtender>
                <asp:Panel ID="ModalPanel" runat="server"
                    CssClass="Panel1 ui-corner-all"
                    ScrollBars="Vertical"
                    Height="95%">
                    <div style="padding: 0px">
                        <table width="100%" style="border-collapse: collapse">
                            <tr>
                                <td>
                                    <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                                        BorderStyle="Solid" BorderWidth="1px" CssClass="Grid" CellPadding="2" DataSourceID="SqlDataSource2"
                                        ForeColor="Black" AutoGenerateRows="False" DataKeyNames="ID" OnItemInserted="DetailsView1_ItemInserted"
                                        OnItemUpdated="DetailsView1_ItemUpdated" OnModeChanged="DetailsView1_ModeChanged"
                                        OnDataBound="DetailsView1_DataBound">
                                        <FooterStyle BackColor="#CCCC99" />
                                        <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" />
                                        <Fields>
                                            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID"
                                                ReadOnly="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Large">
                                                <ItemStyle Font-Bold="True" Font-Size="Large" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ClientID" HeaderText="Client ID (BANK_ACCOUNT_ID)" SortExpression="ClientID"
                                                ReadOnly="true" ItemStyle-Font-Bold="true" ItemStyle-Font-Size="Large">
                                                <ItemStyle Font-Bold="True" Font-Size="Large" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Client Name (CITIZEN_NAME)" SortExpression="ClientName">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtClientName" runat="server" Text='<%# Bind("ClientName") %>' Width="400px"
                                                        MaxLength="200"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtClientName" runat="server" Text='<%# Bind("ClientName") %>' Width="400px"
                                                        MaxLength="200"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("ClientName") %>
                                                </ItemTemplate>
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle Wrap="False" Font-Bold="true" Font-Size="Medium" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Client Address (ADDRESS)" SortExpression="ClientAddress">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtClientAddress" Font-Names="Arial" runat="server" Text='<%# Bind("ClientAddress") %>'
                                                        TextMode="MultiLine" Width="300px" Height="70px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtClientAddress" Font-Names="Arial" runat="server" Text='<%# Bind("ClientAddress") %>'
                                                        TextMode="MultiLine" Width="300px" Height="70px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("ClientAddress").ToString().Replace("\n", "<br>") %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mobile No (CONTACTNO)" SortExpression="MobileNo">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtMobileNo" Font-Names="Arial" runat="server" Text='<%# Bind("MobileNo") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtMobileNo" Font-Names="Arial" runat="server" Text='<%# Bind("MobileNo") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("MobileNo").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Card Type (CARD_TYPE)" SortExpression="CardType">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtCardType" Font-Names="Arial" runat="server" Text='<%# Bind("CardType") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtCardType" Font-Names="Arial" runat="server" Text='<%# Bind("CardType") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("CardType").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Passport Number (PP_NO)" SortExpression="PassportNumber">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtPassportNumber" Font-Names="Arial" runat="server" Text='<%# Bind("PassportNumber") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtPassportNumber" Font-Names="Arial" runat="server" Text='<%# Bind("PassportNumber") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("PassportNumber").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Previous Passport Number (PREVIOUS_PP_NO)" SortExpression="PreviousPassportNumber">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtPreviousPassportNumber" Font-Names="Arial" runat="server" Text='<%# Bind("PreviousPassportNumber") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtPreviousPassportNumber" Font-Names="Arial" runat="server" Text='<%# Bind("PreviousPassportNumber") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("PreviousPassportNumber").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Issue Place (ISSUE_PLACE)" SortExpression="IssuePlace">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtIssuePlace" Font-Names="Arial" runat="server" Text='<%# Bind("IssuePlace") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtIssuePlace" Font-Names="Arial" runat="server" Text='<%# Bind("IssuePlace") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("IssuePlace").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="ADS Code (ADSCODE)" SortExpression="ADSCode">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtADSCode" Font-Names="Arial" runat="server" Text='<%# Bind("ADSCode") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtADSCode" Font-Names="Arial" runat="server" Text='<%# Bind("ADSCode") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("ADSCode").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Purpose Code (PURPOSE_CODE)" SortExpression="PurposeCode">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtPurposeCode" Font-Names="Arial" runat="server" Text='<%# Bind("PurposeCode") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtPurposeCode" Font-Names="Arial" runat="server" Text='<%# Bind("PurposeCode") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("PurposeCode").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Issue Date (ISSUE_DATE)" SortExpression="IssueDate">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtIssueDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("IssueDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtIssueDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("IssueDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("IssueDate","{0:dd/MM/yyyy}").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Passport Renewal Date (RENEWAL_DATE)" SortExpression="PassportRenewalDate">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtPassportRenewalDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("PassportRenewalDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtPassportRenewalDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("PassportRenewalDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("PassportRenewalDate","{0:dd/MM/yyyy}").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Expiry Date (PP_EXPIRE_DATE)" SortExpression="ExpiryDate">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtExpiryDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("ExpiryDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtExpiryDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("ExpiryDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("ExpiryDate","{0:dd/MM/yyyy}").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="BB Approval No (BB_APPROVAL_NO)" SortExpression="BBApprovalNo">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtBBApprovalNo" Font-Names="Arial" runat="server" Text='<%# Bind("BBApprovalNo") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtBBApprovalNo" Font-Names="Arial" runat="server" Text='<%# Bind("BBApprovalNo") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("BBApprovalNo").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Approval Date (APPROVAL_DATE)" SortExpression="ApprovalDate">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtApprovalDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("ApprovalDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtApprovalDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("ApprovalDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("ApprovalDate","{0:dd/MM/yyyy}").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="RM End Date (RM_END_DATE)" SortExpression="RMEndDate">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtRMEndDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("RMEndDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtRMEndDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("RMEndDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("RMEndDate","{0:dd/MM/yyyy}").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Posting Date (SETTLEMENT_DATE)" SortExpression="PostingDate">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtPostingDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("PostingDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtPostingDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("PostingDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("PostingDate","{0:dd/MM/yyyy}").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Transaction Date Time (TRANSACTION_TIMESTAMP)" SortExpression="TransactionDateTime">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtTransactionDateTime" Font-Names="Arial" Class="DateTime1" runat="server" Text='<%# Bind("TransactionDateTime","{0:dd/MM/yyyy HH:mm:ss}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtTransactionDateTime" Font-Names="Arial" Class="DateTime1" runat="server" Text='<%# Bind("TransactionDateTime","{0:dd/MM/yyyy HH:mm:ss}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("TransactionDateTime","{0:dd/MM/yyyy HH:mm:ss}").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Terminal ID (MERCHANT_ID)" SortExpression="TerminalID">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtTerminalID" Font-Names="Arial" runat="server" Text='<%# Bind("TerminalID") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtTerminalID" Font-Names="Arial" runat="server" Text='<%# Bind("TerminalID") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("TerminalID").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SIC Code (MERC_CATEGORY_CODE)" SortExpression="SicCode">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtSicCode" Font-Names="Arial" runat="server" Text='<%# Bind("SicCode") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtSicCode" Font-Names="Arial" runat="server" Text='<%# Bind("SicCode") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("SicCode").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Currency Code (CURRENCY_CODE)" SortExpression="CurrencyCode">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtCurrencyCode" Font-Names="Arial" runat="server" Text='<%# Bind("CurrencyCode") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtCurrencyCode" Font-Names="Arial" runat="server" Text='<%# Bind("CurrencyCode") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("CurrencyCode").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Country Code (COUNTRY_CODE)" SortExpression="CountryCode">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtCountryCode" Font-Names="Arial" runat="server" Text='<%# Bind("CountryCode") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtCountryCode" Font-Names="Arial" runat="server" Text='<%# Bind("CountryCode") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("CountryCode").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Transaction Amount (EFFECTED_REMITTANCE)" SortExpression="TransactionAmount">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtTransactionAmount" Font-Names="Arial" runat="server" Text='<%# Bind("TransactionAmount") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtTransactionAmount" Font-Names="Arial" runat="server" Text='<%# Bind("TransactionAmount") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("TransactionAmount").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Card Limit (CARD_LIMIT)" SortExpression="CardLimit">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtCardLimit" Font-Names="Arial" runat="server" Text='<%# Bind("CardLimit") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtCardLimit" Font-Names="Arial" runat="server" Text='<%# Bind("CardLimit") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("CardLimit").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FC Limit NON SAARC (FC_LIMIT_NS)" SortExpression="FCLimitNONSAARC">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtFCLimitNONSAARC" Font-Names="Arial" runat="server" Text='<%# Bind("FCLimitNONSAARC") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtFCLimitNONSAARC" Font-Names="Arial" runat="server" Text='<%# Bind("FCLimitNONSAARC") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("FCLimitNONSAARC").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="FC Limit SAARC (FC_LIMIT_S)" SortExpression="FCLimitSAARC">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtFCLimitSAARC" Font-Names="Arial" runat="server" Text='<%# Bind("FCLimitSAARC") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtFCLimitSAARC" Font-Names="Arial" runat="server" Text='<%# Bind("FCLimitSAARC") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("FCLimitSAARC").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Category Of FC (CATEGORY_OF_FC)" SortExpression="CategoryOfFC">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtCategoryOfFC" Font-Names="Arial" runat="server" Text='<%# Bind("CategoryOfFC") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtCategoryOfFC" Font-Names="Arial" runat="server" Text='<%# Bind("CategoryOfFC") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("CategoryOfFC").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Endorsement Expiry Date (EXPIRY_DATE)" SortExpression="EndorsementExpiryDate">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtEndorsementExpiryDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("EndorsementExpiryDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:TextBox ID="txtEndorsementExpiryDate" Font-Names="Arial" Class="DateTime11" runat="server" Text='<%# Bind("EndorsementExpiryDate","{0:dd/MM/yyyy}") %>'
                                                        Width="300px"></asp:TextBox>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <%# Eval("EndorsementExpiryDate","{0:dd/MM/yyyy}").ToString() %>
                                                </ItemTemplate>
                                                <HeaderStyle VerticalAlign="Top" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Update By" SortExpression="UpdateDT" InsertVisible="false" Visible="false">
                                                <ItemTemplate>
                                                    <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("UpdateBy") %>' />
                                                    , On: <span title='<%# Eval("UpdateDT","{0:dddd, \ndd MMMM, yyyy \nh:mm:ss tt}") %>'>
                                                        <%# Common.ToRecentDateTime(Eval("UpdateDT"))%>
                                                        <span class="time-small" style="margin: 0px 15px 0px 5px">
                                                            <%# Common.ToRelativeDate(Eval("UpdateDT"))%></span> </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False" ControlStyle-Width="100px" Visible="false">
                                                <EditItemTemplate>
                                                    <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" CommandName="Update" Enabled='<%# Eval("Freeze").ToString().ToUpper() == "TRUE" ? false : true %>'
                                                        Text="Update" />
                                                    <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Do you want to Update?"
                                                        Enabled="True" TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                                    &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                        Text="Cancel" />
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Enabled='<%# Eval("Freeze").ToString().ToUpper() == "TRUE" ? false : true %>'
                                                        Text="Edit" />
                                                </ItemTemplate>
                                                <ControlStyle Width="100px" />
                                            </asp:TemplateField>
                                        </Fields>
                                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                        <AlternatingRowStyle BackColor="White" />
                                    </asp:DetailsView>
                                </td>
                                <td align="right" valign="top">
                                    <asp:Image ID="ModalClose" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close"
                                        Style="cursor: pointer" />
                                </td>
                            </tr>
                        </table>

                    </div>
                </asp:Panel>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_InternationalTransaction_Select" SelectCommandType="StoredProcedure" UpdateCommand="s_InternationalTransaction_Update"
                    UpdateCommandType="StoredProcedure" OnUpdated="SqlDataSource2_Updated">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ID" />
                        <asp:Parameter Name="ClientID" />
                        <asp:Parameter Name="ClientName" />
                        <asp:Parameter Name="ClientAddress" />
                        <asp:Parameter Name="MobileNo" />
                        <asp:Parameter Name="CardType" />
                        <asp:Parameter Name="PassportNumber" />
                        <asp:Parameter Name="PreviousPassportNumber" />
                        <asp:Parameter Name="IssuePlace" />
                        <asp:Parameter Name="ADSCode" />
                        <asp:Parameter Name="PurposeCode" />
                        <asp:Parameter Name="IssueDate" Type="DateTime" />
                        <asp:Parameter Name="PassportRenewalDate" Type="DateTime" />
                        <asp:Parameter Name="ExpiryDate" Type="DateTime" />
                        <asp:Parameter Name="BBApprovalNo" />
                        <asp:Parameter Name="ApprovalDate" Type="DateTime" />
                        <asp:Parameter Name="RMEndDate" Type="DateTime" />
                        <asp:Parameter Name="PostingDate" Type="DateTime" />
                        <asp:Parameter Name="TransactionDateTime" Type="DateTime" />
                        <asp:Parameter Name="TerminalID" />
                        <asp:Parameter Name="SicCode" />
                        <asp:Parameter Name="CurrencyCode" />
                        <asp:Parameter Name="CountryCode" />
                        <asp:Parameter Name="TransactionAmount" />
                        <asp:Parameter Name="CardLimit" />
                        <asp:Parameter Name="FCLimitNONSAARC" />
                        <asp:Parameter Name="FCLimitSAARC" />
                        <asp:Parameter Name="CategoryOfFC" />
                        <asp:Parameter Name="EndorsementExpiryDate" Type="DateTime" />
                        <asp:SessionParameter Name="UpdateBy" SessionField="EMPID" />
                        <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" DefaultValue="" Size="250" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <%--<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_InternationalTransaction_xml" SelectCommandType="StoredProcedure">                   
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Batch" QueryStringField="batchId" Type="Int32" />
                    </SelectParameters>                    
                </asp:SqlDataSource>--%>
                <br />
                <br />
            </div>
            <div class="group">
                <h5>International Transaction Summary</h5>
                <asp:GridView ID="GridView5" runat="server" AllowSorting="True" BackColor="White"
                    AllowPaging="True" PageSize="10" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource6" ForeColor="Black" AutoGenerateColumns="False"
                    CssClass="Grid" EnableSortingAndPagingCallbacks="True" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30">
                    <Columns>
                        <%--<asp:BoundField DataField="TotalRows" HeaderText="Total Rows" SortExpression="TotalRows"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" SortExpression="TotalAmount"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ReportRows" HeaderText="Active Rows" SortExpression="ReportRows"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ReportAmount" HeaderText="Active Amount" SortExpression="ReportAmount"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="DeletedRows" HeaderText="Deleted Rows" SortExpression="DeletedRows"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="DeletedAmount" HeaderText="Deleted Amount" SortExpression="DeletedAmount"
                            ItemStyle-HorizontalAlign="Left" />--%>
                        <asp:TemplateField HeaderText="#">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="Rows" HeaderText="Rows" SortExpression="Rows"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount"
                            ItemStyle-HorizontalAlign="Left" />
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                    <FooterStyle BackColor="#CCCC99" />
                    <EmptyDataTemplate>
                        No Record Found.
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_InternationalTransaction_Summary" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource6_Selected">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Batch" QueryStringField="batchId" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div class="group">
                <h5>Duplicate Transaction Time</h5>
                <asp:GridView ID="GridView2" runat="server" AllowSorting="True" BackColor="White"
                    AllowPaging="True" PageSize="10" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="Black" AutoGenerateColumns="False"
                    CssClass="Grid" EnableSortingAndPagingCallbacks="True" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30">
                    <Columns>
                        <asp:BoundField DataField="ClientID" HeaderText="Client ID" SortExpression="ClientID"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="TransactionDateTime" HeaderText="TransactionDateTime" SortExpression="TransactionDateTime"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total"
                            ItemStyle-HorizontalAlign="Left" />
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                    <FooterStyle BackColor="#CCCC99" />
                    <EmptyDataTemplate>
                        No Record Found.
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_InternationalTransaction_duplicatetime" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Batch" QueryStringField="batchId" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div class="group">
                <h5>Mandatory fields value missing list</h5>
                <asp:GridView ID="GridView3" runat="server" AllowSorting="True" BackColor="White"
                    AllowPaging="True" PageSize="10" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource4" ForeColor="Black" AutoGenerateColumns="False"
                    CssClass="Grid" EnableSortingAndPagingCallbacks="True" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30">
                    <Columns>
                        <asp:BoundField DataField="ClientID" HeaderText="Client ID" SortExpression="ClientID"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ClientName" HeaderText="Client Name" SortExpression="ClientName"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ErrorType" HeaderText="Error Type" SortExpression="ErrorType"
                            ItemStyle-HorizontalAlign="Left" />
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                    <FooterStyle BackColor="#CCCC99" />
                    <EmptyDataTemplate>
                        No Record Found.
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_InternationalTransactionMandatoryFieldsValueMissingList" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Batch" QueryStringField="batchId" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div class="group">
                <h5>Invalid Country Code list</h5>
                <asp:GridView ID="GridView4" runat="server" AllowSorting="True" BackColor="White"
                    AllowPaging="True" PageSize="10" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource5" ForeColor="Black" AutoGenerateColumns="False"
                    CssClass="Grid" EnableSortingAndPagingCallbacks="True" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30">
                    <Columns>
                        <asp:BoundField DataField="ClientID" HeaderText="Client ID" SortExpression="ClientID"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ClientName" HeaderText="Client Name" SortExpression="ClientName"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ITCL_CountryCode" HeaderText="ITCL Country Code" SortExpression="ITCL_CountryCode"
                            ItemStyle-HorizontalAlign="Left" />
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                    <FooterStyle BackColor="#CCCC99" />
                    <EmptyDataTemplate>
                        No Record Found.
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_InternationalTransactionInvalidContryCode" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Batch" QueryStringField="batchId" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>

            <div class="group">
                <h5>Summary Category Of FC</h5>
                <asp:GridView ID="GridView6" runat="server" AllowSorting="True" BackColor="White"
                    AllowPaging="True" PageSize="10" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource7" ForeColor="Black" AutoGenerateColumns="False"
                    CssClass="Grid" EnableSortingAndPagingCallbacks="True" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30">
                    <Columns>
                        <asp:BoundField DataField="CategoryOfFC" HeaderText="Category Of FC" SortExpression="CategoryOfFC"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total"
                            ItemStyle-HorizontalAlign="Left" />
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                    <FooterStyle BackColor="#CCCC99" />
                    <EmptyDataTemplate>
                        No Record Found.
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_InternationalTransactionCategoryOfFCSummary" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Batch" QueryStringField="batchId" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
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