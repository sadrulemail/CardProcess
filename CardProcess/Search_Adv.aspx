<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Search_Adv.aspx.cs" Inherits="Search_Adv" ViewStateMode="Disabled" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Advanced Search All Cards
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:SqlDataSource ID="SqlDataSourceCustomerType" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="select * from v_CustomerType" SelectCommandType="Text"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceVip" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="select * from v_VIP" SelectCommandType="Text"></asp:SqlDataSource>

            <table class="Panel1">
                <tr>
                    <%--<td>
                                <b>Account No./Card No./ITCL ID: </b>
                            </td>--%>
                    <td>
                        <asp:TextBox ID="txtCustomerName" runat="server" onfocus="this.select()" placeholder="customer name" TabIndex="0" Width="270px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtIDs" runat="server" onfocus="this.select()" OnTextChanged="txtFilter_TextChanged" placeholder="acc no/card no/itcl id" TabIndex="1" Width="270px"></asp:TextBox>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtAddress" runat="server" onfocus="this.select()" placeholder="customer address" TabIndex="2" Width="400px"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtMobile" runat="server" onfocus="this.select()" placeholder="mobile" TabIndex="3" Width="270px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" onfocus="this.select()" placeholder="email" TabIndex="4" Width="270px"></asp:TextBox>
                    </td>
                    <td>Customer Type:
                                    <asp:DropDownList ID="dboCustomerType" runat="server" AutoPostBack="true" AppendDataBoundItems="True" DataSourceID="SqlDataSourceCustomerType" DataTextField="CustomerType" DataValueField="CustomerTypeID">
                                        <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                                    </asp:DropDownList>
                    </td>
                    <td>VIP:
                                    <asp:DropDownList ID="dboVIP" runat="server" AppendDataBoundItems="True" AutoPostBack="true">
                                        <%--DataSourceID="SqlDataSourceVip" DataTextField="VIP" DataValueField="VIPID">--%>
                                        <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                    </td>
                    <td style="text-align: right">
                        <asp:Button ID="cmdOK" runat="server" OnClick="cmdOK_Click" Text="Search" Width="80px" />
                    </td>
                </tr>
            </table>

            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE" PageSize="20"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="Black" Style="font-size: small"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True"
                AllowSorting="True" CssClass="Grid" EnableViewState="false">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" HorizontalAlign="Center" />
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

                    <asp:TemplateField HeaderText="Account Number" SortExpression="Account">

                        <ItemTemplate>
                            <a title="Search" target="_blank" href='<%# "Search.aspx?q=" + Eval("Account") %>'
                                class="HoverLink"><%# Eval("Account") %></a>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Card Number" SortExpression="CardNumber">

                        <ItemTemplate>
                            <a title="Search" target="_blank" href='<%# "Search.aspx?q=" + Eval("CardNumber") %>'
                                class="HoverLink"><%# Eval("CardNumber") %></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" ReadOnly="True"
                        SortExpression="CustomerName" HtmlEncode="false" ItemStyle-HorizontalAlign="Left">

                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Present Address" SortExpression="PresentAddress">

                        <ItemTemplate>
                            <%# Eval("PresentAddress").ToString().Replace("\n","<br>") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mobile" SortExpression="Mobile1">
                        <ItemTemplate>
                            <%# Eval("Mobile1","<div>{0}</div>") %>
                            <%# Eval("Mobile2","<div>{0}</div>") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" SortExpression="Email1">
                        <ItemTemplate>
                            <%# Eval("Email1","<div>{0}</div>") %>
                            <%# Eval("Email2","<div>{0}</div>") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status"
                        HtmlEncode="false" ItemStyle-Font-Bold="true">
                        <ItemStyle Font-Bold="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CustomerTypeName" HeaderText="Type" SortExpression="CustomerTypeName"></asp:BoundField>
                    <asp:BoundField DataField="VIPName" HeaderText="VIP" ReadOnly="True" SortExpression="VIPName"
                        ItemStyle-Font-Bold="true"></asp:BoundField>

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
            <asp:Label ID="lblCount" runat="server" Text=""></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Search_Adv" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCustomerName" Name="CustomerName" PropertyName="Text" Type="String" DefaultValue="*" />
                    <asp:ControlParameter ControlID="txtIDs" Name="IDs" PropertyName="Text" Type="String" DefaultValue="*" />
                    <asp:ControlParameter ControlID="txtAddress" Name="Address" PropertyName="Text" Type="String" DefaultValue="*" />
                    <asp:ControlParameter ControlID="txtMobile" Name="Mobile" PropertyName="Text" Type="Int64" DefaultValue="-1" />
                    <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String" DefaultValue="*" />
                    <asp:ControlParameter ControlID="dboVIP" PropertyName="SelectedValue" Name="VIP" Type="Int32" DefaultValue="-1" />
                    <asp:ControlParameter ControlID="dboCustomerType" PropertyName="SelectedValue" Name="CusType" Type="Int32" DefaultValue="-1" />

                    <asp:Parameter Name="Top" Type="Int32" DefaultValue="100" />
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