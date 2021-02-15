<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Upload_Email.aspx.cs" Inherits="Upload_Email" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function UploadError() {
            document.getElementById('ctl00_ContentPlaceHolder2_lblUploadStatus').innerHTML = "File Uploading Error. Please try again.";
        }

        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var contentType = args.get_contentType();
            var text = "Size of " + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += " and content type is '" + contentType + "'.";
            }
            document.getElementById('UploadBtn').style.visibility = "visible";
            document.getElementById('ctl00_ContentPlaceHolder2_lblUploadStatus').innerHTML = filename + " is successfully uploaded.<br>";

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        Upload Email Address</p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <img src="Images/email_logo.jpg" />
            <asp:Panel ID="Panel1" runat="server" Visible="false">
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
                    <asp:Button ID="cmdCheck" runat="server" Text="View Files Data" Width="200px" Font-Bold="true"
                        Height="30px" OnClick="cmdCheck_Click" />
                </span>
                <br />
            </asp:Panel>
            <asp:Panel ID="Panel2" runat="server">
                <asp:Button ID="cmdUpdate" runat="server" Text="UPDATE" Width="200px" Font-Bold="true"
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
                BorderColor="#E7E7FF" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="ObjectDataSource1"
                Style="font-size: small">
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <Columns>
                    <asp:BoundField DataField="CLIENT_ID" HeaderText="CLIENT_ID" SortExpression="CLIENT_ID" />
                    <asp:BoundField DataField="CardNumber" HeaderText="CardNumber" SortExpression="CardNumber" />
                    <asp:BoundField DataField="Email1" HeaderText="Email1" SortExpression="Email1" />
                    <asp:BoundField DataField="EmpID" HeaderText="EmpID" ItemStyle-HorizontalAlign="Center"
                        SortExpression="EmpID" />
                </Columns>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                InsertMethod="Insert" SelectMethod="GetData" TypeName="DataSet1TableAdapters.TempCardEmailTableAdapter">
                <InsertParameters>
                    <asp:Parameter Name="Client_ID" Type="Int32" />
                    <asp:Parameter Name="CardNumber" Type="String" />
                    <asp:Parameter Name="Email1" Type="String" />
                    <asp:Parameter Name="EmpID" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter Name="EmpID" SessionField="EMPID" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <br />
            <div style="display: inline-block" class="Panel1">
                <div style="font-size: large; font-weight: bolder">
                    Paste Bulk Emails:</div>
                <table>
                    <tr>
                        <td valign="top">
                            <asp:TextBox Text="" runat="server" ID="txtEmails" Width="400px" Height="300px" TextMode="MultiLine"
                                onfocus="this.select()"></asp:TextBox>
                        </td>
                        <td valign="top">
                            Email Group:<br />
                            <asp:DropDownList ID="dboGroup" runat="server" DataSourceID="SqlDataSourceEmailGroups"
                                DataTextField="GroupName" DataValueField="GroupID" AppendDataBoundItems="true">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ID="reqGroup" ControlToValidate="dboGroup"
                                Font-Bold="true" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSourceEmailGroups" runat="server" ConnectionString="<%$ ConnectionStrings:Report_DBConnectionString %>"
                                SelectCommand="SELECT * FROM [Email_Groups] where GroupID <> 0 ORDER BY [GroupName]"></asp:SqlDataSource>
                            <br />
                            <br />
                            <br />
                            <asp:Button ID="cmdEmailBulkSave" runat="server" Text="Save" Width="100px" Height="35px"
                                OnClick="cmdEmailBulkSave_Click" />
                            <br />
                            <asp:Label ID="lblBulkStatus" Font-Size="Large" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
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
