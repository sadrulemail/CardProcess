﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SMS_Upload.aspx.cs" Inherits="SMS_Upload" Culture="en-NZ" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function UploadError() {
            $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html("File Uploading Error. Please try again.");
        }

        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var contentType = args.get_contentType();
            var text = "Size of " + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += " and content type is '" + contentType + "'.";
            }
            document.getElementById('UploadBtn').style.visibility = "visible";
            $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html(filename + " is successfully uploaded.<br>");

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Bulk SMS Send
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server">
                <div class="SmallFont" style="padding: 7px; width: 300px; background-color: #FFFFB5;
                    border: solid 1px green; margin: 0px 0px 10px 0px">
                    To send bulk sms, please select excel file (*.xlsx):</div>
                <asp:AsyncFileUpload ID="FileUpload1" runat="server" Width="300px" OnUploadedComplete="FileUpload1_UploadedComplete"
                    ThrobberID="myThrobber" OnClientUploadComplete="UploadComplete" OnClientUploadError="UploadError"
                    OnUploadedFileError="FileUpload1_UploadedFileError" UploaderStyle="Traditional"
                    CssClass="AsyncFileUploadField" />
                <br />
                <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" />
                <br />
                <asp:Label ID="lblUploadStatus" runat="server" Style="font-size: small; font-weight: 700"
                    Text="">
                
                </asp:Label><br />
                <span style="visibility: hidden" id="UploadBtn">
                    <asp:Button ID="cmdCheck" runat="server" Text="View Data" Width="150px" Font-Bold="true"
                        Height="30px" OnClick="cmdCheck_Click" />
                </span>
                <br />
            </asp:Panel>
            <asp:Panel ID="Panel2" runat="server">
                <asp:TextBox runat="server" ID="txtStartDT" CssClass="DateTime"></asp:TextBox>
                <asp:Button ID="cmdUpdate" runat="server" Text="Send Now" Width="150px" Font-Bold="true"
                    Height="30px" OnClick="cmdUpdate_Click" />
                <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Are you sure?"
                    Enabled="True" TargetControlID="cmdUpdate">
                </asp:ConfirmButtonExtender>
                <br />
                <br />
                <asp:Label Font-Bold="true" ID="lblStatus" runat="server" Text=""></asp:Label>
                <br />
                <br />
            </asp:Panel>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                CssClass="Grid" BorderColor="#E7E7FF" BorderStyle="Solid" BorderWidth="1px" CellPadding="3"
                DataSourceID="ObjectDataSource1" Style="font-size: small" AllowPaging="true"
                PageSize="100">
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" CssClass="Grid" />
                <Columns>
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" />
                    <asp:BoundField DataField="Msg" HeaderText="Msg" SortExpression="Msg" ItemStyle-Wrap="false" />
                    <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" ItemStyle-HorizontalAlign="Center" />
                </Columns>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" CssClass="PagerStyle" />
                <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
            <asp:SqlDataSource ID="ObjectDataSource1" runat="server" SelectCommand="SELECT * FROM dbo.Temp_Msg WHERE SESSIONID = @SessionID"
                ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" OnSelected="ObjectDataSource1_Selected1">
                <SelectParameters>
                    <asp:SessionParameter Name="SessionID" SessionField="SESSIONID" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
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
