<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Dispute_Comments_Search.aspx.cs" Inherits="Dispute_Comments_Search" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .HoverLink
        {
            color: Blue;
            text-decoration: none;
        }
        .HoverLink:hover
        {
            color: Blue;
            text-decoration: underline;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Search Dispute
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table class="Panel1 ui-corner-all">
                <tr>
                    <td>
                        <table style="border-collapse: collapse;">
                            <tr>
                                <td>
                                    <table style="border-collapse: collapse;">
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtFilter" runat="server" Width="150px" onfocus="this.select()"
                                                    AutoPostBack="true" Watermark="enter text to filter"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 10px; white-space: nowrap">
                                                Requested From:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="cboBranch" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                                    DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID"
                                                    OnDataBound="cboBranch_DataBound">
                                                    <asp:ListItem Value="-1" Text="All Branches"></asp:ListItem>
                                                    <asp:ListItem Value="-2" Text="Only Branch"></asp:ListItem>
                                                    <asp:ListItem Value="1" Text="Head Office"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                                    SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] where Branchid &lt;&gt; 1 order by BranchName">
                                                </asp:SqlDataSource>
                                            </td>
                                            <%--<td>
                                                Status:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="cboStatus" runat="server" AppendDataBoundItems="True" AutoPostBack="true"
                                                    DataTextField="StatusName" DataValueField="StatusID" DataSourceID="SqlDataSourceStatus">
                                                    <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                                    <asp:ListItem Value="8" Text="New"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                                    SelectCommand="s_Dispute_Status_Select" SelectCommandType="StoredProcedure">
                                                </asp:SqlDataSource>
                                            </td>--%>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                Comments Date:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                                            </td>
                                            <td>
                                                To
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Button ID="cmdFilter" runat="server" Font-Bold="true" Text="Filter" Width="80px"
                                                    OnClick="cmdFilter_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="ID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True"
                OnRowCommand="GridView1_RowCommand" EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:TemplateField HeaderText="ID" SortExpression="ID" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <b><a title="Open" target="_blank" href='<%# "Dispute.aspx?ID=" + Eval("ID") %>'
                                class="HoverLink">
                                <%# Eval("ID") %></a></b>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Card Number" SortExpression="CardNo" >
                        <ItemTemplate>
                            <%# Eval("CardNo")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="AccNo" HeaderText="Account" SortExpression="AccNo" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" SortExpression="CustomerName"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BranchName" HeaderText="Requested Branch" SortExpression="BranchName"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                   <%-- <asp:BoundField DataField="StatusName" HeaderText="Status" SortExpression="StatusName"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>--%>
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Comment By" InsertVisible="False" SortExpression="InsertBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP1" Username='<%# Eval("InsertBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Dispute_Comments_Search" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter Name="Filter" ControlID="txtFilter" PropertyName="Text" Type="String"
                        ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter Name="ReqBranch" ControlID="cboBranch" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />
                   <%-- <asp:ControlParameter Name="Status" ControlID="cboStatus" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />--%>
                    <asp:ControlParameter ControlID="txtDateFrom" Name="FromDate" PropertyName="Text"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="txtDateTo" Name="ToDate" PropertyName="Text" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
            <br />
            <br />
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
