<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Forwarding.aspx.cs" Inherits="Forwarding" EnableViewState="true" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        <asp:Label ID="lblTitle" runat="server" Text="Forwarding"></asp:Label>
    </p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:Panel ID="Panel1" runat="server">
        <asp:HiddenField runat="server" ID="hivReference" Value="     " />
        <table class="SmallFont">
            <tr>
                <td>
                    Ref: TBL/HO/DBD/
                </td>
                <td>
                    <asp:TextBox ID="txtRef" runat="server" Width="50px"></asp:TextBox>
                </td>
                <td>
                    /<asp:Label runat="server" ID="lblYear"></asp:Label>
                </td>
                <td>
                    <asp:Button ID="cmdOK" runat="server" OnClick="cmdOK_Click" Text="Show" Width="80px"
                        Font-Bold="true" Height="35px" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
        Height="1039px" ReportSourceID="CrystalReportSource1" Width="901px" DisplayStatusbar="false"
        HasCrystalLogo="False" ToolPanelView="None" ShowAllPageIds="true" HasDrilldownTabs="false"
        HasToggleGroupTreeButton="False" HasToggleParameterPanelButton="False" />
    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        <Report FileName="Reports/CR_BranchForwarding.rpt">
            <DataSources>
                <CR:DataSourceRef DataSourceID="SqlDataSource1" TableName="sp_Forwarding" />
            </DataSources>
            <Parameters>
                <CR:Parameter Name="PreparedBy" DefaultValue />
                <CR:Parameter Name="Designation" DefaultValue />
                <CR:Parameter Name="ForwardingID" DefaultValue />
            </Parameters>
        </Report>
    </CR:CrystalReportSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        ProviderName="<%$ ConnectionStrings:CardDataConnectionString.ProviderName %>"
        SelectCommand="sp_Forwarding_Browse" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="Batch" QueryStringField="batch" Type="string" ConvertEmptyStringToNull="false" />
            <asp:QueryStringParameter Name="Date" QueryStringField="date" Type="String" ConvertEmptyStringToNull="false" DefaultValue="01/01/1900" />
            
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
