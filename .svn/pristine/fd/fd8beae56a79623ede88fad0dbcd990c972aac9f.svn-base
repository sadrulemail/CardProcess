<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReconciliationFile_Upload.aspx.cs" Inherits="ReconciliationFile_Upload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PosDownloadBatchView.aspx.cs" Inherits="PosDownloadBatchView" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<style>.Grid{margin:10px}</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Reconciliation View</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    
        <ContentTemplate>
            <table>
                <tr>
                    <td valign="top">
                        <div>
                            <%--<div style="font-size:large;bold:true">Shifting Amount</div>--%>
                            <fieldset class="fieldset">
                                <legend class="legend" ><b> Shifting Amount </b> </legend>
                                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                                    AllowPaging="True" PageSize="200" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                                    CellPadding="2" DataSourceID="SqlDataSource1" ForeColor="Black" AutoGenerateColumns="False"
                                    ShowFooter="true" CssClass="Grid" EnableSortingAndPagingCallbacks="True" OnRowDataBound="GridView1_RowDataBound">
                                    <Columns>
                                     <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="MerchantName" HeaderText="Merchant Name" SortExpression="MerchantName"
                                            ItemStyle-HorizontalAlign="Left" />
                                        <asp:BoundField DataField="AccountNo" HeaderText="AccountNo" SortExpression="AccountNo"
                                            ItemStyle-HorizontalAlign="Left" ItemStyle-Wrap="false" />
                                        <asp:BoundField DataField="Amount_tk" HeaderText="Amount" SortExpression="Amount_tk"
                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" />
                                        <asp:BoundField DataField="Dr_Cr" HeaderText="Dr_Cr" SortExpression="Dr_Cr" ItemStyle-HorizontalAlign="Center" />
                                    </Columns>
                                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                                    <FooterStyle BackColor="#CCCC99" Font-Bold="true" HorizontalAlign="Right" />
                                    <EmptyDataTemplate>
                                        No Record Found.
                                    </EmptyDataTemplate>
                                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                    <AlternatingRowStyle BackColor="White" />
                                    <PagerSettings Position="TopAndBottom" />
                                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                    SelectCommand="s_Pos_Download_Batch_view" SelectCommandType="StoredProcedure"
                                    OnSelected="SqlDataSource1_Selected">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="DownloadBatch" QueryStringField="batch" Type="Int32" />
                                        <asp:QueryStringParameter Name="Type" QueryStringField="type" Type="String" DefaultValue="SA" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </fieldset>
                        </div>
                    </td>
                
                    <td valign="top">
                        <div>
                            <fieldset class="fieldset">
                                <legend class="legend" ><b>Commission Amount</b></legend>
                                <asp:GridView ID="GridView2" runat="server" AllowSorting="True" BackColor="White"
                                    AllowPaging="True" PageSize="200" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                                    CellPadding="2" DataSourceID="SqlDataSource2" ForeColor="Black" AutoGenerateColumns="False"
                                    ShowFooter="true" CssClass="Grid" EnableSortingAndPagingCallbacks="True" OnRowDataBound="GridView2_RowDataBound">
                                    <Columns>
                                     <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="MerchantName" HeaderText="Merchant Name" SortExpression="MerchantName"
                                            ItemStyle-HorizontalAlign="Left" />
                                        <asp:BoundField DataField="AccountNo" HeaderText="AccountNo" SortExpression="AccountNo"
                                            ItemStyle-HorizontalAlign="Left" ItemStyle-Wrap="false" />
                                        <asp:BoundField DataField="Amount_tk" HeaderText="Amount" SortExpression="Amount_tk"
                                            ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" />
                                        <asp:BoundField DataField="Dr_Cr" HeaderText="Dr_Cr" SortExpression="Dr_Cr" ItemStyle-HorizontalAlign="Center" />
                                    </Columns>
                                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                                    <FooterStyle BackColor="#CCCC99" Font-Bold="true" HorizontalAlign="Right" />
                                    <EmptyDataTemplate>
                                        No Record Found.
                                    </EmptyDataTemplate>
                                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                    <AlternatingRowStyle BackColor="White" />
                                    <PagerSettings Position="TopAndBottom" />
                                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                    SelectCommand="s_Pos_Download_Batch_view" SelectCommandType="StoredProcedure"
                                    OnSelected="SqlDataSource1_Selected">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="DownloadBatch" QueryStringField="batch" Type="Int32" />
                                        <asp:QueryStringParameter Name="Type" QueryStringField="type" Type="String" DefaultValue="CA" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </fieldset>
                        </div>
                    </td>
                    <td valign="top">
                        <div>
                            <fieldset class="fieldset">
                                <legend class="legend"><b>Merchant Amount</b></legend>
                                <asp:GridView ID="GridView3" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                                    AutoGenerateColumns="False" BackColor="White" PagerSettings-Position="TopAndBottom"
                                    PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                                    ShowFooter="true" OnRowDataBound="GridView3_RowDataBound" BorderWidth="1px" CellPadding="2"
                                    PageSize="200" ForeColor="Black" DataSourceID="SqlDataSource3" Style="font-size: small"
                                    EnableSortingAndPagingCallbacks="True">
                                    <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                                    <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" VerticalAlign="Top" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="#">
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="MerchantName" HeaderText="Merchant Name" SortExpression="MerchantName"
                                            ItemStyle-HorizontalAlign="Left" />
                                        <asp:BoundField DataField="FromAccount" HeaderText="FromAccount" SortExpression="FromAccount"
                                            ItemStyle-HorizontalAlign="Left" ItemStyle-Wrap="false" />
                                        <asp:BoundField DataField="ToAccount" HeaderText="ToAccount" SortExpression="ToAccount"
                                            ItemStyle-HorizontalAlign="Left" ItemStyle-Wrap="false" />
                                        <asp:BoundField DataField="Amount_tk" HeaderText="Amount" SortExpression="Amount_tk"
                                            DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right" />
                                        <%--  <asp:BoundField DataField="Dr_Cr" HeaderText="Dr/Cr" SortExpression="Dr_Cr" />--%>
                                        <%--<asp:BoundField DataField="Trn_br_code" HeaderText="Trn_br_code" SortExpression="Trn_br_code" />--%>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCC99" Font-Bold="true" HorizontalAlign="Right" />
                                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                    <AlternatingRowStyle BackColor="White" />
                                    <%--<EmptyDataTemplate>
                    No Record(s) Found For download.
                </EmptyDataTemplate>--%>
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                    SelectCommand="s_Pos_Download_Batch_view" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="DownloadBatch" QueryStringField="batch" Type="Int32" />
                                        <asp:QueryStringParameter Name="Type" QueryStringField="type" Type="String" DefaultValue="MA" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </fieldset>
                        </div>
                    </td>
                </tr>
            </table>
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
