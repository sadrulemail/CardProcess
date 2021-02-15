<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SettlementView.aspx.cs" Inherits="SettlementView" %>--%>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SettlementView.aspx.cs"
    Culture="en-NZ" Inherits="SettlementView" %>

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
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                    AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black"
                    AutoGenerateColumns="False" CssClass="Grid"
                    EnableSortingAndPagingCallbacks="True">
                    <Columns>
                        <%--<asp:BoundField DataField="SettlementID" HeaderText="SettlementID" 
                            SortExpression="SettlementID" InsertVisible="False" ReadOnly="True" />--%>
                        <asp:BoundField DataField="BankName" HeaderText="Bank Name" SortExpression="BankName"
                            ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="AccountNo" HeaderText="Account No" 
                            SortExpression="AccountNo" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount"
                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" />
                        <asp:BoundField DataField="DrCr" HeaderText="DrCr" SortExpression="DrCr" ItemStyle-HorizontalAlign="Center" />
                        <%--<asp:BoundField DataField="SessionID" HeaderText="SessionID" 
                            SortExpression="SessionID" />
                        <asp:BoundField DataField="SettlementFlag" HeaderText="SettlementFlag" 
                            SortExpression="SettlementFlag" />
                        <asp:BoundField DataField="InsertDT" HeaderText="InsertDT" 
                            SortExpression="InsertDT" />
                        <asp:BoundField DataField="InsertBy" HeaderText="InsertBy" 
                            SortExpression="InsertBy" />--%>
                        <asp:BoundField DataField="BatchID" HeaderText="Batch ID" 
                            SortExpression="BatchID" ItemStyle-HorizontalAlign="Center"  />
                        <%--<asp:BoundField DataField="DownloadDT" HeaderText="DownloadDT" 
                            SortExpression="DownloadDT" />
                        <asp:BoundField DataField="DownloadBy" HeaderText="DownloadBy" 
                            SortExpression="DownloadBy" />
                        <asp:BoundField DataField="DownloadBatchID" HeaderText="DownloadBatchID" 
                            SortExpression="DownloadBatchID" />--%>
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

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="select * from SettlementValue where BatchID = @batchId"
                    OnSelected="SqlDataSource1_Selected">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="batchId" QueryStringField="batchId" Type="Int32" />
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
    </form>
</body>
</html>

