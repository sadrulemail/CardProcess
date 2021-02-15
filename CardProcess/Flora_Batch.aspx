<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Flora_Batch.aspx.cs" Inherits="Flora_Batch" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">Flora Batch
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<uc1:TrustControl ID="TrustControl1" runat="server" />
    
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <div class="Panel1" style="display:inline-block">
            <asp:TextBox ID="txtBatch" runat="server" Width="100px" placeholder="batch number">
            </asp:TextBox><asp:Button ID="cmdOK" runat="server" Text="Show"  Width="80px" />
                </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Report_DBConnectionString %>"
                SelectCommand="s_Flora_Daily_Batch" SelectCommandType="StoredProcedure" OnSelected="SQl1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtBatch" PropertyName="Text" Name="Batch" />
                    
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" CssClass="Grid" 
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="batchno" HeaderText="batchno" ReadOnly="True" SortExpression="batchno" />
                    <asp:BoundField DataField="accountno" HeaderText="accountno" ReadOnly="True" SortExpression="accountno" />
                    <asp:BoundField DataField="amount_tk" HeaderText="amount_tk" ReadOnly="True" ItemStyle-HorizontalAlign="Right" SortExpression="amount_tk" />
                    <asp:BoundField DataField="dr_cr" HeaderText="dr_cr" ReadOnly="True" SortExpression="dr_cr" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="remark" HeaderText="Remarks" ReadOnly="True" SortExpression="remark" />
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#F7F7DE" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:Literal ID="lblStatus" runat="server" Text=""></asp:Literal>
            <div>
                <asp:Button ID="cmdExport" runat="server" Text="Export xlsx" Width="120px" Font-Bold="true"
                Height="30px" OnClick="cmdExport_Click" Visible="false"  />
            </div>
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

