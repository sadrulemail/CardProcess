<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NPSBView.aspx.cs" Inherits="NPSBView" %>--%>
<%--<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NPSBView.aspx.cs" Inherits="NPSBView" %>--%>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NPSBView.aspx.cs" Culture="en-NZ"
    Inherits="NPSBView" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="CSS/StyleSheet.css?rand=1" rel="stylesheet" type="text/css" />
    <title>Settlement View</title>
</head>
<body>
    <form id="form1" runat="server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                    AutoGenerateColumns="False" BackColor="White" PagerSettings-Position="TopAndBottom"
                    PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                    BorderWidth="1px" CellPadding="4" PageSize="20" PagerSettings-PageButtonCount="30"
                    DataSourceID="SqlDataSource1" ForeColor="Black" Style="font-size: small" EnableSortingAndPagingCallbacks="True">
                    <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                    <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                    <Columns>
                        <asp:BoundField DataField="request_type" HeaderText="Type" SortExpression="request_type"
                            ItemStyle-HorizontalAlign="Left" />
                        <%-- <asp:BoundField DataField="TransTypeCode" HeaderText="TransTypeCode" SortExpression="TransTypeCode"
                            ItemStyle-HorizontalAlign="Center" /> --%>
                        <asp:BoundField DataField="Transaction_Source" HeaderText="Source" SortExpression="Transaction_Source"/>
                        <%--<asp:BoundField DataField="SIC" HeaderText="SIC" SortExpression="SIC" />--%>
                        <asp:BoundField DataField="Description" HeaderText="MTI" SortExpression="Description" />
                        <%--<asp:BoundField DataField="RequestCategory" HeaderText="RequestCategory" SortExpression="RequestCategory"
                            ItemStyle-HorizontalAlign="Left" /> --%>
                        <asp:BoundField DataField="Msg_Code_Description" HeaderText="Msg Description" SortExpression="Msg_Code_Description"
                            ItemStyle-HorizontalAlign="Right" />
                        <%--<asp:BoundField DataField="MsgCode" HeaderText="MsgCode" SortExpression="MsgCode"
                            ItemStyle-HorizontalAlign="Right" /> --%>
                        <asp:BoundField DataField="RRN" HeaderText="RRN" SortExpression="RRN" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="AuthCode" HeaderText="Auth Code" SortExpression="AuthCode" />
                        <asp:BoundField DataField="MerchantName" HeaderText="Merchant" SortExpression="MerchantName"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="CardNumber" HeaderText="Card Number" SortExpression="CardNumber" />
                        <asp:BoundField DataField="LocalDt" HeaderText="Local Dt" SortExpression="LocalDt" ItemStyle-Wrap="false" DataFormatString="{0:dd/MM/yyyy<br>h:mm:ss tt}" HtmlEncode="false" />
                        <asp:BoundField DataField="CreationDate" HeaderText="Creation Date" SortExpression="CreationDate" ItemStyle-Wrap="false" DataFormatString="{0:dd/MM/yyyy<br>h:mm:ss tt}" HtmlEncode="false" />
                        <asp:BoundField DataField="TransactionAmount" HeaderText="Amount" SortExpression="TransactionAmount" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="ATM_ID" HeaderText="ATM ID" SortExpression="ATM_ID" />
                        <asp:BoundField DataField="Issuer" HeaderText="Issuer" SortExpression="Issuer" />
                        <asp:BoundField DataField="Acquirer" HeaderText="Acquirer" SortExpression="Acquirer" />
                        <asp:BoundField DataField="Parm_WHAT_TRX" HeaderText="Trx Type" SortExpression="Parm_WHAT_TRX" />
                        <asp:BoundField DataField="Parm_SRVC" HeaderText="SRVC" SortExpression="Parm_SRVC" />
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" />
                    <FooterStyle BackColor="#CCCC99" />
                    <EmptyDataTemplate>
                        No Activation Request Found.
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                </asp:GridView>
                <br />
                <asp:Label Font-Names="Arial" runat="server" ID="lblStatus" Text="" Font-Size="Small"></asp:Label>
                <br />
                <br />
                <asp:Button ID="cmdExport" runat="server" Text="Download as xlsx" Width="150px" Height="30px"
                    Visible="true" Font-Bold="true" OnClick="cmdExport_Click" />
                <br />
                <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_NPSB_View" OnSelected="SqlDataSource1_Selected" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="batchId" QueryStringField="batchId" Type="Int32"
                            DefaultValue="-1" />
                        <asp:QueryStringParameter Name="localdate" QueryStringField="date" Type="DateTime"
                            DefaultValue="1/1/1900" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="cmdExport" />
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
    </form>
</body>
</html>
