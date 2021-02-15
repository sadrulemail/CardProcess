﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CardReissue_stats.aspx.cs" Inherits="CardReissue_stats" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="Card Reissue Statistics"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server">
                <table class="Panel1 ui-corner-all" style="display: inline-block">
                    <tr>
                        <td>
                            <td><b>Date:</b>
                                <asp:TextBox ID="txtDateFrom" runat="server" Width="80px" CssClass="Date"></asp:TextBox>
                                <b>to</b>
                                <asp:TextBox ID="txtDateTo" runat="server" Width="80px" CssClass="Date"></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" Text="Search" Width="80px" CausesValidation="false"
                                    OnClick="btnSearch_Click" />
                            </td>
                    </tr>

                </table>
            </asp:Panel>
            <asp:GridView ID="GridView1" runat="server" BackColor="White" AllowPaging="true" Visible="false"
                PageSize="30" CssClass="Grid" AllowSorting="true" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Both" AutoGenerateColumns="False" DataKeyNames="Code"
                PagerSettings-PageButtonCount="30" DataSourceID="SqlDataSource1" Style="font-size: small; font-family: Arial">
                <RowStyle BackColor="#F7F7DE" CssClass="Grid" VerticalAlign="Top" />
                <Columns>
                    <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code"
                        ReadOnly="true">
                        <ItemStyle Font-Bold="true" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TypeName" HeaderText="Type Name" ReadOnly="true" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TotalCard" HeaderText="Total Cards" ReadOnly="true" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
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
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_CardReissue_stats" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtDateFrom" Name="DateFrom" PropertyName="Text" DefaultValue="01/01/1900" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtDateTo" Name="DateTo" PropertyName="Text" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="cmdExport" runat="server" Text="Download XLSX" Width="210px" OnClick="cmdExport_Click1" Visible="false"
                Height="30px" Font-Bold="true" />
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="cmdExport" />
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
