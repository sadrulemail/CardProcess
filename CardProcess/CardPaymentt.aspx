<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CardPaymentt.aspx.cs" Inherits="CardPaymentt" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/StyleSheet.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Card Payment Process
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:TabContainer runat="server" ID="tabContainer" CssClass="NewsTab" OnDemand="true"
                ActiveTabIndex="0" OnActiveTabChanged="tabContainer_ActiveTabChanged">
                <asp:TabPanel runat="server" ID="tab1">
                    <HeaderTemplate>
                        Payment Process</HeaderTemplate>
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td>
                                    <table class="Panel1">
                                        <tr>
                                            <td class="style2 right">
                                                Trn Date:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="Date" Width="80px"></asp:TextBox>
                                            </td>
                                            <td class="style2 right">
                                                to
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="Date" Width="80px"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 10px">
                                                <asp:Button ID="btnPayment" runat="server" Text="Payment Data Process" OnClick="btnPayment_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                            AllowPaging="True" CssClass="Grid" BorderColor="#DEDFDE" BorderStyle="Solid"
                            BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black"
                            AllowSorting="True" Font-Size="Small" DataKeyNames="TransactionID" OnRowUpdated="GridView1_RowUpdated">
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <Columns>
                                <asp:BoundField DataField="TransactionID" HeaderText="Transaction ID" SortExpression="TransactionID"
                                    ReadOnly="True">
                                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Card No" SortExpression="CardNo">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEditRow" runat="server" ToolTip="Edit" CommandName="Edit"><%# Eval("[CardNo]") %></asp:LinkButton>
                                        <div>
                                            <a href='Search.aspx?q=<%# Eval("CardNo") %>' target="_blank" title="View">
                                                <img src="Images/open.png" /></a></div>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCardNo" runat="server" Text='<%# Bind("CardNo") %>' Width="130px"
                                            CssClass="center txt-card-number" MaxLength="20" Font-Bold="true"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ID="reqCard" ControlToValidate="txtCardNo"
                                            ErrorMessage="*" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:FilteredTextBoxExtender runat="server" ID="filCard" TargetControlID="txtCardNo"
                                            ValidChars="0123456789*">
                                        </asp:FilteredTextBoxExtender>
                                        <div style="white-space: nowrap">
                                            <asp:Button ID="lnkUpdate" runat="server" CommandName="Update" Text="Update"></asp:Button>
                                            <asp:ConfirmButtonExtender runat="server" ID="conUpdate" ConfirmText="Do you want to Update?"
                                                TargetControlID="lnkUpdate">
                                            </asp:ConfirmButtonExtender>
                                            <asp:Button ID="lnlCancel" CommandName="Cancel" runat="server" Text="Cancel"></asp:Button>
                                            <a style="cursor: pointer" id="view-card-details" target="_blank" title="View">
                                                <img src="Images/open.png" /></a></div>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Currency Code" SortExpression="CurrencyCode">
                                    <ItemTemplate>
                                        <%# Eval("CurrencyCode")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList Font-Bold="true" ID="dboCurrencyCode" runat="server" SelectedValue='<%# Bind("CurrencyCode") %>'>
                                            <asp:ListItem Value="BDT" Text="BDT"></asp:ListItem>
                                            <asp:ListItem Value="USD" Text="USD"></asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<asp:TextBox ID="txtCurrencyCode" runat="server" Text='' Width="100px"
                                CssClass="right"></asp:TextBox>
                                 
                            <asp:FilteredTextBoxExtender runat="server" ID="filCurrencyCode" TargetControlID="txtCurrencyCode"
                                ValidChars="0123456789.">
                            </asp:FilteredTextBoxExtender>--%>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="BDTAmount" HeaderText="BDT Amount" SortExpression="BDTAmount"
                                    ReadOnly="True">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="USDAmount" HeaderText="USD Amount" SortExpression="USDAmount"
                                    ReadOnly="True" DataFormatString="{0:N4}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TransactionDate" HeaderText="Trn Date" SortExpression="TransactionDate"
                                    DataFormatString="{0:dd/MM/yyyy}" ReadOnly="True">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Branch" SortExpression="Branch_Code">
                                    <ItemTemplate>
                                        <uc3:Branch ID="Branch1" BranchID='<%# Eval("Branch_Code") %>' runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ActualRemarks" HeaderText="Actual Remarks" SortExpression="ActualRemarks"
                                    ReadOnly="True" />
                                <asp:BoundField DataField="Validity" HeaderText="Validity" SortExpression="Validity"
                                    ReadOnly="True">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Insert By" SortExpression="InsertBy">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy")%>' Position="Left" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="On" SortExpression="InsertDt">
                                    <ItemTemplate>
                                        <div title='<%# Eval("InsertDt","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                            <%# TrustControl1.ToRecentDateTime(Eval("InsertDt"))%><br />
                                            <time class="timeago" datetime='<%# Eval("InsertDt","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Update By" SortExpression="UpdateBy">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("UpdateBy")%>' Position="Left" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="On" SortExpression="UpdateDt">
                                    <ItemTemplate>
                                        <div title='<%# Eval("UpdateDt","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                            <%# TrustControl1.ToRecentDateTime(Eval("UpdateDt"))%><br />
                                            <time class="timeago" datetime='<%# Eval("UpdateDt","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                               
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteBtn" runat="server" CommandName="Delete" ToolTip="Delete"><img src="Images/cross.png" />
                                        </asp:LinkButton>
                                        <asp:ConfirmButtonExtender runat="server" ID="DeleteID" ConfirmText="Do you want to Delete?"
                                            TargetControlID="DeleteBtn">
                                        </asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                No Data Found.</EmptyDataTemplate>
                            <FooterStyle BackColor="#CCCC99" HorizontalAlign="Center" Font-Bold="True" />
                            <PagerSettings Mode="NumericFirstLast" PageButtonCount="30" Position="TopAndBottom" />
                            <PagerStyle HorizontalAlign="Left" CssClass="PagerStyle" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="False" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                            <EditRowStyle BackColor="#DDDDDD" Font-Bold="True" />
                        </asp:GridView>
                        <asp:Label ID="lblStatus1" runat="server"></asp:Label>
                        <asp:Button ID="cmdGenerateNewBatch" runat="server" Text="Download New Batch" OnClick="cmdGenerateNewBatch_Click" />
                        <asp:ConfirmButtonExtender runat="server" ID="conDonwload" ConfirmText="Do you want to Downalod?"
                            TargetControlID="cmdGenerateNewBatch" Enabled="True">
                        </asp:ConfirmButtonExtender>
                        <asp:Label Font-Bold="True" ID="lblDownload" runat="server"></asp:Label>
                        <asp:SqlDataSource ID="SqlItemsInsert" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            InsertCommand="[s_CreditCardPaymentCollectionAccount]" InsertCommandType="StoredProcedure"
                            OnInserted="SqlItemsInsert_Inserted" EnableCaching="True">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="txtDateFrom" Name="FromDate" PropertyName="Text"
                                    Type="DateTime" />
                                <asp:ControlParameter ControlID="txtDateTo" Name="ToDate" PropertyName="Text" Type="DateTime" />
                                <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                                <asp:Parameter DefaultValue=" " Direction="InputOutput" Name="Msg" Size="255" Type="String" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_CardPaymentCollectionTransactions" SelectCommandType="StoredProcedure"
                            UpdateCommand="s_CardPaymentCollectionTransactions_Update" UpdateCommandType="StoredProcedure"
                            DeleteCommand="DELETE FROM CardPaymentCollectionTransactions WHERE TransactionID=@TransactionID"
                            OnUpdated="SqlDataSource1_Updated" OnSelected="SqlDataSource1_Selected">
                            <UpdateParameters>
                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                <asp:Parameter Name="TransactionID" Type="String" />
                                <asp:Parameter Name="CardNo" Type="String" />
                                <asp:Parameter Name="CurrencyCode" Type="String" />
                                <asp:SessionParameter SessionField="EMPID" Name="UpdateBy" Type="String" />
                                <asp:Parameter Direction="InputOutput" Name="Msg" Type="String" Size="255" DefaultValue=" " />
                                <asp:Parameter Direction="InputOutput" Name="Done" Type="Boolean" DefaultValue="false" />
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="TransactionID" Type="String" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tab2">
                    <HeaderTemplate>
                        History</HeaderTemplate>
                    <ContentTemplate>
                        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                            AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                            BorderWidth="1px" CellPadding="4" DataKeyNames="Batch" DataSourceID="SqlDataSource2"
                            ForeColor="Black" GridLines="Vertical">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="Batch" HeaderText="Batch" ReadOnly="True" SortExpression="Batch"
                                    ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                                <asp:TemplateField HeaderText="On" SortExpression="DownloadDT">
                                    <ItemTemplate>
                                        <div title='<%# Eval("DownloadDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                            <%# TrustControl1.ToRecentDateTime(Eval("DownloadDT"))%>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="About" SortExpression="DownloadDT">
                                    <ItemTemplate>
                                        <div title='<%# Eval("DownloadDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                            <time class="timeago" datetime='<%# Eval("DownloadDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Total" HeaderText="Total Items" SortExpression="Total"
                                    DataFormatString="{0:N0}" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" SortExpression="TotalAmount"
                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" />
                                <asp:TemplateField HeaderText="Download By" SortExpression="DownloadBy">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("DownloadBy")%>' Position="Left" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <a href='Card_Payment_Batch.aspx?batch=<%# Eval("Batch") %>&type=view' target="_blank">
                                            View</a> | <a href='Card_Payment_Batch.aspx?batch=<%# Eval("Batch") %>&type=dbf'
                                                target="_blank">DBF</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--   <asp:BoundField DataField="InsertBy" HeaderText="InsertBy" 
                        SortExpression="InsertBy" />
                    <asp:BoundField DataField="InsertDt" HeaderText="InsertDt" 
                        SortExpression="InsertDt" />--%>
                                <%--    <a href='<%# "Card_Payment_Batch.aspx?batch=" + Eval("Batch") + "&type=dbf&Batch=" + (Eval("Batch")) %>'
                        class="Link">DBF</a>--%>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="SELECT * FROM [CardPaymentCollectionTransactionsDownloadLog] order by Batch Desc">
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
            </asp:TabContainer>
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
