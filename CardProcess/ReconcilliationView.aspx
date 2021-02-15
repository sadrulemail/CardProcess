<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReconciliationFile_Upload.aspx.cs" Inherits="ReconciliationFile_Upload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReconcilliationView.aspx.cs" Inherits="ReconcilliationView" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Reconciliation View</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                    AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" AutoGenerateColumns="False"
                    CssClass="Grid" EnableSortingAndPagingCallbacks="True">
                    <Columns>
                        <%--<asp:BoundField DataField="Batch" HeaderText="Batch" SortExpression="Batch" InsertVisible="False"
                            ReadOnly="True" />--%>
                        <asp:BoundField DataField="TransCat" HeaderText="Transaction Category" SortExpression="TransCat"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="posting_date" HeaderText="Posting Date" DataFormatString="{0:dd-MMM-yyyy}"
                            SortExpression="posting_date" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="transaction_date" HeaderText="Transaction Date" SortExpression="transaction_date"
                            ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yyyy}" />
                        <asp:BoundField DataField="card_no" HeaderText="Card No" SortExpression="card_no"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="card_holder_acc_no" HeaderText="Card Holder Account No"
                            SortExpression="card_holder_acc_no" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="marchant_acc_no" HeaderText="Merchant Account No" SortExpression="marchant_acc_no"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="txn_name" HeaderText="Transaction Name" SortExpression="txn_name"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="txn_type" HeaderText="Transaction Type" SortExpression="txn_type"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="txn_amount" HeaderText="Transaction Amount" SortExpression="txn_amount"
                            ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="commission_amount" HeaderText="Commission Amount" SortExpression="commission_amount"
                            ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="payment_amount" HeaderText="Payment Amount" SortExpression="payment_amount"
                            ItemStyle-HorizontalAlign="Right" />
                        <asp:TemplateField HeaderText="By Emp" SortExpression="EmpID">
                            <ItemTemplate>
                                <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="DT" HeaderText="Upload Date" SortExpression="DT" DataFormatString="{0:dd-MMM-yyyy}"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="TransCat" HeaderText="Transaction Category" SortExpression="TransCat"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="EndDate" HeaderText="Reconciliation Date" SortExpression="EndDate"
                            ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yyyy}" />
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" />
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
                <asp:Label Font-Names="Arial" runat="server" ID="lblStatus" Text="" Font-Size="Small"></asp:Label>
                <br />
                <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_ReconciliationUploadBatchWise" SelectCommandType="StoredProcedure"
                    OnSelected="SqlDataSource1_Selected">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="batchId" QueryStringField="batchId" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
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
