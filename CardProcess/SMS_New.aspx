﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SMS_New.aspx.cs" Inherits="SMS_New" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Send New SMS
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            
            <table class="Panel1 ui-corner-all" style="margin-left:100px">
                <tr>
                    <td>
                        <table>
                            <tr>                                
                                <td valign="top" style="padding: 7px">
                                    <table>
                                        <tr>
                                            <td style="font-size: small">
                                                <b>To:</b>
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtTo" Text="+880" Width="250px" MaxLength="20" Font-Size="X-Large" Font-Bold="true"></asp:TextBox>
                                                <asp:LinkButton ID="lnlAshik" runat="server" OnClick="lnlAshik_Click" ToolTip="017">Ashik</asp:LinkButton>                                                
                                                <asp:LinkButton ID="lnlImam" runat="server" OnClick="lnlImam_Click" ToolTip="015">Imam</asp:LinkButton>                                                
                                                <asp:LinkButton ID="lnlSadrul" runat="server" OnClick="lnlSadrul_Click" ToolTip="018">Sadrul</asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="font-size: small" valign="top">
                                                <b>Message:</b>
                                                 <br /><br />
                                                <asp:LinkButton ID="lnkSimple" runat="server" OnClick="lnkSimple_Click">Simple</asp:LinkButton>
                                                <br /><br />
                                                <asp:LinkButton ID="lnkComplex" runat="server" OnClick="lnkComplex_Click">Complex</asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtMsg" Text="This is a test SMS." MaxLength="160" Width="500px" TextMode="MultiLine"
                                                    Rows="6" Font-Names="Arial" Font-Size="X-Large" Font-Bold="true"></asp:TextBox>
                                                <asp:Label runat="server" ID="lblSMSCount" Text="160" Font-Size="Small"></asp:Label>
                                               
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                <asp:Button runat="server" ID="txtSend" Text="Send SMS" Width="100px" OnClick="txtSend_Click" Height="35px" />
                                                <asp:ConfirmButtonExtender ID="txtSend_ConfirmButtonExtender" runat="server" ConfirmText="Do you want to send SMS?"
                                                    Enabled="True" TargetControlID="txtSend">
                                                </asp:ConfirmButtonExtender>
                                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SMSConnectionString %>"
                                                    SelectCommand="sp_SMS_Send" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="txtTo" Name="Mobile" PropertyName="Text" Type="String" />
                                                        <asp:ControlParameter ControlID="txtMsg" Name="Msg" PropertyName="Text" Type="String" />
                                                        <asp:Parameter DefaultValue="19" Name="APPID" Type="Int32" />
                                                        <asp:SessionParameter Name="EmpID" SessionField="EMPID" Type="String" />
                                                        <asp:Parameter DefaultValue="1" Name="Priority" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
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