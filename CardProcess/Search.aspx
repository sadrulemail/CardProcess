<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Search.aspx.cs" Inherits="Search" ViewStateMode="Disabled" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Search All Cards
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table>
                <td>
                    <img src="Images/search-icon.png" width="70" />                
                </td>
                <td>
                    <table class="Panel1 ui-corner-all">
                        <tr>
                            <td>
                                <b>Account No./Card No./ITCL ID: </b>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFilter" runat="server" Width="250px" onfocus="this.select()"
                                    TabIndex="0" Font-Size="X-Large" Font-Bold="true" OnTextChanged="txtFilter_TextChanged"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Button ID="cmdOK" runat="server" Text="Search" Width="80px"
                                    OnClick="cmdOK_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </table>
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="Black" Style="font-size: small"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True"
                AllowSorting="True" CssClass="Grid" EnableSortingAndPagingCallbacks="True">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <Columns>
                    <%-- <asp:BoundField DataField="ITCLID" HeaderText="ITCL ID" ReadOnly="True" SortExpression="ITCLID"
                        HtmlEncode="false" />--%>
                    <asp:TemplateField HeaderText="ITCLID" SortExpression="ITCLID" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <b><a title="Open" target="_blank" href='<%# "ITCL.aspx?ITCLID=" + Eval("ITCLID") %>'
                                class="HoverLink">
                                <%# Eval("ITCLID") %></a></b>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="Account" HeaderText="Account Number"
                        ReadOnly="True" SortExpression="Account"
                        HtmlEncode="false" ItemStyle-Wrap="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CardNumber" HeaderText="Card Number" ReadOnly="True" SortExpression="CardNumber"
                        HtmlEncode="false" />
                    <asp:BoundField DataField="Customer NAME" HeaderText="Customer Name" ReadOnly="True"
                        SortExpression="Customer NAME" HtmlEncode="false" />
                    <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status"
                        HtmlEncode="false">
                        <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Created" SortExpression="CREATED" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("CREATED")) %>'>
                                <%# TrustControl1.ToRecentDate(Eval("CREATED"))%>
                                <div class='time-small'>
                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("CREATED")) %>'></time>
                                </div>
                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" ReadOnly="True" SortExpression="ExpiryDate"
                        HtmlEncode="false" DataFormatString="{0:dd MMM, yyyy}" />
                    <asp:BoundField DataField="Location" HeaderText="Location" ReadOnly="True" SortExpression="Location"
                        HtmlEncode="false" />
                    <asp:TemplateField HeaderText="Delivery Info" SortExpression="DeliveryDT" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("DeliveryDT")) %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("DeliveryDT"))%>
                                <div class='time-small'>
                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("DeliveryDT")) %>'></time>
                                </div>
                            </div>
                            <%# Eval("Reference","<div title='Reference'>{0}</div>")%>
                            <%# Eval("DeliveredBranchID", "To Branch:")%>
                            <uc2:Branch ID="Branch1" runat="server" BranchID='<%# Eval("DeliveredBranchID") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Forwarding Info" SortExpression="ForwardingDT" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("ForwardingDT")) %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("ForwardingDT"))%>
                                <div class='time-small'>
                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("ForwardingDT")) %>'></time>
                                </div>
                            </div>
                            <%# Eval("ForwardingBranch", "To Branch:")%>
                            <uc2:Branch ID="Branch2" runat="server" BranchID='<%# Eval("ForwardingBranch") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:TemplateField>
                </Columns>
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" PageButtonCount="30" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                    Not Card Found.
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Search_All_Card" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="q" Name="Filter" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
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
