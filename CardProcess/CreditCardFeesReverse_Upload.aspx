<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReconciliationFile_Upload.aspx.cs" Inherits="ReconciliationFile_Upload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CreditCardFeesReverse_Upload.aspx.cs" Inherits="CreditCardFeesReverse_Upload" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        function UploadError() {
            $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html('File Uploading Error. Please try again.');
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
    <style type="text/css">
        .Border1 {
            background-color: #FFFFB5;
            padding: 10px;
            border: solid 1px green;
            width: 200px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Credit Card Fees Reverse Upload
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField runat="server" ID="HidPageID" />
            <asp:HiddenField runat="server" ID="HidUploadTempFile" />
            <asp:TabContainer runat="server" ID="tabContainer" CssClass="NewsTab" OnDemand="true"
                ActiveTabIndex="0" Width="90%" OnActiveTabChanged="tabContainer_ActiveTabChanged">
                <asp:TabPanel runat="server" ID="tab1">
                    <HeaderTemplate>
                        Upload Data
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:Button ID="cmdClearData" runat="server" Text="Clear Data" OnClick="cmdClearData_Click"
                            Visible="False" />
                        <asp:Panel ID="Panel1" runat="server">
                            <div class="Panel1 ui-corner-all" style="padding: 0 0 10px 0px; width: 700px">
                                <table>
                                    <tr>
                                        <td valign="top" style="padding: 10px">
                                            <img src="Images/card.gif" width="100px" height="66px" />
                                        </td>
                                        <td>
                                            <div style="font-size: small; font-weight: bolder; padding: 10px 0px 3px 0px;">
                                                Select Currency:
                                                <asp:DropDownList ID="ddlFileType" runat="server">
                                                    <asp:ListItem Text="BDT" Value="BDT"></asp:ListItem>
                                                    <asp:ListItem Text="USD" Value="USD"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorddlFileType" runat="server"
                                                    ControlToValidate="ddlFileType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                                <asp:TextBox runat="server" ID="txtRemarks" placeholder="Remarks"></asp:TextBox>
                                            </div>
                                            <div style="font-size: small; font-weight: bolder; padding: 10px 0px 3px 0px;">
                                                Please select Credit card Reverse File:
                                            </div>
                                            <asp:AsyncFileUpload ID="FileUpload1" runat="server" OnUploadedComplete="FileUpload1_UploadedComplete"
                                                ThrobberID="myThrobber" OnClientUploadComplete="UploadComplete" OnClientUploadError="UploadError"
                                                CssClass="AsyncFileUploadField" OnUploadedFileError="FileUpload1_UploadedFileError"
                                                FailedValidation="False" />
                                            <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" />
                                            <div style="padding: 5px 0px 10px 0px">
                                                <asp:Label ID="lblUploadStatus" runat="server"></asp:Label>
                                            </div>
                                            <div style="display: none;" id="UploadBtn">
                                                <asp:Button ID="cmdCheck" runat="server" Text="View Data" Width="150px" Font-Bold="True"
                                                    Height="30px" OnClick="cmdCheck_Click" CssClass="ui-corner-all" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlFileType"
                                                    ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>

                        <div style="padding-left: 20px; text-align: right;" align="center">
                            <asp:Button ID="btn_save" runat="server" Text="Save Data" Width="120px"
                                Visible="False" OnClick="DataSave" />
                            <asp:ConfirmButtonExtender runat="server" ID="confirmsave" TargetControlID="btn_save"
                                ConfirmText="Do you want to Save?" Enabled="True"></asp:ConfirmButtonExtender>
                        </div>

                        <asp:GridView ID="GridView1" runat="server" BackColor="White" AllowPaging="True"
                            CssClass="Grid" AllowSorting="True" BorderColor="#DEDFDE" BorderStyle="None"
                            BorderWidth="1px" CellPadding="4" ForeColor="Black" AutoGenerateColumns="False"
                            Style="font-size: small; font-family: Arial" PageSize="15" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                            OnSelectedIndexChanging="GridView1_SelectedIndexChanging" DataSourceID="SqlDataSource1">
                            <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" PageButtonCount="30" />
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Center" />
                            <Columns>
                                <asp:BoundField DataField="Curr_CODE" HeaderText="Currency Code" SortExpression="Curr_CODE">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="posting_date" HeaderText="Posting Date" SortExpression="posting_date"
                                    DataFormatString="{0:dd/MM/yyyy}">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="card_no" HeaderText="Card Number" SortExpression="card_no">
                                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CARD_HOLDER_NAME" HeaderText="CARD HOLDER NAME"
                                    SortExpression="CARD_HOLDER_NAME">
                                    <ItemStyle Wrap="False" HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="CARD_STATUS" HeaderText="CARD STATUS" SortExpression="CARD_STATUS">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CARD_FEE_AMT" HeaderText="CARD FEE AMT" SortExpression="CARD_FEE_AMT"
                                    DataFormatString="{0:N2}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>

                            </Columns>
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <PagerStyle HorizontalAlign="Left" CssClass="PagerStyle" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="SELECT * FROM TempCreditCardFeesReverseUpload WHERE ([session_id] = @session_id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="HidPageID" Name="session_id" PropertyName="Value"
                                    Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Button runat="server" ID="cmdUploadAgain" Text="Upload Another" Width="130px"
                            Height="30px" Font-Bold="True" Visible="False" OnClick="cmdUploadAgain_Click" />

                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tab2">
                    <HeaderTemplate>
                        Upload History
                    </HeaderTemplate>
                    <ContentTemplate>
                        <%--<asp:Panel ID="Panel3" runat="server" Visible="true">
                            <asp:Panel ID="Panel4" runat="server">
                                <table class="Panel1 ui-corner-all">
                                    <tr>
                                        <td>
                                            <b>Date Range:</b>
                                            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" CausesValidation="True"
                                                OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                                <asp:ListItem>Today</asp:ListItem>
                                                <asp:ListItem>Yesterday</asp:ListItem>
                                                <asp:ListItem>This Week</asp:ListItem>
                                                <asp:ListItem>Last Week</asp:ListItem>
                                                <asp:ListItem>This Month</asp:ListItem>
                                                <asp:ListItem>Last Month</asp:ListItem>
                                                <asp:ListItem>This Year</asp:ListItem>
                                                <asp:ListItem>Show All</asp:ListItem>
                                                <asp:ListItem>Custom Range</asp:ListItem>
                                            </asp:DropDownList>
                                            <b>From:</b>
                                            <asp:TextBox ID="TextBox1" CssClass="Date" runat="server" Width="100px"></asp:TextBox>
                                            <b>To:
                                            </b>
                                            <asp:TextBox ID="TextBox2" CssClass="Date" runat="server" Width="100px"></asp:TextBox>
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" Width="80px" CausesValidation="false"
                                                OnClick="btnSearch_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </asp:Panel>--%>
                        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                            AutoGenerateColumns="False" BackColor="White" PagerSettings-Position="TopAndBottom"
                            PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                            BorderWidth="1px" CellPadding="4" PageSize="20" DataKeyNames="Batch" ForeColor="Black"
                            Visible="true" DataSourceID="SqlDataSourceDataUploadLog" Style="font-size: small"
                            EnableSortingAndPagingCallbacks="True" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                            <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                            <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                            <Columns>
                                <asp:BoundField HeaderText="Batch" DataField="Batch" SortExpression="Batch" />

                                <asp:BoundField DataField="insert_dt" HeaderText="Upload On" SortExpression="insert_dt"
                                    DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:TemplateField HeaderText="About" SortExpression="DT" ItemStyle-Wrap="false"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <div class='time-small'>
                                            <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo( Eval("insert_dt")) %>'></time>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="By Emp" SortExpression="insert_by">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("insert_by") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Currency" DataField="Curr_CODE" SortExpression="Curr_CODE" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteBtn" Visible='<%# Eval("DeleteMark").ToString() == "1" ? true : false %>'
                                            runat="server" CommandName="Delete" ToolTip="Delete"><img src="Images/cross.png" />
                                        </asp:LinkButton>
                                        <asp:ConfirmButtonExtender runat="server" ID="DeleteID" ConfirmText="Do you want to Delete?"
                                            TargetControlID="DeleteBtn"></asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Download" SortExpression="Batch">
                                    <ItemTemplate>
                                        <a href='<%# Eval("xlsxDownload") %>' target="_blank" class="Link">XLSX </a>|<a href='<%# Eval("dbfDownload") %>' target="_blank" class="Link">
                                                DBF</a>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceDataUploadLog" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_CreditCardFeesReverseUploadLog" SelectCommandType="StoredProcedure"
                            DeleteCommand="s_CreditCardFeesReverseUploadLog_Delete" DeleteCommandType="StoredProcedure" OnDeleted="SqlDataSourceDataUploadLog_Deleted">
                            <%--<SelectParameters>
                                <asp:ControlParameter ControlID="TextBox1" Name="DateFrom" PropertyName="Text" DefaultValue="01/01/1900"
                                    Type="DateTime" />
                                <asp:ControlParameter ControlID="TextBox2" Name="DateTo" PropertyName="Text" Type="DateTime" DefaultValue="01/01/1900" />
                            </SelectParameters>--%>
                            <DeleteParameters>
                                <asp:Parameter Name="Batch" Type="Int32" />
                                <asp:Parameter Direction="InputOutput" Name="Msg" Type="String" Size="255" DefaultValue=" " />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>


            </asp:TabContainer>
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
