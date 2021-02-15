﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Forwarding2.aspx.cs" Inherits="Forwarding2" EnableEventValidation="false" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function UploadError() {
            document.getElementById('lblUploadStatus').innerHTML = "File Uploading Error. Please try again.";
        }

        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var contentType = args.get_contentType();
            var text = "Size of " + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += " and content type is '" + contentType + "'.";
            }
            document.getElementById('UploadBtn').style.visibility = "visible";
            document.getElementById('lblUploadStatus').innerHTML = filename + " is successfully uploaded.<br>";

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        Forwarding Letters &amp; Card Mailers
    </p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField runat="server" ID="HidPageID" />
            <asp:HiddenField runat="server" ID="HidUploadTempFile" />
            <asp:HiddenField runat="server" ID="hidCardType" />
            <div id="tabs">
                <ul>
                    <li style="display: inline"><a href='#upload'>Upload</a></li>
                    <li style="display: inline">
                        <a href='#history'>History</a></li>
                </ul>
                <div id="upload">
                    <asp:Panel ID="Panel1" runat="server">
                        <div class="SmallFont" style="padding: 7px; width: 300px; background-color: #FFFFB5; border: solid 1px green; margin: 0px 0px 10px 0px">
                            To create the Forwarding Letters and Card Mailers, please upload the report file
                            of ITCL named ''PRIVATE CUSTOMER LIST WITH CARDS'' (*.txt):
                        </div>
                        <asp:AsyncFileUpload ID="FileUpload1" runat="server" Width="300px" OnUploadedComplete="FileUpload1_UploadedComplete"
                            ThrobberID="myThrobber" OnClientUploadComplete="UploadComplete" OnClientUploadError="UploadError"
                            OnUploadedFileError="FileUpload1_UploadedFileError" UploaderStyle="Traditional"
                            CssClass="AsyncFileUploadField" />
                        <br />
                        <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" />
                        <br />
                        <asp:Label ID="lblUploadStatus" ClientIDMode="Static" runat="server" Style="font-size: small; font-weight: 700"
                            Text="">
                
                        </asp:Label><br />
                        <span style="visibility: hidden" id="UploadBtn">
                            <asp:Button ID="cmdCheck" runat="server" Text="View Debit Cards" Width="200px" Font-Bold="true"
                                Height="30px" OnClick="cmdCheck_Click" />
                            <asp:Button ID="cmdCheckCreditCard" runat="server" Text="View Credit Cards" Width="200px"
                                Font-Bold="true" Height="30px" OnClick="cmdCheckCreditCard_Click" />
                        </span>
                        <br />
                    </asp:Panel>
                    <asp:Panel ID="Panel2" runat="server">
                        <asp:Button ID="cmdUpdate" runat="server" Text="Save and Generate Forwarding Letters" Width="250px" Font-Bold="true"
                            Height="40px" OnClick="cmdUpdate_Click" />
                        <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Are you sure?"
                            Enabled="True" TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                        <br />
                        <br />
                        <asp:Label Font-Bold="true" ID="lblStatus" runat="server" Text=""></asp:Label>
                        <br />
                        <br />
                    </asp:Panel>
                    <%--<asp:Panel ID="PanelDeliveryBranchCodeMissing" runat="server" Visible="false">
                        <div class="BackShade" style="padding: 3px; font-size: medium">
                            <strong>Delivery Branch Code Missing:</strong></div>
                        <asp:GridView ID="GridViewDeliveryBranchCodeMissing" runat="server" AutoGenerateColumns="False"
                            CssClass="Grid" PagerSettings-Mode="NumericFirstLast" PageSize="50" PagerSettings-PageButtonCount="30"
                            PagerSettings-Position="TopAndBottom" Width="100%" CellPadding="4" DataSourceID="SqlDataSource1"
                            Style="font-size: small" AllowPaging="True" ForeColor="#333333" GridLines="None" Visible="false">
                            <PagerSettings PageButtonCount="30" Position="TopAndBottom" />
                            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" VerticalAlign="Top" />
                            <Columns>
                                <asp:BoundField DataField="CardNo" HeaderText="CardNo" SortExpression="CardNo" />
                                <asp:BoundField DataField="CustomerName" HeaderText="CustomerName" SortExpression="CustomerName" />
                                <asp:BoundField DataField="AccountNo" HeaderText="AccountNo" SortExpression="AccountNo"
                                    ItemStyle-Wrap="false">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CustomerAddress" HeaderText="CustomerAddress" SortExpression="CustomerAddress" />
                                <asp:BoundField DataField="DeleveryBranch" HeaderText="DeleveryBranch" ItemStyle-HorizontalAlign="Center"
                                    SortExpression="DeleveryBranch">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DeliveryOverwrite" HeaderText="DeliveryOverwrite" ItemStyle-HorizontalAlign="Center"
                                    SortExpression="DeliveryOverwrite" NullDisplayText="">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CardStatus" HeaderText="Status" ItemStyle-HorizontalAlign="Center"
                                    SortExpression="CardStatus">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ITCLID" HeaderText="ITCLID" ItemStyle-HorizontalAlign="Center"
                                    SortExpression="ITCLID">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CreateDT" HeaderText="CreateDT" ItemStyle-HorizontalAlign="Center"
                                    SortExpression="CreateDT" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-Wrap="false">
                                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="#990000" ForeColor="White" Font-Bold="True" />
                            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Left" CssClass="PagerStyle" />
                            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="SELECT * FROM dbo.TempForwarding where EmpID = @EmpID
