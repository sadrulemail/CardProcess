<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Upload_Card_No.aspx.cs" Inherits="Upload_Card_No" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function UploadError() {
            $('ctl00_ContentPlaceHolder2_lblUploadStatus').html('File Uploading Error. Please try again.');
        }

        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var contentType = args.get_contentType();
            var text = "Size of " + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += " and content type is '" + contentType + "'.";
            }
            $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html('<b>' + filename + '</b> is successfully uploaded.');
            $('#UploadBtn').show('slow');
        }
    </script>
    <style type="text/css">
        .Border1
        {
            background-color: #FFFFB5;
            padding: 10px;
            border: solid 1px green;
            width: 200px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Upload Card No.
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div id="tabs" style="width: 100%">
                <ul>
                    <li style="display: inline"><a href='#upload'>Upload</a></li><li style="display: inline">
                        <a href='#history'>History</a></li></ul>
                <div id="upload">
                    <asp:Button ID="cmdClearData" runat="server" Text="Clear Data" OnClick="cmdClearData_Click"
                        Visible="false" />
                    <br />
                    <asp:Panel ID="Panel1" runat="server">
                        <div class="Panel1 ui-corner-all" style="width: 600px; padding: 15px">
                            <b>Select zip file:</b>
                            <asp:AsyncFileUpload ID="FileUpload1" runat="server" Width="300px" Style="margin: 10px"
                                OnUploadedComplete="FileUpload1_UploadedComplete" ThrobberID="myThrobber" OnClientUploadComplete="UploadComplete"
                                OnClientUploadError="UploadError" OnUploadedFileError="FileUpload1_UploadedFileError"
                                UploaderStyle="Traditional" CssClass="AsyncFileUploadField" />
                            <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" />
                            <br />
                            <asp:Label ID="lblUploadStatus" runat="server" Style="font-size: small;" Text="">
                
                            </asp:Label></div>
                        <div style="display: none; padding-top: 10px" id="UploadBtn">
                            <table>
                                <tr>
                                    <td valign="bottom">
                                        <div class="Border1">
                                            <span style="font-size: larger; font-weight: bold">For Piped Document:</span>
                                            <table class="SmallFont" width="100%">
                                                <tr>
                                                    <td>
                                                        ITCL ID Column:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtItclID" runat="server" Width="20px" Text="1" CssClass="Center"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td>
                                                        Customer Name Column:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtCustomerNameID" runat="server" Width="20px" Text="2" CssClass="Center"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Name on Card:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtNameOnCard" runat="server" Width="20px" Text="3" CssClass="Center"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Card No Column:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtCardNoColumn" runat="server" Width="20px" Text="4" CssClass="Center"></asp:TextBox>
                                                    </td>
                                                </tr>
                                               
                                                
                                                <tr>
                                                    <td>
                                                        Status Column:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtStatus" runat="server" Width="20px" Text="7" CssClass="Center"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Account No Column:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtAccNoColumn" runat="server" CssClass="Center" Text="8" Width="20px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Address:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtAddress" runat="server" Width="20px" Text="9" CssClass="Center"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                
                                                <tr>
                                                    <td>
                                                        Create Date:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtCreated" runat="server" Width="20px" Text="10" CssClass="Center"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        E-Commerce Status:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtECommStatus" runat="server" Width="20px" Text="11" CssClass="Center"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Email Column:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtEmail" runat="server" Width="20px" Text="12" CssClass="Center"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                
                                            </table>
                                            <asp:Button ID="cmdCheck" runat="server" Text="View Files Data" Width="200px" Font-Bold="true"
                                                Height="30px" OnClick="cmdCheck_Click" />
                                        </div>
                                    </td>
                                    <td style="padding: 20px" valign="bottom">
                                        <h3>
                                            OR</h3>
                                    </td>
                                    <td valign="bottom">
                                        <div class="Border1">
                                            <span style="font-size: larger; font-weight: bold">For Flat File:</span>
                                            <br />
                                            <br />
                                            <asp:Button ID="cmdCheckFlat" runat="server" Text="View Files Data" Width="200px"
                                                Font-Bold="true" Height="30px" OnClick="cmdCheckFlat_Click" CausesValidation="false"
                                                Enabled="false" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br />
                    </asp:Panel>
                    <asp:Panel ID="Panel2" runat="server">
                        <asp:Button ID="cmdUpdate" runat="server" Text="Update Card Numbers" Width="200px"
                            Font-Bold="true" Height="30px" OnClick="cmdUpdate_Click" />
                        <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Are you sure?"
                            Enabled="True" TargetControlID="cmdUpdate">
                        </asp:ConfirmButtonExtender>
                        <br />
                        <br />
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                        <br />
                        <br />
                    </asp:Panel>
                    <asp:Panel ID="Panel3" runat="server">
                        <asp:Button ID="cmdUpdate0" runat="server" Font-Bold="true" Height="30px" OnClick="cmdUpdate0_Click"
                            Text="Update Card Numbers (Old)" Width="200px" />
                        <asp:ConfirmButtonExtender ID="ConfirmButtonExtender0" runat="server" ConfirmText="Are you sure?"
                            Enabled="True" TargetControlID="cmdUpdate0">
                        </asp:ConfirmButtonExtender>
                        <br />
                        <br />
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                        <br />
                        <br />
                    </asp:Panel>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                        AllowSorting="true" BorderColor="#4A3C8C" BorderStyle="Solid" BorderWidth="1px"
                        CellPadding="4" DataKeyNames="AccountNo" CssClass="Grid" DataSourceID="ObjectDataSource1"
                        Style="font-size: small" AllowPaging="true">
                        <PagerSettings Mode="NumericFirstLast" PageButtonCount="30" Position="TopAndBottom" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <Columns>
                            <asp:BoundField DataField="ITCLID" HeaderText="ITCL ID" ReadOnly="True" SortExpression="ITCLID" />
                            <asp:BoundField DataField="AccountNo" HeaderText="AccountNo" ReadOnly="True" SortExpression="AccountNo" />
                            <asp:BoundField DataField="CardNo" HeaderText="CardNo" SortExpression="CardNo" />
                            <asp:BoundField DataField="CustomerName" HeaderText="CustomerName" SortExpression="CustomerName" />
                            <asp:BoundField DataField="Email1" HeaderText="Email1" SortExpression="Email1" />
                            <asp:BoundField DataField="Email2" HeaderText="Email2" SortExpression="Email2" Visible="false" />
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Left" CssClass="PagerStyle1" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                        TypeName="DataSet1TableAdapters.TempImportTableAdapter" UpdateMethod="Update">
                        <DeleteParameters>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="AccountNo" Type="String" />
                            <asp:Parameter Name="CardNo" Type="String" />
                            <asp:Parameter Name="CustomerName" Type="String" />
                            <asp:Parameter Name="Email1" Type="String" />
                            <asp:Parameter Name="Email2" Type="String" />
                            <asp:Parameter Name="ITCLID" Type="String" />
                            <asp:Parameter Name="Status" Type="String" />
                            <asp:Parameter Name="CREATED" Type="DateTime" />
                            <asp:Parameter Name="SessionID" Type="String" />
                            <asp:Parameter Name="InsertDT" Type="DateTime" />
                            <asp:Parameter Name="ECommerce" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:SessionParameter Name="SessionID" SessionField="SessionID" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </div>
                <div id="history">
                    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                        AutoGenerateColumns="False" BackColor="White" Width="650px" PagerSettings-Position="TopAndBottom"
                        PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                        BorderWidth="1px" CellPadding="4" PageSize="20" DataKeyNames="ID" DataSourceID="SqlDataSourceDataUploadLog"
                        ForeColor="Black" Style="font-size: small" EnableSortingAndPagingCallbacks="True">
                        <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                        <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                SortExpression="ID" />
                            <asp:TemplateField HeaderText="Uploaded On" SortExpression="DT" ItemStyle-Wrap="false"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <span title='<%# Eval("DT", "{0:dddd, \nd MMMM, yyyy \nh:mm:ss tt}")%>'>
                                        <%# TrustControl1.ToRecentDateTime(Eval("DT"))%></span></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="About" SortExpression="DT" ItemStyle-Wrap="false"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# TrustControl1.ToRelativeDate((DateTime)Eval("Dt")) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="By Emp" SortExpression="EmpID">
                                <ItemTemplate>
                                    <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="TotalRows" HeaderText="Total Rows" SortExpression="TotalRows"
                                DataFormatString="{0:N0}" />
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceDataUploadLog" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="SELECT top 50 * FROM [DataUploadLog] ORDER BY [ID] DESC"></asp:SqlDataSource>
                </div>
            </div>
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
