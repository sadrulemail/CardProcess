<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Activation_Ready.aspx.cs"
    Culture="en-NZ" Inherits="Activation_Ready" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="CSS/StyleSheet.css?rand=1" rel="stylesheet" type="text/css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                    AllowPaging="true" PageSize="50" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Both"
                    AutoGenerateColumns="false" CssClass="Grid"
                    EnableSortingAndPagingCallbacks="True">
                    <Columns>
                        <asp:BoundField DataField="CardNumber" HeaderText="CardNumber" SortExpression="CardNumber" />
                        <asp:TemplateField HeaderText="Requsted By" SortExpression="Sent By" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BranchID" HeaderText="BranchID" SortExpression="BranchID"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="DT" HeaderText="DT" SortExpression="DT" />
                        <asp:TemplateField HeaderText="Requested" SortExpression="DT">
                            <ItemTemplate>
                                <%# TrustControl1.ToRelativeDate((DateTime)Eval("DT")) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" SortExpression="BatchNo"
                            ItemStyle-HorizontalAlign="Center" />
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
                    SelectCommand="SELECT * FROM [CardActivation] WHERE (([BatchNo] = 0) AND ([BranchID] = @BranchID)) ORDER BY DT DESC"
                    OnSelected="SqlDataSource1_Selected">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="BranchID" QueryStringField="branch" Type="Int32" />
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
