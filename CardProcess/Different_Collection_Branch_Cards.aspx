<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Different_Collection_Branch_Cards.aspx.cs" Inherits="Different_Collection_Branch_Cards" %>

<%@ Register src="TrustControl.ascx" tagname="TrustControl" tagprefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
        Different Collection Branch Cards
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
<asp:UpdatePanel runat="server" ID="UpdatePanel1"><ContentTemplate>    
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
    AllowSorting="True" AutoGenerateColumns="False" BackColor="White" 
    BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
    DataKeyNames="ID" DataSourceID="SqlDataSource1"  CssClass="Grid" PagerSettings-Position="TopAndBottom"
    EnableSortingAndPagingCallbacks="True" ForeColor="Black" GridLines="Vertical" 
    style="font-size: small">
    <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
    <PagerSettings PageButtonCount="20" Mode="NumericFirstLast" />
    <Columns>
        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" 
            ReadOnly="True" SortExpression="ID" />
        <asp:BoundField DataField="Customer Name" HeaderText="Customer Name" 
            SortExpression="Customer Name" ItemStyle-HorizontalAlign="Left" />
        <asp:BoundField DataField="Account" HeaderText="Account" 
            SortExpression="Account" />
        <asp:BoundField DataField="ReqBranch" HeaderText="ReqBranch" 
            SortExpression="ReqBranch" />
        <asp:BoundField DataField="DeliveryToBranch" HeaderText="DeliveryToBranch" 
            SortExpression="DeliveryToBranch" />
        <asp:CheckBoxField DataField="SendToProcess" HeaderText="SendToProcess" 
            SortExpression="SendToProcess" />
         <asp:TemplateField HeaderText="InsertDT" SortExpression="InsertDT" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <span title='<%# Eval("InsertDT")%>'>
                                <%# TrustControl1.ToRelativeDate(Eval("InsertDT"))%></span></ItemTemplate>
                    </asp:TemplateField>
 
        <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" 
            SortExpression="BatchNo" />
    </Columns>
    <FooterStyle BackColor="#CCCC99" />
    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
    <AlternatingRowStyle BackColor="White" />
</asp:GridView>
<br />
    <asp:Label ID="lblRows" runat="server" Text="" style="font-size: small"></asp:Label>
</ContentTemplate></asp:UpdatePanel>
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
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" 
    
        SelectCommand="SELECT * FROM [v_Different_Collection_Branch_Cards] ORDER BY ID DESC" 
        onselected="SqlDataSource1_Selected">
</asp:SqlDataSource>
</asp:Content>

