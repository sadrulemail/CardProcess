﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Card_Mailer.aspx.cs" Inherits="Card_Mailer" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        <asp:Label ID="lblTitle" runat="server" Text="Card Mailer"></asp:Label>
    </p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:Panel ID="Panel1" runat="server">
        <table class="SmallFont Panel1">
            <tr>
                <td>
                    Card Number Starts With:
                </td>
                <td>
                    <asp:TextBox ID="txtStartsWith" runat="server" Text="" MaxLength="20" Width="120px"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="cmdOK" runat="server" Text="Show" Width="80px" Font-Bold="true" 
                        onclick="cmdOK_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        ProviderName="<%$ ConnectionStrings:CardDataConnectionString.ProviderName %>"
        SelectCommand="s_CardMailer" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="EmpID" SessionField="EMPID" Type="string" />
            <asp:ControlParameter ControlID="txtStartsWith" PropertyName="Text" Name="StartsWith"
                Type="String" DefaultValue="" Size="20" ConvertEmptyStringToNull="false" />
            <asp:QueryStringParameter QueryStringField="batch" Name="Batch" />
        </SelectParameters>
    </asp:SqlDataSource>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" 
        Visible="true"
         ReportSourceID="CrystalReportSource1" DisplayStatusbar="false"
        HasCrystalLogo="False" ToolPanelView="None" ShowAllPageIds="true" HasDrilldownTabs="false"
        HasToggleGroupTreeButton="False" HasToggleParameterPanelButton="False" EnableParameterPrompt="false" />
    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server" EnableCaching="false">
        <Report FileName="Reports/CardMailer.rpt">
            <DataSources>
                <CR:DataSourceRef DataSourceID="SqlDataSource1" TableName="sp_TempCardMailer;1" />
            </DataSources>
            <Parameters>
                <CR:Parameter Name="EmpID" DefaultValue="." />
                <CR:Parameter Name="StartsWith" DefaultValue="." />
                <CR:Parameter Name="Batch" DefaultValue="." />
            </Parameters>
        </Report>
    </CR:CrystalReportSource>
    
</asp:Content>
