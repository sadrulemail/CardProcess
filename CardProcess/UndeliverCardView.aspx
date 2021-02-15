<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReconciliationFile_Upload.aspx.cs" Inherits="ReconciliationFile_Upload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UndeliverCardView.aspx.cs" Inherits="UndeliverCardView" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Undeliver Card View
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                AllowPaging="True" PageSize="10" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" AutoGenerateColumns="False"
                CssClass="Grid" EnableSortingAndPagingCallbacks="True" DataKeyNames="cardnumber" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30">
                <Columns>
                    <asp:BoundField DataField="AccountNo" HeaderText="Account Number" SortExpression="AccountNo"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="CustomerName" HeaderText="Customer Name"
                        SortExpression="CustomerName" ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="CardNumber" HeaderText="Card Number" SortExpression="CardNumber"
                        ItemStyle-HorizontalAlign="Left" />

                </Columns>
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <FooterStyle BackColor="#CCCC99" />
                <EmptyDataTemplate>
                    No Record Found.
                </EmptyDataTemplate>
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <PagerSettings Position="TopAndBottom" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
            </asp:GridView>
            <br />

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_UnderliveredCard_search" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Batch" QueryStringField="batch" Type="Int32" />
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
