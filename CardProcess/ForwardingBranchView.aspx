<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ForwardingBranchView.aspx.cs" Inherits="DisputeLetterPrint" EnableViewState="true" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
        <asp:Label ID="lblTitle" runat="server" Text="Forwarding"></asp:Label>    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />

    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        <Report FileName="Reports/CR_BranchForwardingView.rpt">
            <DataSources>
                <CR:DataSourceRef DataSourceID="SqlDataSource1" TableName="s_ForwardingForBranch_Browse" />
            </DataSources>
            <Parameters>
            </Parameters>
        </Report>
    </CR:CrystalReportSource>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" OnAfterRender="CrystalReportViewer1_AfterRender"
        AutoDataBind="true"
        ReportSourceID="CrystalReportSource1" DisplayStatusbar="false"
        EnableParameterPrompt="False" EnableDatabaseLogonPrompt="False" Visible="true" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="s_ForwardingForBranch_Browse" SelectCommandType="StoredProcedure" EnableCaching="false" OnSelected="SqlDataSource1_Selected">
        <SelectParameters>
            <asp:QueryStringParameter Name="Batch" QueryStringField="id" Type="String" />             
            <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
