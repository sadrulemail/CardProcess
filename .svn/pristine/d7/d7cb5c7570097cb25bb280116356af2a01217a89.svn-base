<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Atm_Upload.aspx.cs" Inherits="Atm_Upload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Atm_Upload.aspx.cs" Inherits="Atm_Upload" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .AsyncFileUploadField input
        {
            width: 95% !important;
        }
    </style>
    <script type="text/javascript">
        function AssemblyFileUpload_Started(sender, args) {
            $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html('');
            var filename = args.get_fileName();
            var ext = filename.substring(filename.lastIndexOf(".") + 1);
            if (ext.toLowerCase() != 'xlsx') {
                $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html('Only XLSX files can be uploaded.');
                $('#UploadBtn').hide('Slow');
                throw {
                    name: "Invalid File Type",
                    level: "Error",
                    message: "Only <b>XLSX</b> files can be uploaded. ",
                    htmlMessage: "Only XLSX files can be uploaded. "
                }
                return false;
            }
            return true;
        }

        function UploadError(sender, args) {
            $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html(args.get_errorMessage() + 'File Uploading Error. Please try again.');
            $('#UploadBtn').hide('Slow');
        }

        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var contentType = args.get_contentType();
            var text = "Size of " + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += " and content type is '" + contentType + "'.";
            }
            $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html('<b>' + filename + '</b> is successfully uploaded.');
            $('#UploadBtn').show('Slow');
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
    Upload ATM Cashload Data File
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="HidPageID" runat="server" Value="" />
            <asp:HiddenField ID="HidUploadTempFile" runat="server" Value="" />
            <div id="tabs" style="width: 900px;">
                <ul>
                    <li style="display: inline"><a href='#upload'>Upload</a></li><li style="display: inline">
                        <a href='#history'>History</a></li></ul>
                <div id="upload">
                    <asp:Button ID="cmdClearData" runat="server" Text="Clear Data" OnClick="cmdClearData_Click"
                        Visible="false" />
                    <asp:Button ID="cmdDataBind" runat="server" Text="Data Bind" Visible="false" OnClick="cmdDataBind_Click" />
                    <asp:Panel ID="Panel1" runat="server">
                        <div class="Panel1 ui-corner-all" style="padding: 0 0 0 20px; width: 600px">
                            <div style="font-size: small; font-weight: bolder; padding: 10px 0px 3px 0px;">
                                Please select XLSX file to upload data:</div>
                            <asp:AsyncFileUpload ID="FileUpload1" runat="server" Width="550px" OnUploadedComplete="FileUpload1_UploadedComplete"
                                ThrobberID="myThrobber" OnClientUploadComplete="UploadComplete" OnClientUploadError="UploadError"
                                OnUploadedFileError="FileUpload1_UploadedFileError" UploaderStyle="Traditional"
                                CssClass="AsyncFileUploadField" OnClientUploadStarted="AssemblyFileUpload_Started" />
                            <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" />
                            <div style="padding: 5px 0px 10px 0px">
                                <asp:Label ID="lblUploadStatus" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <table style="display: none;" id="UploadBtn">
                            <tr>
                                <td style="padding: 10px 0 0 0">
                                    <div class="ui-corner-all Panel1">
                                        <span style="font-size: larger; font-weight: bold"></span>
                                        <table class="SmallFont">
                                            <tr>
                                                <td>
                                                    Worksheet:
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtWorksheet" Text="1" Width="30px" MaxLength="2"
                                                        onfocus="this.select()" Style="text-align: center"></asp:TextBox>
                                                    <asp:FilteredTextBoxExtender ID="txtWorksheet_FilteredTextBoxExtender" runat="server"
                                                        Enabled="True" TargetControlID="txtWorksheet" ValidChars="0123456789">
                                                    </asp:FilteredTextBoxExtender>
                                                </td>
                                                <td>
                                                </td>
                                                <td style="padding-left: 20px">
                                                    <asp:Button ID="cmdCheck" runat="server" Text="View Data" Width="120px" OnClick="cmdCheck_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <br />
                    </asp:Panel>
                    <div style="padding-left: 20px; text-align: right;" align="center">
                        <asp:Button ID="cmdSaveData" runat="server" Text="Save Data" Width="150px" Visible="false"
                            OnClick="cmdSaveData_SaveData" />
                        <asp:ConfirmButtonExtender runat="server" ID="confirmsave" TargetControlID="cmdSaveData"
                            ConfirmText="Do you want to Save?">
                        </asp:ConfirmButtonExtender>
                    </div>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="3" CssClass="Grid"
                        DataSourceID="ObjectDataSource1" Style="font-size: small" ShowFooter="false"
                        ForeColor="Black" GridLines="Vertical" PageSize="15" AllowPaging="true" OnDataBound="GridView1_DataBound">
                        <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" PageButtonCount="30" />
                        <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" ItemStyle-HorizontalAlign="Center"
                                ItemStyle-Wrap="false" ReadOnly="true" InsertVisible="False" Visible="false">
                            </asp:BoundField>
                            <asp:BoundField DataField="AtmID" HeaderText="Atm ID" SortExpression="AtmID" ItemStyle-HorizontalAlign="Left">
                            </asp:BoundField>
                            <asp:BoundField DataField="AtmName" HeaderText="Atm Name" ItemStyle-HorizontalAlign="Left"
                                SortExpression="AtmName" />
                            <asp:BoundField DataField="Caset1_NoteCount" HeaderText="Count (C1)" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Caset1_NoteCount" />
                            <asp:BoundField DataField="Caset1_NoteValue" HeaderText="Note (C1)" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Caset1_NoteValue" ItemStyle-Wrap="false" />
                            <asp:BoundField DataField="Caset2_NoteCount" HeaderText="Count (C2)" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Caset2_NoteCount" />
                            <asp:BoundField DataField="Caset2_NoteValue" HeaderText="Note (C2)" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Caset2_NoteValue" />
                            <asp:BoundField DataField="Caset3_NoteCount" HeaderText="Count (C3)" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Caset3_NoteCount" />
                            <asp:BoundField DataField="Caset3_NoteValue" HeaderText="Note (C3)" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Caset3_NoteValue" />
                            <asp:BoundField DataField="Caset4_NoteCount" HeaderText="Count (C4)" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Caset4_NoteCount" />
                            <asp:BoundField DataField="Caset4_NoteValue" HeaderText="Note (C4)" ItemStyle-HorizontalAlign="Right"
                                SortExpression="Caset4_NoteValue" />
                            <%--<asp:BoundField DataField="AtmName" HeaderText="AtmName" 
                        SortExpression="AtmName" />--%>
                        </Columns>
                        <EditRowStyle BackColor="#C5E2FD" />
                        <FooterStyle BackColor="#CCCC99" Font-Bold="true" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:Label runat="server" ID="lblBatchLink" Text=""></asp:Label>
                    <%--<td style="padding-left: 20px">
                <asp:Button ID="ProcessAtmValue" runat="server" Text="Save Data" Width="150px" Visible="false"
                    OnClick="ProcessData" />
            </td>--%>
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" InsertMethod="Insert"
                        SelectMethod="GetData" TypeName="DataSet_ATMTableAdapters.TempAtmValueTableAdapter"
                        OnSelected="ObjectDataSource1_Selected" OldValuesParameterFormatString="original_{0}"
                        DeleteMethod="Delete" UpdateMethod="Update">
                        <DeleteParameters>
                            <asp:Parameter Name="Original_ID" Type="Int64" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="AtmID" Type="String" />
                            <asp:Parameter Name="SessionID" Type="String" />
                            <asp:Parameter Name="InsertDT" Type="DateTime" />
                            <asp:Parameter Name="Caset1_NoteCount" Type="Int32" />
                            <asp:Parameter Name="Caset1_NoteValue" Type="Int32" />
                            <asp:Parameter Name="Caset2_NoteCount" Type="Int32" />
                            <asp:Parameter Name="Caset2_NoteValue" Type="Int32" />
                            <asp:Parameter Name="Caset3_NoteCount" Type="Int32" />
                            <asp:Parameter Name="Caset3_NoteValue" Type="Int32" />
                            <asp:Parameter Name="Caset4_NoteCount" Type="Int32" />
                            <asp:Parameter Name="Caset4_NoteValue" Type="Int32" />
                            <asp:Parameter Name="AtmName" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter Name="SessionID" ControlID="HidPageID" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="AtmID" Type="String" />
                            <asp:Parameter Name="SessionID" Type="String" />
                            <asp:Parameter Name="InsertDT" Type="DateTime" />
                            <asp:Parameter Name="Caset1_NoteCount" Type="Int32" />
                            <asp:Parameter Name="Caset1_NoteValue" Type="Int32" />
                            <asp:Parameter Name="Caset2_NoteCount" Type="Int32" />
                            <asp:Parameter Name="Caset2_NoteValue" Type="Int32" />
                            <asp:Parameter Name="Caset3_NoteCount" Type="Int32" />
                            <asp:Parameter Name="Caset3_NoteValue" Type="Int32" />
                            <asp:Parameter Name="Caset4_NoteCount" Type="Int32" />
                            <asp:Parameter Name="Caset4_NoteValue" Type="Int32" />
                            <asp:Parameter Name="AtmName" Type="String" />
                            <asp:Parameter Name="Original_ID" Type="Int64" />
                        </UpdateParameters>
                    </asp:ObjectDataSource>
                    <asp:Panel ID="Panel2" runat="server">
                        <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
                        <br />
                        <br />
                        <table>
                            <tr>
                                <td style="padding: 0 30px 0 20px">
                                    <img src="Images/rms.jpg" width="90px" height="90px" />
                                </td>
                                <td class="ui-corner-all Shadow Border" width="360px">
                                    <table>
                                        <tr>
                                            <td nowrap="nowrap" style="padding-right: 10px">
                                                <span style="font-size: small;"><b>Test Number:</b></span>
                                            </td>
                                            <td style="margin-left: 40px">
                                                <asp:TextBox runat="server" ID="txtTestNo" Text="" Width="130" MaxLength="20"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTestNo"
                                                    ErrorMessage="*" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:Button ID="cmdUpdate" runat="server" Font-Bold="true" Height="30px" OnClick="cmdUpdate_Click"
                                                    Text="Upload Data (Not Published)" ValidationGroup="Submit" Width="220px" />
                                                <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Are you sure?"
                                                    Enabled="True" TargetControlID="cmdUpdate">
                                                </asp:ConfirmButtonExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <br />
                    <br />
                    <asp:Label ID="Label3" runat="server" Text="" Font-Bold="true"></asp:Label><br />
                    <asp:Label ID="Label4" runat="server" Text="" Font-Size="Small"></asp:Label>
                    <asp:SqlDataSource ID="SqlDataSourceRemiList_Add" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:CardDataConnectionString.ProviderName %>"
                        SelectCommand="sp_RemiList_Add" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceRemiList_Add_Selected">
                        <SelectParameters>
                            <asp:ControlParameter Name="SessionID" ControlID="HidPageID" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="txtTestNo" Name="TestNumber" PropertyName="Text"
                                Type="String" />
                            <asp:Parameter Direction="InputOutput" Name="Batch" Type="Int32" DefaultValue="0" />
                            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                            <asp:Parameter Name="Currency" DefaultValue="" Type="String" />
                            <asp:SessionParameter SessionField="EMPID" Type="String" Name="EmpID" />
                            <asp:Parameter Name="ExHouse" Type="String" DefaultValue="" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div id="history">
                    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                        AutoGenerateColumns="False" BackColor="White" Width="800px" PagerSettings-Position="TopAndBottom"
                        PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                        BorderWidth="1px" CellPadding="4" PageSize="20" DataKeyNames="ID" DataSourceID="SqlDataSourceDataUploadLog"
                        ForeColor="Black" Style="font-size: small" EnableSortingAndPagingCallbacks="True"
                        OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                        <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                        <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                SortExpression="ID" />
                            <asp:TemplateField HeaderText="Uploaded On" SortExpression="DT" ItemStyle-Wrap="false"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <span title='<%# TrustControl1.ToDateTimeTitle( Eval("DT"))%>'>
                                        <%# TrustControl1.ToRecentDateTime(Eval("DT"))%></span></ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="About" SortExpression="DT" ItemStyle-Wrap="false"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div class='time-small'>
                                        <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo( Eval("DT")) %>'></time>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="By Emp" SortExpression="EmpID">
                                <ItemTemplate>
                                    <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" DataFormatString="{0:N0}" />
                            <%--<asp:BoundField DataField="SelectedAfter" HeaderText="Selected After" SortExpression="SelectedAfter"
                                DataFormatString="{0:dd MMM yyyy}" />--%>
                            <asp:TemplateField HeaderText="View Data" SortExpression="batchId">
                                <ItemTemplate>
                                    <a href='ATM_Cashload_Batch.aspx?batchid=<%# Eval("ID") %>' target="_blank" class="Link">
                                        <span style="color: blue">View</span></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Download">
                                <ItemTemplate>                            
                                    <a href='SettlementFileDownload.aspx?batchid=<%# Eval("ID") %>&type=Dr&EMPID=<%# Eval("EMPID") %>' target="_blank">Dr</a>
                                    |
                                    <a href='SettlementFileDownload.aspx?batchid=<%# Eval("ID") %>&type=Cr&EMPID=<%# Eval("EMPID") %>' target="_blank">Cr</a>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceDataUploadLog" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="SELECT * FROM [AtmUploadLog] order by ID desc"></asp:SqlDataSource>
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
