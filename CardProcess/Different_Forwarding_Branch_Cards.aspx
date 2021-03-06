﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Different_Forwarding_Branch_Cards.aspx.cs" Inherits="Different_Forwarding_Branch_Cards" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Different Forwarding Branch Cards
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="false" AllowSorting="True"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1"
                CssClass="Grid" PagerSettings-Position="TopAndBottom" EnableSortingAndPagingCallbacks="True"
                ForeColor="Black" GridLines="Vertical" Style="font-size: small">
                <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                <PagerSettings PageButtonCount="20" Mode="NumericFirstLast" />
                <Columns>
                    <asp:TemplateField HeaderText="SL">
                        <ItemTemplate>
                            <%# (1+Container.DataItemIndex).ToString() %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Batch" HeaderText="Batch" SortExpression="Batch"
                        ItemStyle-HorizontalAlign="Left" />
                    <%--<asp:BoundField DataField="Reference" HeaderText="Reference" SortExpression="Reference"
                        ItemStyle-HorizontalAlign="Left" />
                     <asp:BoundField DataField="ForwardingDate" HeaderText="Forwarding Date" SortExpression="ForwardingDate"
                        ItemStyle-HorizontalAlign="Left" DataFormatString="{0:dd/MMM/yyyy}" />--%>
                    <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" SortExpression="CustomerName"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="AccountNo" HeaderText="Account No" SortExpression="AccountNo" />
                    <asp:BoundField DataField="DeleveryBranch" HeaderText="Delevery Branch" SortExpression="DeleveryBranch" />
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <br />
            <asp:Label ID="lblRows" runat="server" Text="" Style="font-size: small"></asp:Label>
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
        SelectCommand="sp_Forwarding_Diff_Branch" SelectCommandType="StoredProcedure"
        OnSelected="SqlDataSource1_Selected">
        <SelectParameters>
            <asp:SessionParameter Name="EmpID" SessionField="EMPID" />
            <asp:QueryStringParameter Name="batch" QueryStringField="batch" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
