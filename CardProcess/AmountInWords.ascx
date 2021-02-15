<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AmountInWords.ascx.cs" Inherits="AmountInWords" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<link href="CSS/EMP.css" rel="stylesheet" type="text/css" />
<asp:Label ID="lblAmountInWords" runat="server" Text="" CssClass="UserLabel"></asp:Label>
<asp:HoverMenuExtender runat="server" ID="HoverMenuExtenderlblAmountInWords" DynamicControlID="AmountInWordsInfo"
    DynamicServiceMethod="getAmountInWordsInfo" DynamicServicePath="userServices.asmx" TargetControlID="lblAmountInWords"
    PopupControlID="AInfo" OffsetY="-20" OffsetX="-50" CacheDynamicResults="true" HoverDelay="500">
</asp:HoverMenuExtender>
<asp:Panel runat="server" ID="AmountInWordsInfo" CssClass="UserName">
</asp:Panel>