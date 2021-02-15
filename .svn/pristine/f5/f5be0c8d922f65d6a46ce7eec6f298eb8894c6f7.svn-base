<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Item_Count.aspx.cs" Inherits="Item_Count" EnableViewState="false" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Item Count
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            
            <table class="Panel1 ui-corner-all">
                <tr>
                    <td>
                        <b>Requested From:</b><br />
                        <asp:DropDownList ID="DropDownListBranch" runat="server" AppendDataBoundItems="true"
                            DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" AutoPostBack="true"
                            DataValueField="BranchID" OnDataBound="DropDownListBranch_DataBound">
                            <asp:ListItem Text="All Branch" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                            SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] ORDER BY [BranchName]">
                        </asp:SqlDataSource>
                    </td>
                    <td>
                        <b>Date Range:<br />
                        </b>
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" CausesValidation="True"
                            OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                            <asp:ListItem>Today</asp:ListItem>
                            <asp:ListItem>Yesterday</asp:ListItem>
                            <asp:ListItem>This Week</asp:ListItem>
                            <asp:ListItem>Last Week</asp:ListItem>
                            <asp:ListItem>This Month</asp:ListItem>
                            <asp:ListItem>Last Month</asp:ListItem>
                            <asp:ListItem>This Year</asp:ListItem>
                            <asp:ListItem>Last Year</asp:ListItem>
                            <asp:ListItem>Show All</asp:ListItem>
                            <asp:ListItem>Custom Range</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <b>From:<br />
                        </b>
                        <asp:TextBox ID="TextBox1" CssClass="Date" runat="server" Width="100px"></asp:TextBox>
                        
                        
                    </td>
                    <td>
                        <b>To:<br />
                        </b>
                        <asp:TextBox ID="TextBox2" CssClass="Date" runat="server" Width="100px"></asp:TextBox>
                        
                    </td>
                    <td valign="bottom">
                        <asp:Button ID="cmdShow" runat="server" CausesValidation="False" Height="25px" OnClick="cmdShow_Click"
                            Text="Show" Width="100px" Style="font-weight: 700" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="lblTitle" runat="server" Style="font-family: Arial, Helvetica, sans-serif;
                font-size: small; font-weight: 700"></asp:Label>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" EnableViewState="false"
                CssClass="Grid" BorderColor="#5D7B9D" BorderStyle="Solid" BorderWidth="2" DataSourceID="SqlDataSource1"
                ForeColor="#333333" Style="font-family: Arial, Helvetica, sans-serif; font-size: small"
                AllowSorting="True" OnDataBound="GridView1_DataBound" ShowFooter="True">
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="false" ForeColor="White" />
                <EditRowStyle BackColor="#999999" />
                <EmptyDataTemplate>
                    No Entry Found.
                </EmptyDataTemplate>
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField DataField="BranchName" HeaderText="Requested From" ReadOnly="True"
                        SortExpression="BranchName"></asp:BoundField>
                    <asp:BoundField DataField="Emp ID" HeaderText="Emp ID" SortExpression="Emp ID" />
                    <asp:BoundField DataField="Emp Name" HeaderText="Emp Name" SortExpression="Emp Name" />
                    <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Total Insert" HeaderText="New Card Requisition" ReadOnly="True"
                        ItemStyle-HorizontalAlign="Center" SortExpression="Total Insert">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Total Modify" HeaderText="New Card Requisition Modify" ReadOnly="True"
                        ItemStyle-HorizontalAlign="Center" SortExpression="Total Modify">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Total Reissue" HeaderText="Total Reissue" ReadOnly="True"
                        ItemStyle-HorizontalAlign="Center" SortExpression="Total Reissue">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                     <asp:BoundField DataField="Total Supplementary" HeaderText="Total Supplementary" ReadOnly="True"
                        ItemStyle-HorizontalAlign="Center" SortExpression="Total Supplementary">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            </asp:GridView>
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        ProviderName="<%$ ConnectionStrings:CardDataConnectionString.ProviderName %>"
        SelectCommand="[sp_ItemCount]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox1" Name="DateFrom" DefaultValue="01/01/1900"
                PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="TextBox2" Name="DateTo" PropertyName="Text" DefaultValue="01/01/1900"
                Type="DateTime" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListBranch" DefaultValue="" Name="BranchID"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
