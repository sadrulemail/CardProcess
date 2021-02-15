<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Pos_Export_Merchant_Amount.aspx.cs" Inherits="Pos_Export_Merchant_Amount" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="POS Reconciliation"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                AutoGenerateColumns="False" BackColor="White" PagerSettings-Position="TopAndBottom"
                PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                ShowFooter="true" OnRowDataBound="GridView2_RowDataBound" BorderWidth="1px" CellPadding="4"
                PageSize="200" ForeColor="Black" DataSourceID="SqlDataSourceDataUploadLog" Style="font-size: small"
                EnableSortingAndPagingCallbacks="True">
                <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                <Columns>
                    <asp:TemplateField HeaderText="#">
                        <ItemTemplate>
                            <%#Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="MerchantName" HeaderText="Merchant Name" SortExpression="MerchantName"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="FromAccount" HeaderText="FromAccount" SortExpression="FromAccount"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="ToAccount" HeaderText="ToAccount" SortExpression="ToAccount"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="Amount_tk" HeaderText="Amount" SortExpression="Amount_tk"
                        DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right" />
                </Columns>
                <FooterStyle BackColor="#CCCC99" Font-Bold="true" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:Button ID="btnDownload" runat="server" Text="Download" OnClick="btnDownload_Click" />
            <asp:ConfirmButtonExtender ID="ddd" ConfirmText="Do You Want to Download Again?"
                TargetControlID="btnDownload" runat="server" Enabled="true">
            </asp:ConfirmButtonExtender>
            <b>Total Download(s):</b>
            <asp:Label ID="lblCount" runat="server" Text="0"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSourceDataUploadLog" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Pos_Download_Batch_view" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="DownloadBatch" QueryStringField="batch" Type="Int32" />
                    <asp:QueryStringParameter Name="Type" QueryStringField="type" Type="String" DefaultValue="MA" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnDownload" />
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
