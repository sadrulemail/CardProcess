<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReconciliationFile_Upload.aspx.cs" Inherits="ReconciliationFile_Upload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="POS_Upload_Log.aspx.cs" Inherits="POS_Upload_Log" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .Border1
        {
            background-color: #FFFFB5;
            padding: 10px;
            border: solid 1px green;
            width: 200px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    POS Download Log</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                AutoGenerateColumns="False" BackColor="White" Width="800px" PagerSettings-Position="TopAndBottom"
                PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                BorderWidth="1px" CellPadding="4" PageSize="20" DataKeyNames="Batch" ForeColor="Black"
                DataSourceID="SqlDataSourceDataUploadLog" Style="font-size: small" EnableSortingAndPagingCallbacks="True" OnRowCommand="GridView2_OnRowCommand">
                <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                <Columns>
                    <asp:TemplateField HeaderText="View Data" SortExpression="Batch">
                        <ItemTemplate>
                            <a href='ReconcilliationView.aspx?batchid=<%# Eval("Batch") %>' target="_blank" class="Link">
                                <span style="color: blue">
                                    <%# Eval("Batch") %></span></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="Batch" HeaderText="Batch" InsertVisible="False" ReadOnly="True"
                                SortExpression="Batch" />--%>
                    <asp:BoundField DataField="DT" HeaderText="Upload On" SortExpression="Upload On"
                        DataFormatString="{0:dd/MM/yyyy}" />
                   
                    <asp:TemplateField HeaderText="By Emp" SortExpression="EmpID">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Total" HeaderText="Total Records" SortExpression="Total"
                        DataFormatString="{0:N0}" />
                  
                    <asp:BoundField DataField="payment_receipt_from_visa" HeaderText="Payment Receipt From Visa"
                        SortExpression="payment_receipt_from_visa" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="TransCat" HeaderText="Transaction Category" SortExpression="TransCat" />
                   <%-- <asp:BoundField DataField="EndDate" HeaderText="Reconciliation Date" SortExpression="EndDate"
                        DataFormatString="{0:dd/MM/yyyy}" />--%>

                     <asp:BoundField DataField="DownloadBatch" HeaderText="Download Batch" SortExpression="DownloadBatch"/>
                      <asp:BoundField DataField="DownloadCount" HeaderText="Download Count" SortExpression="DownloadCount"/>
                      <asp:TemplateField HeaderText="Download By" SortExpression="DownloadBY">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("DownloadBY") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DownloadDT" HeaderText="Download DT" SortExpression="DownloadDT"
                        DataFormatString="{0:dd/MM/yyyy}" />
                         
                 
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceDataUploadLog" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Pos_Download_Log" SelectCommandType="StoredProcedure">
            </asp:SqlDataSource>
            </div> </div>
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
