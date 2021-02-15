﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Search_SMS_Alert_Request.aspx.cs" Inherits="Search_SMS_Alert_Request" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="SMS Service Request"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server">
                <table class="Panel1 ui-corner-all">
                    <tr>
                        <td>
                            <b>Account No.: </b>
                            <asp:TextBox ID="txtSearch" runat="server" Width="150px"></asp:TextBox>
                            <b>Status: </b>
                            <asp:DropDownList runat="server" ID="cboStatus" AppendDataBoundItems="true" AutoPostBack="true" DataTextField="StatusName" DataValueField="StatusID" DataSourceID="SqlDataSource2"
                                OnSelectedIndexChanged="cboStatus_SelectedIndexChanged">
                                <asp:ListItem Text="All" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="SELECT  StatusID ,StatusName FROM dbo.SMSAlertStatus"
                                SelectCommandType="Text"></asp:SqlDataSource>
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
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <b>Requested Branch: </b>
                            <asp:DropDownList ID="cboBranch" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                DataSourceID="SqlDataSource3" DataTextField="branchname" DataValueField="branchid"
                                OnDataBound="cboBranch_DataBound"
                                OnSelectedIndexChanged="cboBranch_SelectedIndexChanged">
                                <asp:ListItem Text="All Branch" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="SELECT  [branchid],[branchname]  FROM [CardData].[dbo].[v_BranchOnly]"
                                SelectCommandType="Text"></asp:SqlDataSource>

                            <asp:Button ID="btnSearch" runat="server" Text="Search" Width="80px" CausesValidation="false"
                                OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>
               
            </asp:Panel>
            <asp:GridView ID="GridView1" runat="server" BackColor="White" AllowPaging="true" OnRowCommand="GridView1_OnRowCommand"
                PageSize="15" CssClass="Grid" AllowSorting="true" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Both" AutoGenerateColumns="False"
                PagerSettings-PageButtonCount="30" DataSourceID="SqlDataSource1" Style="font-size: small; font-family: Arial">
                <RowStyle BackColor="#F7F7DE" CssClass="Grid" VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField HeaderText="RID" SortExpression="ReqID" ItemStyle-VerticalAlign="Middle">
                        <ItemTemplate>
                            <a href='SMS_Alert.aspx?id=<%# Eval("ReqID") %>' title="View Request" target="_blank">
                                <%# Eval("ReqID")%></a>
                        </ItemTemplate>
                        <ItemStyle Font-Bold="true" Font-Size="Large" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Info">
                        <ItemTemplate>
                            <b>Account:</b>
                            <%# Eval("Account")%>
                            <br />
                            <b>Account Name:</b><br />
                            <%# Eval("AccountName")%>
                            <br />
                            <b>DOB:</b>
                            <%# Eval("DOB","{0:dd-MMM-yyyy}")%><br />
                            <b>Email:</b>
                            <%# Eval("Email")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Address" HeaderText="Address" ReadOnly="true"></asp:BoundField>
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" ReadOnly="true"></asp:BoundField>
                    <asp:BoundField DataField="ServiceName" HeaderText="Service Name" ReadOnly="true"></asp:BoundField>
                    <asp:BoundField DataField="StatusName" HeaderText="Status" ReadOnly="true"></asp:BoundField>
                    <asp:BoundField DataField="Comments" HeaderText="Comments" ReadOnly="true"></asp:BoundField>
                    <asp:TemplateField HeaderText="Req By" SortExpression="InsertBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP1" Username='<%# Eval("InsertBy") %>' runat="server" />
                            <br />
                            <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Authorize By" SortExpression="AuthorizeBY">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP55" Username='<%# Eval("AuthorizeBY") %>' runat="server" />
                            <br />
                            <span class="time-small" title='<%# Eval("AuthorizeDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("AuthorizeDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Processed By" SortExpression="ProcessedBY">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP2" Username='<%# Eval("ProcessedBY") %>' runat="server" />
                            <br />
                            <span class="time-small" title='<%# Eval("ProcessedDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("ProcessedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="Authorize" Width="70px" 
                                Enabled='<%# Eval("Authorize").ToString().ToUpper() == "TRUE" ? false : true %>' Text="Authorize" CommandArgument='<%# Eval("ReqID") %>' />
                            <br />
                            <asp:Button ID="Button2" runat="server" CausesValidation="false" CommandName="Delete1" Width="70px" ForeColor="Red"
                                Enabled='<%# Eval("Authorize").ToString().ToUpper() == "TRUE" ? false : true %>' Text="Delete" CommandArgument='<%# Eval("ReqID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" Font-Names="Arial Narrow" />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                    <div style="border: solid 1px silver; padding: 10px; background-color: #F6F6F6; width: 500px">
                        No Request Data Found.
                    </div>
                </EmptyDataTemplate>
                <EditRowStyle BackColor="#C5E2FD" />
            </asp:GridView>
            <asp:Label runat="server" ID="lblStatus" Text=""></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Search_SMS_Alert_request" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearch" Name="Search" PropertyName="Text" Type="String"
                        ConvertEmptyStringToNull="false" DefaultValue="" />
                    <asp:ControlParameter ControlID="cboBranch" Name="BranchID" PropertyName="SelectedValue"
                        DefaultValue="-1" />
                    <asp:ControlParameter ControlID="cboStatus" Name="Status" PropertyName="SelectedValue"
                        DefaultValue="All" />
                    <asp:ControlParameter ControlID="TextBox1" Name="DateFrom" DefaultValue="01/01/1900"
                        PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="TextBox2" Name="DateTo" PropertyName="Text" DefaultValue="01/01/1900"
                        Type="DateTime" />
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
