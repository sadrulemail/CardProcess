<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NPSB_Upload.aspx.cs" Inherits="NPSB_Upload" %>

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

        function AsyncFileUpload1_StartUpload(sender, args) {
            var filename = args.get_fileName();
            var ext = filename.substring(filename.lastIndexOf(".") + 1);
            if (ext.toLowerCase() == 'zip' || ext.toLowerCase() == 'xml') {
                $('#ctl00_cphMain_lblUploadStatus').html("<b>" + args.get_fileName() + "</b> is uploading...");
            }
            else {
                $('#UploadBtn').hide('Slow');
                $('#ctl00_cphMain_lblUploadStatus').html("Only <b>xml & zip</b> files can be uploaded.");
                throw {
                    name: "Invalid File Type",
                    level: "Error",
                    message: "Only ZIP & CSV files can be uploaded. ",
                    htmlMessage: "Only <b>xml & zip</b> files can be uploaded. "
                }
                return false;
            }
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
    NPSB File Upload
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="HidPageID" runat="server" Value="" />
            <asp:HiddenField ID="HidUploadTempFolder" runat="server" Value="" />
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
                            <b>Select xml or zip file:</b>
                            <asp:AsyncFileUpload ID="FileUpload1" runat="server" Width="300px" Style="margin: 10px"
                                OnUploadedComplete="FileUpload1_UploadedComplete" ThrobberID="myThrobber" OnClientUploadComplete="UploadComplete"
                                OnClientUploadError="UploadError" OnClientUploadStarted="AsyncFileUpload1_StartUpload"
                                OnUploadedFileError="FileUpload1_UploadedFileError" UploaderStyle="Traditional"
                                CssClass="AsyncFileUploadField" />
                            <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" />
                            <br />
                            <asp:Label ID="lblUploadStatus" runat="server" Style="font-size: small;" Text="">
                                            
                            </asp:Label></div>
                        <%-- <div style="display: none; padding-top: 10px" id="UploadBtn">
                            <asp:Button ID="cmdCheck" runat="server" Text="View Data" Width="150px" Font-Bold="true"
                                Height="30px" OnClick="cmdCheck_Click" />
                        </div>--%>
                        <table style="display: none;" id="UploadBtn">
                            <tr>
                                <td style="padding: 10px 0 0 0">
                                    <div class="ui-corner-all Panel1">
                                        <span style="font-size: larger; font-weight: bold"></span>
                                        <table class="SmallFont">
                                            <tr>
                                                <td>
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
                        <asp:Button ID="cmdSaveData" runat="server" Text="Save Data" Width="150px" Visible="False"
                            OnClick="cmdSaveData_SaveData" />
                        <asp:ConfirmButtonExtender runat="server" ID="confirmsave" TargetControlID="cmdSaveData"
                            ConfirmText="Do you want to Save?">
                        </asp:ConfirmButtonExtender>
                    </div>
                    <asp:GridView ID="NPSBListGrid" runat="server" AllowPaging="True" CssClass="Grid"
                        AllowSorting="True" AutoGenerateColumns="False" BackColor="White" Width="800px"
                        PagerSettings-Position="TopAndBottom" PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE"
                        BorderStyle="Solid" BorderWidth="1px" CellPadding="4" PageSize="20" PagerSettings-PageButtonCount="30"
                        DataKeyNames="NPSB_ID" DataSourceID="NPSB_DataSql" ForeColor="Black" Style="font-size: small"
                        EnableSortingAndPagingCallbacks="True">
                        <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                        <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundField DataField="NPSB_ID" HeaderText="NPSB ID" SortExpression="NPSB_ID"
                                InsertVisible="False" ReadOnly="True" />
                            <%--<asp:BoundField DataField="FileName" HeaderText="File Name" SortExpression="FileName" />
                            <asp:BoundField DataField="FinCategory" HeaderText="Fin Category" SortExpression="FinCategory" />--%>
                            <asp:BoundField DataField="RequestCategory" HeaderText="Request Category" SortExpression="RequestCategory" />
                            <asp:BoundField DataField="ServiceClass" HeaderText="Service Class" SortExpression="ServiceClass" />
                            <asp:BoundField DataField="TransTypeCode" HeaderText="Trans Code" SortExpression="TransTypeCode" />
                            <asp:BoundField DataField="MsgCode" HeaderText="Msg Code" SortExpression="MsgCode" />
                            <%--<asp:BoundField DataField="TransCondition" HeaderText="TransCondition" 
                            SortExpression="TransCondition" />--%>
                            <asp:BoundField DataField="Parm_DRN" HeaderText="DRN" SortExpression="Parm_DRN" />
                            <asp:BoundField DataField="Parm_SRN" HeaderText="SRN" SortExpression="Parm_SRN" />
                            <asp:BoundField DataField="Parm_RRN" HeaderText="RRN" SortExpression="Parm_RRN" />
                            <asp:BoundField DataField="Parm_AuthCode" HeaderText="AuthCode" SortExpression="Parm_AuthCode" />
                            <asp:BoundField DataField="Parm_PrevDRN" HeaderText="PrevDRN" SortExpression="Parm_PrevDRN" />
                            <asp:BoundField DataField="Parm_OrigDRN" HeaderText="OrigDRN" SortExpression="Parm_OrigDRN" />
                            <%--<asp:BoundField DataField="LocalDt" HeaderText="LocalDt" 
                            SortExpression="LocalDt" />
                        <asp:BoundField DataField="NWDt" HeaderText="NWDt" SortExpression="NWDt" />
                        <asp:BoundField DataField="SIC" HeaderText="SIC" SortExpression="SIC" />
                        <asp:BoundField DataField="Country" HeaderText="Country" 
                            SortExpression="Country" />
                        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                        <asp:BoundField DataField="MerchantName" HeaderText="MerchantName" 
                            SortExpression="MerchantName" />
                        <asp:BoundField DataField="MerchantID" HeaderText="MerchantID" 
                            SortExpression="MerchantID" />--%>
                            <asp:BoundField DataField="ContractNumber" HeaderText="Contract Number" SortExpression="ContractNumber" />
                            <%-- <asp:BoundField DataField="MemberId" HeaderText="MemberId" 
                            SortExpression="MemberId" />--%>
                            <%--<asp:BoundField DataField="Channel" HeaderText="Channel" 
                            SortExpression="Channel" />--%>
                            <asp:BoundField DataField="D_ContractNumber" HeaderText="D_Contract Number" SortExpression="D_ContractNumber"
                                ItemStyle-HorizontalAlign="Right" />
                            <%-- <asp:BoundField DataField="D_Relation" HeaderText="D_Relation" 
                            SortExpression="D_Relation" />--%>
                            <asp:BoundField DataField="D_MemberId" HeaderText="D_Member Id" SortExpression="D_MemberId"
                                ItemStyle-HorizontalAlign="Right" />
                            <%--<asp:BoundField DataField="CardExpiry" HeaderText="Card Expiry" 
                            SortExpression="CardExpiry" />--%>
                            <%--<asp:BoundField DataField="D_Channel" HeaderText="D_Channel" 
                            SortExpression="D_Channel" />--%>
                            <asp:BoundField DataField="Trans_Currency" HeaderText="Trans Currency" SortExpression="Trans_Currency"
                                ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="Trans_Amount" HeaderText="Trans Amount" SortExpression="Trans_Amount"
                                ItemStyle-HorizontalAlign="Right" />
                            <%--<asp:BoundField DataField="Parm_AUTH_MODE" HeaderText="Parm_AUTH_MODE" 
                            SortExpression="Parm_AUTH_MODE" />--%>
                            <%--<asp:BoundField DataField="Parm_FX_RATE" HeaderText="Parm_FX_RATE" 
                            SortExpression="Parm_FX_RATE" />
                        <asp:BoundField DataField="Parm_CARD_ABSENT" HeaderText="Parm_CARD_ABSENT" 
                            SortExpression="Parm_CARD_ABSENT" />
                        <asp:BoundField DataField="Parm_BCURR" HeaderText="Parm_BCURR" 
                            SortExpression="Parm_BCURR" />
                        <asp:BoundField DataField="Parm_SG" HeaderText="Parm_SG" 
                            SortExpression="Parm_SG" />
                        <asp:BoundField DataField="Parm_NEXT_AMOUNT" HeaderText="Parm_NEXT_AMOUNT" 
                            SortExpression="Parm_NEXT_AMOUNT" />
                        <asp:BoundField DataField="Parm_BRAND" HeaderText="Parm_BRAND" 
                            SortExpression="Parm_BRAND" />
                        <asp:BoundField DataField="Parm_FIN_CURR" HeaderText="Parm_FIN_CURR" 
                            SortExpression="Parm_FIN_CURR" />
                        <asp:BoundField DataField="Parm_SRC" HeaderText="Parm_SRC" 
                            SortExpression="Parm_SRC" />
                        <asp:BoundField DataField="Parm_NEXT_CURR" HeaderText="Parm_NEXT_CURR" 
                            SortExpression="Parm_NEXT_CURR" />
                        <asp:BoundField DataField="Parm_NEXT_CH" HeaderText="Parm_NEXT_CH" 
                            SortExpression="Parm_NEXT_CH" />
                        <asp:BoundField DataField="Parm_PROC_CLASS" HeaderText="Parm_PROC_CLASS" 
                            SortExpression="Parm_PROC_CLASS" />
                        <asp:BoundField DataField="Parm_RCAT" HeaderText="Parm_RCAT" 
                            SortExpression="Parm_RCAT" />
                        <asp:BoundField DataField="Bill_Currency" HeaderText="Bill_Currency" 
                            SortExpression="Bill_Currency" />
                        <asp:BoundField DataField="Bill_Amount" HeaderText="Bill_Amount" 
                            SortExpression="Bill_Amount" />
                        <asp:BoundField DataField="Recon_Currency" HeaderText="Recon_Currency" 
                            SortExpression="Recon_Currency" />
                        <asp:BoundField DataField="Recon_Amount" HeaderText="Recon_Amount" 
                            SortExpression="Recon_Amount" />
                        <asp:BoundField DataField="PhaseDate" HeaderText="PhaseDate" 
                            SortExpression="PhaseDate" />
                        <asp:BoundField DataField="FormatVersion" HeaderText="FormatVersion" 
                            SortExpression="FormatVersion" />
                        <asp:BoundField DataField="Sender" HeaderText="Sender" 
                            SortExpression="Sender" />--%>
                            <%--<asp:BoundField DataField="CreationDate" HeaderText="CreationDate" 
                            SortExpression="CreationDate" />--%>
                            <%--<asp:BoundField DataField="CreationTime" HeaderText="CreationTime" 
                            SortExpression="CreationTime" />
                        <asp:BoundField DataField="FileSeqNumber" HeaderText="FileSeqNumber" 
                            SortExpression="FileSeqNumber" />
                        <asp:BoundField DataField="Receiver" HeaderText="Receiver" 
                            SortExpression="Receiver" />
                        <asp:BoundField DataField="SessionID" HeaderText="SessionID" 
                            SortExpression="SessionID" />--%>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    </asp:Panel>
                    <asp:SqlDataSource ID="NPSB_DataSql" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="SELECT * FROM TempNPSB_Upload_Data WHERE (SessionID = @SessionID)"
                        SelectCommandType="Text">
                        <SelectParameters>
                            <asp:ControlParameter Name="SessionID" ControlID="HidPageID" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div id="history">
                    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                        AutoGenerateColumns="False" BackColor="White" Width="800px" PagerSettings-Position="TopAndBottom"
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
                            <asp:TemplateField HeaderText="View Data" SortExpression="batchId">
                                <ItemTemplate>
                                    <a href='NPSBView.aspx?batchid=<%# Eval("ID") %>' target="_blank" class="Link"><span
                                        style="color: blue">View</span></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" DataFormatString="{0:N0}" />--%>
                            <%--<asp:BoundField DataField="SelectedAfter" HeaderText="Selected After" SortExpression="SelectedAfter"
                                DataFormatString="{0:dd MMM yyyy}" />--%>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceDataUploadLog" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="SELECT top 100 * FROM [NPSB_Upload_Log] order by ID desc"></asp:SqlDataSource>
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
