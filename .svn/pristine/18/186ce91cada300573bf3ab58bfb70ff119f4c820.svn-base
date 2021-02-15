<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="VIP_Tours_Browse.aspx.cs" Inherits="VIP_Tours_Browse" Culture="en-NZ" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Literal ID="lblTitle" runat="server" Text="Travel Details"></asp:Literal>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <table>
                <tr>
                    <td>
                        <table class="Panel1">
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtFilter" runat="server" Width="200px" placeholder="customer name"></asp:TextBox>
                                </td>
                                <td>Date: from
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDateFrom" runat="server" CssClass="Date" Width="80px"></asp:TextBox>
                                </td>
                                <td>to
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDateTo" runat="server" CssClass="Date" Width="80px"></asp:TextBox>
                                </td>
                                <td>Country
                                </td>
                                <td>
                                    <asp:DropDownList ID="dboContrycode" runat="server"
                                        DataSourceID="SqlDataSourceCountrycode"
                                        DataTextField="CountryName" DataValueField="CountryID" AppendDataBoundItems="true">
                                        <asp:ListItem Value="0" Text="ALL"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Button ID="cmdOK" runat="server" Text="Filter" Width="80px" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <asp:LinkButton ID="cmdPreviousDay" runat="server" OnClick="cmdPreviousDay_Click"
                            ToolTip="Previous Day" CssClass="button-round"><img src="Images/Previous.gif" width="32px" height="32px" border="0" /></asp:LinkButton>
                        <asp:LinkButton ID="cmdNextDay" runat="server" OnClick="cmdNextDay_Click" ToolTip="Next Day"
                            CssClass="button-round"><img src="Images/Next.gif" width="32px" height="32px" border="0" /></asp:LinkButton>
                    </td>
                </tr>
            </table>

            <asp:SqlDataSource ID="SqlDataSourceCountrycode" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="select * from v_country order by CountryName" SelectCommandType="Text"></asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="5" DataKeyNames="ID" DataSourceID="SqlDataSource1" ForeColor="Black"
                GridLines="Vertical" Style="font-size: small" AllowSorting="True" OnRowDataBound="GridView1_RowDataBound">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"><img src="Images/edit-label.png" width="20" height="20" border="0" /></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Font-Bold="True" ForeColor="Blue" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ITCLID" SortExpression="ITCLID" >
                        <ItemTemplate>
                            <a target="_blank" href='ITCL.aspx?ITCLID=<%# Eval("ITCLID") %>'><%# Eval("ITCLID")%></a>
                        </ItemTemplate>
                        <ItemStyle Font-Bold="true" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="On Travel" SortExpression="OnTravel">
                        <ItemTemplate>
                            <%# Eval("OnTravel").ToString() == "1" ? "<img src='Images/Travel.png' width='48' height='48' title='On Travel'>" : "" %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Customer Name" SortExpression="CustomerName" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("CustomerName")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="From Date" SortExpression="FromDate">
                        <ItemTemplate>
                            <%# Eval("FromDate","{0:dd-MMM-yyyy}")%>
                            <div class="time-small"><%# TrustControl1.ToRelativeDay(Eval("FromDate"))%></div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="To Date" SortExpression="ToDate">
                        <ItemTemplate>
                            <%# Eval("ToDate","{0:dd-MMM-yyyy}")%>
                            <div class="time-small"><%# TrustControl1.ToRelativeDay(Eval("ToDate"))%></div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Days" SortExpression="Days">
                        <ItemTemplate>
                            <%# Eval("Days") %> Day<%# (int)Eval("Days") > 1 ? "s" : "" %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="CountryName" HeaderText="Country Name" SortExpression="CountryName" />
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" ItemStyle-Font-Bold="true" />

                    <asp:TemplateField HeaderText="Inserted on" SortExpression="DT">
                        <ItemTemplate>
                            <div class="time-small" title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Updated on" SortExpression="UpdateDT">
                        <ItemTemplate>
                            <div class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("UpdateBY") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#FFA200" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_VIP_Tours_Browse" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:Parameter Name="ITCLID" DefaultValue="0" />
                    <asp:ControlParameter ControlID="txtDateFrom" DbType="Date" Name="FromDate" PropertyName="Text" DefaultValue="01/01/1900" />
                    <asp:ControlParameter ControlID="txtDateTo" DbType="Date" Name="ToDate" PropertyName="Text" DefaultValue="01/01/1900" />
                    <asp:ControlParameter ControlID="txtFilter" Name="CustomerName" PropertyName="Text" Type="String" DefaultValue="*" />
                    <asp:ControlParameter ControlID="dboContrycode" Name="CountryCode" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
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

