<%@ Page Title="" Language="C#" AutoEventWireup="true"
    CodeFile="PINForwarding.aspx.cs" Inherits="PINForwarding" EnableViewState="true" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <uc1:TrustControl ID="TrustControl1" runat="server" />


            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                ProviderName="<%$ ConnectionStrings:CardDataConnectionString.ProviderName %>"
                SelectCommand="s_PIN_Reissue_Mailer" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Batch" QueryStringField="batch" Type="Int32"
                        ConvertEmptyStringToNull="false" />
                </SelectParameters>
            </asp:SqlDataSource>

            <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
        Height="1039px" ReportSourceID="CrystalReportSource1" Width="901px" DisplayStatusbar="false"
        HasCrystalLogo="False" ToolPanelView="None" ShowAllPageIds="true" HasDrilldownTabs="false"
        HasToggleGroupTreeButton="False" HasToggleParameterPanelButton="False" />
            <CR:CrystalReportSource ID="CrystalReportSource1" runat="server" EnableCaching="False">
                <Report FileName="Reports/CR_PINForwarding.rpt">

                    <DataSources>
                        <CR:DataSourceRef DataSourceID="SqlDataSource1"
                            TableName="s_PIN_Reissue_Mailer" />
                    </DataSources>

                    <Parameters>
                        <CR:Parameter Name="PreparedBy" DefaultValue="" ConvertEmptyStringToNull="false" />
                        <CR:Parameter Name="Designation" DefaultValue="" ConvertEmptyStringToNull="false" />
                    </Parameters>
                </Report>
            </CR:CrystalReportSource>
        </div>
    </form>
</body>
</html>
