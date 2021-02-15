<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ForwardingReport.aspx.cs" Inherits="ForwardingReport" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Forwarding Report
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server">
                <table class="Panel1 ui-corner-all">
                    <tr>
                        <td>
                            <b>Date Range:</b>
                            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" CausesValidation="True"
                                OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                <asp:ListItem>Today</asp:ListItem>
                                <asp:ListItem>Yesterday</asp:ListItem>
                                <asp:ListItem>This Week</asp:ListItem>
                                <asp:ListItem>Last Week</asp:ListItem>
                                <asp:ListItem>This Month</asp:ListItem>
                                <asp:ListItem>Last Month</asp:ListItem>
                                <asp:ListItem>This Year</asp:ListItem>
                                <asp:ListItem>Show All</asp:ListItem>
                                <asp:ListItem>Custom Range</asp:ListItem>
                            </asp:DropDownList>
                            <b>From:</b>
                            <asp:TextBox ID="TextBox1" CssClass="Date" runat="server" Width="100px"></asp:TextBox>
                            <b>To:
                            </b>
                            <asp:TextBox ID="TextBox2" CssClass="Date" runat="server" Width="100px"></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" Width="80px" CausesValidation="false"
                                OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <div class="group" runat="server" id="div2">
                <h5>Forwarding Report</h5>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                    AutoGenerateColumns="False" BackColor="White" BorderColor="#478ACA" BorderStyle="Solid"
                    BorderWidth="1px" CellPadding="5" DataSourceID="SqlDataSource2"
                    Style="font-size: small">
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" BorderColor="#478ACA" BorderStyle="Dotted"
                        BorderWidth="1px" VerticalAlign="Top" />
                    <PagerSettings Mode="NumericFirstLast" PageButtonCount="20" Position="TopAndBottom" />
                    <PagerStyle BackColor="#478ACA" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="#F7F7F7" BorderStyle="Solid" BorderWidth="1px" BorderColor="#478ACA" />
                    <Columns>
                        <asp:BoundField HeaderText="Req Type" DataField="ReqTypeName" SortExpression="ReqTypeName" />
                        <asp:BoundField HeaderText="Location Type" DataField="LocationName" SortExpression="LocationName" />
                        <asp:BoundField HeaderText="Total" DataField="total" SortExpression="total" />
                    </Columns>
                    <EmptyDataTemplate>
                        No record found.
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_ForwardingReports" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource2_Selected">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="TextBox1" Name="DateFrom" DefaultValue="01/01/1900"
                            PropertyName="Text" Type="DateTime" />
                        <asp:ControlParameter ControlID="TextBox2" Name="DateTo" PropertyName="Text" DefaultValue="01/01/1900"
                            Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:Button runat="server" ID="downloadxlsx" Text="Download XLSX" OnClick="downloadxlsx_Click" />
            </div>
            <br />
            <div class="group" runat="server" id="div1">
                <h5>Pending Location Mark Branch</h5>
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                    BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="5" DataSourceID="SqlDataSource7" ForeColor="Black"
                    GridLines="Vertical" Style="font-size: small" AllowSorting="True">
                    <FooterStyle BackColor="#CCCC99" />
                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                    <Columns>
                        <asp:BoundField DataField="BranchID" HeaderText="Branch ID" SortExpression="BranchID" />
                        <asp:BoundField DataField="BranchName" HeaderText="Branch Name" SortExpression="BranchName" />
                        <asp:BoundField DataField="BranchAddress" HeaderText="Branch Address" SortExpression="BranchAddress" />
                    </Columns>
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#FFA200" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:Label ID="Label1" runat="server" Text="" Visible="false"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="SELECT  BranchID ,BranchName,BranchAddress FROM dbo.v_BranchOnly WHERE   
                            BranchID NOT IN ( SELECT BranchID FROM dbo.v_Branch_Location_Mark )"
                    OnSelected="SqlDataSource7_Selected"></asp:SqlDataSource>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="downloadxlsx" />
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
