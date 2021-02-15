<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Card_Payment_Batch.aspx.cs" Inherits="Card_Payment_Batch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/StyleSheet.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblBatch" runat="server" Text="Card Payment Batch"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" DataKeyNames="TransactionID" DataSourceID="SqlDataSource1"
                ForeColor="Black" GridLines="Vertical" PagerSettings-Mode="NumericFirstLast"
                PagerSettings-PageButtonCount="30" PagerSettings-Position="TopAndBottom">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="TransactionID" HeaderText="Transaction ID" ReadOnly="True"
                        SortExpression="TransactionID" />
                    <asp:BoundField DataField="CardNo" HeaderText="Card No" SortExpression="CardNo" ItemStyle-Font-Bold="true" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" ItemStyle-HorizontalAlign="Right"
                        DataFormatString="{0:N2}" ItemStyle-Font-Bold="true" />
                    <asp:BoundField DataField="CurrencyCode" HeaderText="Currency Code" SortExpression="CurrencyCode"
                        ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                    <asp:BoundField DataField="BDTAmount" HeaderText="BDT Amount" SortExpression="BDTAmount"
                        ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" ItemStyle-Font-Bold="true" />
                    <asp:BoundField DataField="TransactionDate" HeaderText="Transaction Date" SortExpression="TransactionDate"
                        DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="ActualRemarks" HeaderText="Actual Remarks" SortExpression="ActualRemarks" />
                    <asp:BoundField DataField="Validity" HeaderText="Validity" SortExpression="Validity"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Batch" HeaderText="Batch" SortExpression="Batch" Visible="false"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="Insert By" SortExpression="InsertBy">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy")%>' Position="Left" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="On" SortExpression="InsertDt">
                        <ItemTemplate>
                            <div title='<%# Eval("InsertDt","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("InsertDt"))%><br />
                                <time class="timeago" datetime='<%# Eval("InsertDt","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Update By" SortExpression="UpdateBy">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("UpdateBy")%>' Position="Left" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="On" SortExpression="UpdateDt">
                        <ItemTemplate>
                            <div title='<%# Eval("UpdateDt","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("UpdateDt"))%><br />
                                <time class="timeago" datetime='<%# Eval("UpdateDt","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_CardPaymentCollectionTransactions_BatchDownload" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <%-- <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="select * from CardPaymentCollectionTransactions where Batch=@Batch" >--%>
                <SelectParameters>
                    <asp:QueryStringParameter Name="Batch" QueryStringField="Batch" Type="Int32" />
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
