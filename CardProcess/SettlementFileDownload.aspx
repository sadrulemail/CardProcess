<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SettlementFileDownload.aspx.cs" Inherits="SettlementFileDownload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SettlementFileDownload.aspx.cs" Inherits="SettlementFileDownload" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    
    <%--<asp:SqlDataSource ID="SqlDataSourceReExport" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="sp_ExportToITCL_Offline_CSV" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="branches" Name="BranchCodes" Type="String"
                DefaultValue="*" />
            <asp:QueryStringParameter QueryStringField="batch" Name="BatchID" Type="Int32" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="sp_ExportToITCL_Offline_xlsx" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="branches" Name="BranchCodes" Type="String"
                DefaultValue="*" />
            <asp:QueryStringParameter QueryStringField="batch" Name="BatchID" Type="Int32"  />
        </SelectParameters>
    </asp:SqlDataSource>--%>


    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="S_Settlement_txtDownload" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="type" Name="type" Type="String"
                DefaultValue="*" />
            <asp:QueryStringParameter QueryStringField="batchid" Name="batchid" Type="Int32"  />
            <asp:QueryStringParameter QueryStringField="empid" Name="empid" Type="String"  />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="S_Settlement_txtDownloadDrCr" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="type" Name="type" Type="String"
                DefaultValue="*" />
            <asp:QueryStringParameter QueryStringField="batchid" Name="batchid" Type="Int32"  />
            <asp:QueryStringParameter QueryStringField="empid" Name="empid" Type="String"  />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
