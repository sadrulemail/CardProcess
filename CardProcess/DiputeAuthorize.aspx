﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DiputeAuthorize.aspx.cs" Inherits="DiputeAuthorize" %>


<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Dispute Authorize
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div  >
                <table class="Panel1 ui-corner-all">
                    <tr>
                        <td>
                            <asp:TextBox ID="txtAccNo" runat="server" placeholder="account number" Width="140px"></asp:TextBox></td>
                        <td>Request Branch:
                        </td>
                        <td>
                            <asp:DropDownList ID="dboReqBranch" runat="server" AppendDataBoundItems="true" AutoPostBack="true" DataSourceID="SqlDataSource3"
                                DataValueField="BranchID" DataTextField="BranchName" OnDataBound="dboBranchCode_DataBound">
                                <asp:ListItem Value="-1" Text="All"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="SELECT  [BranchID],[BranchName] FROM [CardData].[dbo].[v_BranchOnly]" SelectCommandType="Text"
                                EnableCaching="True" CacheDuration="60"></asp:SqlDataSource>
                        </td>
                        <td>Request Date:
                        </td>
                        <td>
                            <asp:TextBox ID="txtReqBegDate" runat="server" Width="80px" CssClass="Date"></asp:TextBox>
                        </td>
                        <td>to
                        </td>
                        <td>
                            <asp:TextBox ID="txtReqEndDate" runat="server" Width="80px" CssClass="Date"></asp:TextBox>
                        </td>
                        <td>Authorize:</td>
                        <td>
                            <asp:DropDownList ID="ddlAuthorize" runat="server" AppendDataBoundItems="true" AutoPostBack="true">
                                <asp:ListItem Value="0" Text="Pending"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Completed"></asp:ListItem>
                                <asp:ListItem Value="2" Text="All"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Show" Width="80px" />

                        </td>
                    </tr>
                </table>
            </div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                AllowPaging="True" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30"
                PagerSettings-Position="TopAndBottom" CssClass="Grid" BorderColor="#DEDFDE" BorderStyle="Solid"
                BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black"
                AllowSorting="True" Font-Size="Small" DataKeyNames="ID" OnRowCommand="GridView1_RowCommand">
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" HorizontalAlign="Center" />
                <Columns>
                    <asp:TemplateField HeaderText="#" SortExpression="Batch">
                        <ItemTemplate>
                            <a href='Dispute.aspx?ID=<%# Eval("ID") %>' target="_blank" class="Link">
                                <span style="color: blue">
                                    <%# Eval("ID") %></span></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="A/C Info" SortExpression="AccNo">
                        <ItemTemplate>
                            <%# Eval("AccNo","<b>{0}</b>") %>
                            <%# Eval("CustomerName", "<div>{0}</div>")%>
                            <div style="color: Silver; font-size: 85%">
                                <%# Eval("CardNumber", "Card: {0}")%>
                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Trans Info" SortExpression="TxnDate">
                        <ItemTemplate>
                            <%# Eval("TxnDate","<div>Txn Date:{0:dd/MM/yyyy}</div>") %>
                            <%# Eval("TxnAmount","<div>Txn Amount:{0}</div>")%>
                            <%# Eval("DisputeAmount","<div>Dispute Amount:<b>{0}</b></div>")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Others Info" SortExpression="TraceNo">
                        <ItemTemplate>
                            <%# Eval("BankName","<div>Acquirer Bank:{0}</div>")%>
                            <%# Eval("StatusName","<div>Status:<b>{0}</b></div>")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Request Info" SortExpression="InsertBy">
                        <ItemTemplate>
                            <div title="insert info">Insert by:</div>
                            <uc2:EMP ID="EMP214" Username='<%# Eval("InsertBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                            <div style="color: Silver; font-size: 85%">
                                <%# Eval("ReqBranch","<div>{0}</div>")%>
                            </div>
                            <div runat="server" id="divauth" title="Auth Info" visible='<%# (Eval("Authorize").ToString().ToUpper() == "FALSE"?false:true) %>'>Auth By:</div>
                            <div><%# (bool)Eval("Authorize") ? "<img src='Images/tick.png' width='24' >" : "" %></div>
                            <uc2:EMP ID="EMP247572" Username='<%# Eval("AuthBY") %>'
                                runat="server" />
                            <span class="time-small" title='<%# Eval("AuthDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("AuthDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                   
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:Button ID="cmdAutorize" runat="server" Text="Authorize" CommandName="Authorize"
                                Visible='<%# (Eval("Authorize").ToString().ToUpper() == "FALSE" && Eval("RequestBranchID").ToString()==Session["BRANCHID"].ToString() ? true : false) %>'
                                CommandArgument='<%# Eval("ID") %>' ToolTip="Authorize" />
                            <asp:ConfirmButtonExtender ID="conAutho" runat="server" ConfirmText="Do you want to Authorize?"
                                TargetControlID="cmdAutorize"></asp:ConfirmButtonExtender>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding: 15px 50px">
                        No record found.
                    </div>
                </EmptyDataTemplate>
                <FooterStyle BackColor="#CCCC99" HorizontalAlign="Center" Font-Bold="true" />
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="30" Position="TopAndBottom" />
                <PagerStyle HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <br />
            <asp:Label runat="server" ID="lblStatus" Text=""></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Dispute_Auth_Pending" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtAccNo" Name="Account" PropertyName="Text" DefaultValue="*" Type="String" Size="20" />
                    <asp:ControlParameter ControlID="dboReqBranch" Name="BranchID" PropertyName="SelectedValue" DefaultValue="-1" />
                    <asp:ControlParameter ControlID="txtReqBegDate" Name="DateFrom" PropertyName="Text" DefaultValue="01/01/1900" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtReqEndDate" Name="DateTo" PropertyName="Text" Type="DateTime" DefaultValue="01/01/1900" />
                    <asp:ControlParameter ControlID="ddlAuthorize" Name="Authorize" PropertyName="SelectedValue" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DynamicLayout="false" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="10">
        <ProgressTemplate>
            <div class="TransparentGrayBackground">
            </div>
            <asp:Image ID="Image1" runat="server" alt="" ImageUrl="~/Images/processing.gif" CssClass="LoadingImage"
                Width="214" Height="138" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:AlwaysVisibleControlExtender ID="UpdateProgress1_AlwaysVisibleControlExtender"
        runat="server" Enabled="True" HorizontalSide="Center" TargetControlID="Image1"
        UseAnimation="false" VerticalSide="Middle"></asp:AlwaysVisibleControlExtender>
</asp:Content>
