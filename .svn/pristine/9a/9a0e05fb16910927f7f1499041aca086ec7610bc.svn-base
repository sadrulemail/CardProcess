<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ATM_Instruction_Print.aspx.cs" Inherits="ATM_Instruction_Print" %>
<%@ Register src="TrustControl.ascx" tagname="TrustControl" tagprefix="uc1" %>
<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<uc1:TrustControl ID="TrustControl1" runat="server" />
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server"  
        AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="1202px" 
        ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl="" 
        ToolPanelWidth="200px" Width="1104px"  OnAfterRender="CrystalReportViewer1_AfterRender" />
    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server" EnableCaching="false">
        <Report FileName="Reports\ATM_Instruction_Print.rpt">
            <DataSources>
                <CR:DataSourceRef DataSourceID="SqlDataSource1" 
                    TableName="s_ATM_Instruction_Print;1" />
            </DataSources>
        </Report>
    </CR:CrystalReportSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" 
        SelectCommand="s_ATM_Instruction_Print" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="Id" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