and DeleveryBranch is null and DeliveryOverwrite is null" OnSelected="SqlDataSource1_Selected">
                            <SelectParameters>
                                <asp:SessionParameter Name="EmpID" SessionField="EMPID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <br />
                    </asp:Panel>--%>
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                        BackColor="White" BorderColor="#E7E7FF" BorderStyle="Solid" BorderWidth="1px"
                        CellPadding="4" CssClass="Grid" DataSourceID="SqlDataSource2" PagerSettings-Mode="NumericFirstLast"
                        PagerSettings-PageButtonCount="30" PagerSettings-Position="TopAndBottom" PageSize="50"
                        Style="font-size: small" AllowSorting="true">
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" VerticalAlign="Top" />
                        <Columns>
                            <asp:BoundField DataField="ITCLID" HeaderText="ITCLID" ItemStyle-HorizontalAlign="Center"
                                SortExpression="ITCLID">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CardNo" HeaderText="Card No" SortExpression="CardNo" />

                            <asp:BoundField DataField="AccountNo" HeaderText="Account No" ItemStyle-Wrap="false"
                                SortExpression="AccountNo">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>

                            <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" SortExpression="CustomerName" />
                            <asp:BoundField DataField="NameOnCard" HeaderText="Name on Card" SortExpression="NameOnCard" />
                            <asp:BoundField DataField="CustomerAddress" HeaderText="Customer Address" SortExpression="CustomerAddress" />
                            <asp:BoundField DataField="DeleveryBranch" HeaderText="DeleveryBranch" ItemStyle-HorizontalAlign="Center"
                                SortExpression="DeleveryBranch" Visible="false">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DeliveryOverwrite" HeaderText="Delivery Overwrite" ItemStyle-HorizontalAlign="Center"
                                NullDisplayText="" SortExpression="DeliveryOverwrite" Visible="false">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CardStatus" HeaderText="Status" ItemStyle-HorizontalAlign="Center"
                                SortExpression="CardStatus">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>

                            <asp:BoundField DataField="CreateDT" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="CreateDT"
                                ItemStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" SortExpression="CreateDT">
                                <ItemStyle HorizontalAlign="Center" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="EmpID" HeaderText="EmpID" ItemStyle-HorizontalAlign="Center"
                                SortExpression="EmpID" Visible="false">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <PagerStyle BackColor="#E7E7FF" CssClass="PagerStyle" ForeColor="#4A3C8C" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                        ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="SELECT * FROM dbo.TempForwarding WHERE SessionID=@SessionID"
                        OnSelected="SqlDataSource2_Selected">

                        <SelectParameters>
                            <asp:ControlParameter Name="SessionID" ControlID="HidPageID" Type="String" PropertyName="Value" />
                        </SelectParameters>
                        <%--<InsertParameters>
                            <asp:Parameter Name="AccountNo" Type="String" />
                            <asp:Parameter Name="CardNo" Type="String" />
                            <asp:Parameter Name="CustomerName" Type="String" />
                            <asp:Parameter Name="DeleveryBranch" Type="Int32" ConvertEmptyStringToNull="true" />
                            <asp:Parameter Name="CardStatus" Type="String" />
                            <asp:Parameter Name="EmpID" Type="String" />
                            <asp:Parameter Name="ITCLID" Type="Int32" />
                            <asp:Parameter Name="CreateDT" Type="DateTime" />
                            <asp:Parameter Name="DeliveryRef" Type="String" />
                            <asp:Parameter Name="DeliveryOverwrite" Type="Int32" ConvertEmptyStringToNull="true" />
                            <asp:Parameter Name="CustomerAddress" Type="String" />
                            <asp:Parameter Name="SessionID" Type="String" />
                            <asp:Parameter Name="NameOnCard" Type="String" />
                        </InsertParameters>--%>
                    </asp:SqlDataSource>
                </div>
                <div id="history">
                    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid" EnableSortingAndPagingCallbacks="True"
                        PageSize="20" PagerSettings-Mode="NumericFirstLast" PagerSettings-Position="TopAndBottom"
                        AllowSorting="True" AutoGenerateColumns="False" BackColor="White" PagerSettings-PageButtonCount="30"
                        BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="ID"
                        DataSourceID="SqlDataSourceForwardingLog" Style="font-size: small">
                        <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                        <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" VerticalAlign="Top" />
                        <Columns>
                            <asp:TemplateField HeaderText="View" InsertVisible="False" SortExpression="">
                                <ItemTemplate>

                                    <a href='ForwardingView.aspx?batch=<%# Eval("ID", "{0}") %>' title="View"
                                        target="_blank" class="Link">View</a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Download" InsertVisible="False" SortExpression="">
                                <ItemTemplate>
                                    <a href='Forwarding.aspx?batch=<%# Eval("ID", "{0}") %>&cardtype=<%# Eval("CardType") %>' title="Forwarding"
                                        target="_blank" class="Link">Forwarding</a>
                                    <br />
                                    <a href='Card_Mailer.aspx?batch=<%# Eval("ID", "{0}") %>&cardtype=<%# Eval("CardType") %>' title="Card Mailer"
                                        target="_blank" class="Link">Card Mailer</a>
                                    <br />
                                    <a href='Forwarding_Details.aspx?id=<%# Eval("ID", "{0}") %>&cardtype=<%# Eval("CardType") %>' title="Forwarding Summary"
                                        target="_blank" class="Link">Summary</a>
                                    <br />
                                    <a href='Different_Forwarding_Branch_Cards.aspx?batch=<%# Eval("ID", "{0}") %>&cardtype=<%# Eval("CardType") %>' title="Different Branch"
                                        target="_blank" class="Link">Different Branch</a>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Forwarded On" SortExpression="DT" ItemStyle-Wrap="false"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div title='<%# Eval("DT", "{0:dddd, \nd MMMM, yyyy \nh:mm:ss tt}")%>'>
                                        <%# TrustControl1.ToRecentDateTime(Eval("DT"))%>
                                    </div>
                                    <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="By Emp" SortExpression="EmpID">
                                <ItemTemplate>
                                    <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Reference" HeaderText="Reference" SortExpression="Reference"
                                ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" DataFormatString="{0:N0}" />
                            <asp:BoundField DataField="CardType" HeaderText="CardType" SortExpression="CardType" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton runat="server"
                                        ID="lnkDelete"
                                        CommandArgument='<%# Eval("ID") %>' Visible='<%# (DateTime.Parse(Eval("DT").ToString()).Date==DateTime.Now.Date ? true : false) %>'
                                        CommandName="Delete"><img src="Images/cross.png" /></asp:LinkButton>
                                    <asp:ConfirmButtonExtender runat="server" ID="con1"
                                        TargetControlID="lnkDelete" ConfirmText="Do you want to Delete?" />

                                </ItemTemplate>

                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceForwardingLog" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="SELECT * FROM [v_ForwardingLog] ORDER BY [ID] DESC"
                        DeleteCommand="s_Forwarding_Delete"
                        DeleteCommandType="StoredProcedure" OnDeleted="SqlDataSourceForwardingLog_Deleted">
                        <DeleteParameters>
                            <asp:SessionParameter Name="EmpID" SessionField="EMPID" />
                            <asp:Parameter Name="ID" />
                            <asp:Parameter Name="Msg" Type="String" Size="255" Direction="InputOutput" DefaultValue="*" />
                        </DeleteParameters>
                    </asp:SqlDataSource>
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
