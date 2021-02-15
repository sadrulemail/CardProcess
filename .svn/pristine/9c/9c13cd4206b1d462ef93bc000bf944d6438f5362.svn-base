<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="npsb_itcl_DisputeCheck.aspx.cs" Inherits="npsb_itcl_DisputeCheck" %>

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
            $('#UploadBtn').show('Slow');
            $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html('<b>' + filename + '</b> is successfully uploaded.<br>');

        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Dispute Check
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="HidPageID" runat="server" Value="" />
            <asp:HiddenField ID="HidUploadTempFolder" runat="server" Value="" />
            <asp:Panel ID="Panel1" runat="server">
                <asp:Button ID="cmdClear" runat="server" Text="Clear All Data" CausesValidation="false"
                    OnClick="cmdClear_Click" Width="150px" Height="30px" /><br />
                <asp:ConfirmButtonExtender ID="cmdClear_ConfirmButtonExtender" runat="server" ConfirmText="Are you sure?"
                    Enabled="True" TargetControlID="cmdClear">
                </asp:ConfirmButtonExtender>
                <br />
                <div class="Panel1 ui-corner-all shadow" style="width: 600px; padding: 20px">
                    <asp:AsyncFileUpload ID="FileUpload1" runat="server" Width="500px" OnUploadedComplete="FileUpload1_UploadedComplete"
                        ThrobberID="myThrobber" OnClientUploadComplete="UploadComplete" OnClientUploadError="UploadError"
                        OnUploadedFileError="FileUpload1_UploadedFileError" UploaderStyle="Traditional"
                        CssClass="AsyncFileUploadField" />
                    <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" />
                    <asp:Label ID="lblUploadStatus" runat="server" Style="font-size: small;" Text="">
                
                    </asp:Label><br />
                    <div style="display: none;" id="UploadBtn">
                        <table>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="cmbType" runat="server">
                                        <asp:ListItem Value=""></asp:ListItem>
                                        <%--<asp:ListItem Value="OMNIBUS">OMNIBUS SWITCH REPORT</asp:ListItem>
                                        <asp:ListItem Value="ITCL">ITCL SWITCH REPORT</asp:ListItem>
                                        <asp:ListItem Value="DBBL_OLD">DBBL SWITCH REPORT (Old Format)</asp:ListItem>
                                        <asp:ListItem Value="DBBL">DBBL SWITCH REPORT (PDF)</asp:ListItem>
                                        <asp:ListItem Value="DBBL_TXT">DBBL SWITCH REPORT (TXT)</asp:ListItem>--%>
                                        <asp:ListItem Value="NPSB_ITCL">NPSB ITCL FILE</asp:ListItem>
                                        <asp:ListItem Value="NPSB">NPSB REPORT</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="cmbType"
                                        ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <asp:Button ID="cmdCheck" runat="server" Text="Save Data" Width="200px" Font-Bold="true"
                                        Height="30px" OnClick="cmdCheck_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                    TypeName="DataSet1TableAdapters.TempDisputeCheckTableAdapter">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_CardNo" Type="String" />
                        <asp:Parameter Name="Original_DT" Type="DateTime" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="CardNo" Type="String" />
                        <asp:Parameter Name="DT" Type="DateTime" />
                        <asp:Parameter Name="Amount" Type="Decimal" />
                        <asp:Parameter Name="Status" Type="String" />
                        <asp:Parameter Name="Type" Type="String" />
                        <asp:Parameter Name="Line" Type="String" />
                        <asp:Parameter Name="EmpID" Type="String" />
                        <asp:Parameter Name="Account" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <br />
                <br />
                <table style="font-size: small" class="Panel1 ui-corner-all">
                    <tr>
                        <td>
                            Dispute Date:
                        </td>
                        <td>
                            <asp:TextBox ID="txtReportDate" runat="server" CssClass="Date" Width="80px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="dboReportType" runat="server">
                                <asp:ListItem>OMNIBUS Dispute</asp:ListItem>
                                <asp:ListItem>DBBL Dispute</asp:ListItem>
                                <asp:ListItem>On Us Dispute</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <td>
                                <asp:Button ID="cmdDuplicateCheck" runat="server" Text="Check" Width="100px" OnClick="cmdDuplicateCheck_Click"
                                    CausesValidation="false" />
                            </td>
                            <asp:Label ID="lblReportStatus" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" CssClass="Grid" AutoGenerateColumns="False"
                    BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical"
                    Style="font-size: small" OnDataBound="GridView1_DataBound" ShowFooter="True">
                    <RowStyle BackColor="#F7F7DE" />
                    <Columns>
                        <asp:BoundField DataField="CardNo" HeaderText="CardNo" SortExpression="CardNo" />
                        <asp:BoundField DataField="DT" HeaderText="DT" SortExpression="DT" ItemStyle-HorizontalAlign="Center">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:N2}"
                            SortExpression="Amount" ItemStyle-HorizontalAlign="Right">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Line" HeaderText="Line" SortExpression="Line" />
                    </Columns>
                    <FooterStyle BackColor="#CCCC99" Font-Bold="true" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                    <EmptyDataTemplate>
                        No Data Found.
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="sp_ITCL_OMNIBUS_Dispute" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtReportDate" Name="D" PropertyName="Text" Type="DateTime" />
                        <asp:SessionParameter Name="EmpID" SessionField="EMPID" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:Button ID="cmdExport" runat="server" Text="Export" Width="80px" CausesValidation="false"
                    OnClick="cmdExport_Click" Visible="false" Style="font-weight: 700" />
                <asp:Button ID="cmdExport2" runat="server" Text="Export2" Width="80px" CausesValidation="false"
                    OnClick="cmdExport2_Click" Visible="false" Style="font-weight: 700" />
                <asp:Label ID="lblGridStatus" runat="server" Text="" Style="font-size: small"></asp:Label>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="cmdExport" />
        </Triggers>
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
