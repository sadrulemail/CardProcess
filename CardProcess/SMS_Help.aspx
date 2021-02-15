<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SMS_Help.aspx.cs" Inherits="SMS_Help" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    SMS Help
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <table>
        <tr>
            <td class="Panel1 ui-corner-all" style="font-size:x-large; font-weight:bold;padding:15px">
                
                    Send SMS to +88-017-555-43217
            </td>
        </tr>
        <tr>
            <td>
                <h3>
                    SMS Formats:</h3>
            </td>
        </tr>
        <tr>
            <td style="background-color: #F7F7DE; font-weight: bold; padding: 3px">
                <b>Card Activation Request:</b>
            </td>
        </tr>
        <tr>
            <td>
                CA {CARD NUMBER} {NAME}, {DOB}, {Father's Name}, {Mother's Name}
            </td>
        </tr>
    </table>
</asp:Content>
