<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supplementary_Search.aspx.cs" Inherits="Supplementary_Search" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .HoverLink {
            color: Blue;
            text-decoration: none;
        }

            .HoverLink:hover {
                color: Blue;
                text-decoration: underline;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Search Supplementary Card Request
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
                                            <td style="padding-left: 10px; white-space: nowrap">Requested From:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="cboBranch" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                                    DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID"
                                                    OnDataBound="cboBranch_DataBound">
                                                    <asp:ListItem Value="" Text="All Branches"></asp:ListItem>
                                                    <asp:ListItem Value="1" Text="Head Office"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                                    SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] where Branchid &lt;&gt; 1 order by BranchName"></asp:SqlDataSource>
                                            </td>

                                            <td>&nbsp;
                                            </td>
                                            <td>From Date:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                                            </td>
                                            <td>To
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
                BorderStyle="Solid" BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True"
                OnRowCommand="GridView1_RowCommand" EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:TemplateField HeaderText="Account" SortExpression="Account" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <b><a title="Open" target="_blank" href='<%# "Supplementary_Issue_Request.aspx?acc=" + Eval("Account") %>'
                                class="HoverLink">
                                <%# Eval("Account") %></a></b>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" />
                    <asp:BoundField DataField="ReqBranch" HeaderText="Requested Branch" SortExpression="ReqBranch" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="NameOnCard" HeaderText="Name On Card" SortExpression="NameOnCard" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                    <asp:BoundField DataField="RelationWithPrimaryCardholder" HeaderText="Relation" SortExpression="RelationWithPrimaryCardholder" />
                    <asp:BoundField DataField="DOB" HeaderText="Date of Birth" SortExpression="DOB" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="SendToProcess" HeaderText="Send to ITCL" SortExpression="SendToProcess" />
                    <asp:BoundField DataField="SendBatch" HeaderText="SendBatch" SortExpression="SendBatch" />
                    <asp:BoundField DataField="DeliveryBranch" HeaderText="Delivery Branch" SortExpression="DeliveryBranch" />
                    <asp:TemplateField HeaderText="Insert By" InsertVisible="False" SortExpression="InsertBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP1" Username='<%# Eval("InsertBy") %>' runat="server" />
                            <br />
                            <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Update By" InsertVisible="False" SortExpression="UpdateBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP222" Username='<%# Eval("UpdateBy") %>' runat="server" />
                            <br />
                            <span class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
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
                SelectCommand="s_SupplementaryCardRequest_Search" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter Name="Filter" ControlID="txtFilter" PropertyName="Text" Type="String"
                        ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter Name="ReqBranchID" ControlID="cboBranch" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />

                    <asp:ControlParameter ControlID="txtDateFrom" Name="DateFrom" PropertyName="Text"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="txtDateTo" Name="DateTo" PropertyName="Text" Type="DateTime" />
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
