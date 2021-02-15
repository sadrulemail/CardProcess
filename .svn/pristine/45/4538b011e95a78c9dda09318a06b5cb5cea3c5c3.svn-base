<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CreditCardFeesReverseView.aspx.cs" Inherits="CreditCardFeesReverseView" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="Card Reissue Batch #"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CssClass="Grid" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black"
                Style="font-size: small; font-family: Arial, Helvetica, sans-serif" AutoGenerateColumns="False"
                EnableSortingAndPagingCallbacks="True" PagerSettings-PageButtonCount="30">
                <Columns>
                    <asp:BoundField DataField="SBK_PAN" HeaderText="SBK_PAN" SortExpression="SBK_PAN" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="SBK_MBR" HeaderText="SBK_MBR" SortExpression="SBK_MBR"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="SBK_SUM" HeaderText="SBK_SUM" SortExpression="SBK_SUM" />
                    <asp:BoundField DataField="SBK_ACUR" HeaderText="SBK_ACUR" SortExpression="SBK_ACUR" />

                </Columns>
                <RowStyle BackColor="#F7F7DE" />
                <FooterStyle BackColor="#CCCC99" />
                <EmptyDataTemplate>
                    No Activation Request Found.
                </EmptyDataTemplate>
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_CreditCardFeesReverseDownload" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Batch" QueryStringField="batch" Type="Int32" />

                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
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
