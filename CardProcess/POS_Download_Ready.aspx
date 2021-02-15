﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="POS_Download_Ready.aspx.cs" Inherits="POS_Download_Ready" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
    POS Download Log
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:TabContainer runat="server" ID="tabContainer" CssClass="NewsTab" OnDemand="true"
                ActiveTabIndex="0" Width="90%" OnActiveTabChanged="tabContainer_ActiveTabChanged">
                <asp:TabPanel runat="server" ID="tab1">
                    <HeaderTemplate>
                        Ready To Generate Batch
                    </HeaderTemplate>
                    <ContentTemplate>
                        <table style="margin-left: 100px;">
                            <tr>
                                <td>
                                    <asp:Button ID="btnDownload" runat="server" Text="Make a Batch For Download" Visible="false"
                                        OnClick="btnDownload_Click" />
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                            AutoGenerateColumns="False" BackColor="White" PagerSettings-Position="TopAndBottom"
                            PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                            BorderWidth="1px" CellPadding="4" PageSize="20" DataKeyNames="Batch" ForeColor="Black"
                            DataSourceID="SqlDataSourceDataUploadLog" Style="font-size: small" EnableSortingAndPagingCallbacks="True"
                            OnRowDataBound="GridView2_RowDataBound">
                            <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                            <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                            <Columns>
                                <asp:TemplateField HeaderText="View Data" SortExpression="Batch">
                                    <ItemTemplate>
                                        <a href='ReconcilliationView.aspx?batchid=<%# Eval("Batch") %>' target="_blank" class="Link">
                                            <span style="color: blue">
                                                <%# Eval("Batch") %></span></a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DT" HeaderText="Upload On" SortExpression="Upload On"
                                    DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:TemplateField HeaderText="By Emp" SortExpression="EmpID">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Total" HeaderText="Total Records" SortExpression="Total"
                                    DataFormatString="{0:N0}" />
                                <asp:BoundField DataField="payment_receipt_from_visa" HeaderText="Payment Receipt From Visa"
                                    SortExpression="payment_receipt_from_visa" DataFormatString="{0:N2}" />
                                <asp:BoundField DataField="payment_receipt_from_visa_Int" HeaderText="Payment Receipt From Visa Int"
                                    SortExpression="payment_receipt_from_visa_Int" DataFormatString="{0:N2}" />
                                <asp:BoundField DataField="TransCat" HeaderText="Transaction Category" SortExpression="TransCat" />
                                <asp:BoundField DataField="DownloadBatch" HeaderText="Download Batch" SortExpression="DownloadBatch" />
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />

                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceDataUploadLog" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_Pos_Download_Ready" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tab2">
                    <HeaderTemplate>
                        Download History
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:Panel ID="Panel1" runat="server">
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
                        <asp:Literal ID="ltlComAmt" runat="server"></asp:Literal>
                        <asp:Literal ID="lblShiftAmt" runat="server"></asp:Literal>
                        <asp:Literal ID="lblMerchantAmt" runat="server"></asp:Literal>
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                            AutoGenerateColumns="False" BackColor="White" PagerSettings-Position="TopAndBottom"
                            PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                            BorderWidth="1px" CellPadding="4" PageSize="20" DataKeyNames="DownloadBatch"
                            ForeColor="Black" DataSourceID="SqlDataSource1" Style="font-size: small" EnableSortingAndPagingCallbacks="True"
                            OnRowDataBound="GridView1_RowDataBound">
                            <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                            <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                            <Columns>
                                <asp:TemplateField HeaderText="Download Batch" SortExpression="DownloadBatch">
                                    <ItemTemplate>
                                        <a href='PosDownloadBatchView.aspx?batch=<%# Eval("DownloadBatch") %>' target="_blank"
                                            class="Link"><span style="color: blue">
                                                <%# Eval("DownloadBatch")%></span></a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- <asp:BoundField DataField="DownloadBatch" HeaderText="Download Batch" SortExpression="DownloadBatch" />--%>
                                <asp:TemplateField HeaderText="By Emp" SortExpression="DownloadBy">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("DownloadBy") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DownloadDT" HeaderText="Download DT" SortExpression="DownloadDT"
                                    DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:TemplateField HeaderText="Shifting Amount" SortExpression="DownloadBatch">
                                    <ItemTemplate>
                                        <%--  <a href='<%# Eval("ShiftingAmountUrl") %>' target="_blank" class="Link">
                                <img src="Images/download2.png" width="22" height="22" border="0" title="Download"></a>--%>
                                        <a href='<%# Eval("ShiftingAmountUrl") %>' target="_blank" class="Link">
                                            <%--<img src="Images/download1.png" width="22" height="22" border="0" title="Download">--%>
                                            Download </a>||<a href='<%# Eval("ShiftingAmountUrlView") %>' target="_blank" class="Link">
                                                View</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Commission Amount" SortExpression="DownloadBatch">
                                    <ItemTemplate>
                                        <a href='<%# Eval("CommissionAmountUrl") %>' target="_blank" class="Link">
                                            <%--<img src="Images/download1.png" width="22" height="22" border="0" title="Download">--%>
                                            Download </a>||<a href='<%# Eval("CommissionAmountUrlView") %>' target="_blank" class="Link">
                                                View</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Merchant Amount" SortExpression="DownloadBatch">
                                    <ItemTemplate>
                                        <a href='<%# Eval("MerchantAmountUrl") %>' target="_blank" class="Link">
                                            <%--<img src="Images/download1.png" width="22" height="22" border="0" title="Download">--%>
                                            Download </a>||<a href='<%# Eval("MerchantAmountUrlView") %>' target="_blank" class="Link">
                                                View</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ShiftingDownloadCount" HeaderText="Shifting Amount<br /> Download Count"
                                    HtmlEncode="false" SortExpression="ShiftingDownloadCount" />
                                <asp:BoundField DataField="CommissionDownloadCount" HeaderText="Commission Amount<br /> Download Count"
                                    HtmlEncode="false" SortExpression="CommissionDownloadCount" />
                                <asp:BoundField DataField="MerchantDownloadCount" HeaderText="Merchant Amount<br /> Download Count"
                                    HtmlEncode="false" SortExpression="MerchantDownloadCount" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteBtn" Visible='<%# Eval("DownloadDT").ToString() == Eval("CurrentDate").ToString() ? true : false %>'
                                            runat="server" CommandName="Delete" ToolTip="Delete"><img src="Images/cross.png" />
                                        </asp:LinkButton>
                                        <asp:ConfirmButtonExtender runat="server" ID="DeleteID" ConfirmText="Do you want to Delete?"
                                            TargetControlID="DeleteBtn"></asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                            <EmptyDataTemplate>
                                No Record(s) Found For download.
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_Pos_Download_Log" SelectCommandType="StoredProcedure" DeleteCommand="s_PosdownloadBatchDelete"
                            DeleteCommandType="StoredProcedure" OnDeleted="SqlDataSource1_Deleted">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextBox1" Name="DateFrom" PropertyName="Text" DefaultValue="01/01/1900"
                                    Type="DateTime" />
                                <asp:ControlParameter ControlID="TextBox2" Name="DateTo" PropertyName="Text" Type="DateTime" DefaultValue="01/01/1900" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="DownloadBatch" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="Tab3" Visible="false">
                    <HeaderTemplate>
                        TBL & ITCL Commission
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:Panel ID="Panel3" runat="server">
                            <table class="Panel1 ui-corner-all">
                                <tr>
                                    <td>
                                        <b>Date Range:</b>
                                        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" CausesValidation="True"
                                            OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
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
                                        <asp:TextBox ID="TextBox3" CssClass="Date" runat="server" Width="100px"></asp:TextBox>
                                        <b>To:
                                        </b>
                                        <asp:TextBox ID="TextBox4" CssClass="Date" runat="server" Width="100px"></asp:TextBox>
                                        <asp:Button ID="Button1" runat="server" Text="Search" Width="80px" CausesValidation="false"
                                            OnClick="Button1_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                            AutoGenerateColumns="False" BackColor="White" PagerSettings-Position="TopAndBottom"
                            PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                            BorderWidth="1px" CellPadding="4" PageSize="20" DataKeyNames="itclcomm" ForeColor="Black"
                            DataSourceID="SqlDataSource2" Style="font-size: small" EnableSortingAndPagingCallbacks="True"
                            OnRowDataBound="GridView1_RowDataBound">
                            <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                            <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                            <Columns>
                                <asp:BoundField DataField="tblcomm" HeaderText="TBL Commission Amount" SortExpression="tblcomm"
                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" />
                                <asp:BoundField DataField="itclcomm" HeaderText="ITCL Commission Amount" SortExpression="itclcomm"
                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" />
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                            <EmptyDataTemplate>
                                No Record(s) Found.
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_Pos_Commission" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextBox3" Name="DateFrom" PropertyName="Text" Type="DateTime" DefaultValue="01/01/1900" />
                                <asp:ControlParameter ControlID="TextBox4" Name="DateTo" PropertyName="Text" Type="DateTime" DefaultValue="01/01/1900" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>


                <asp:TabPanel runat="server" ID="Tab4" Visible="false">
                    <HeaderTemplate>
                        Report
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:Panel ID="Panel2" runat="server" Visible="true">
                            <table class="Panel1" style="margin-left: 25px;">
                                <tr>
                                    <td class="style2 right">Date:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox5" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                                    </td>
                                    <td class="style2 right">to
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox6" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                                    </td>
                                    <td style="padding-left: 10px">
                                        <asp:Button ID="Button2" runat="server" Text="Show" OnClick="Button2_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:GridView ID="GridView4" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                            AutoGenerateColumns="False" BackColor="White" PagerSettings-Position="TopAndBottom"
                            PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                            BorderWidth="1px" CellPadding="4" PageSize="20" DataKeyNames="itclcomm" ForeColor="Black"
                            DataSourceID="SqlDataSource3" Style="font-size: small" EnableSortingAndPagingCallbacks="True">
                            <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                            <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                            <Columns>
                                <asp:BoundField DataField="tblcomm" HeaderText="TBL Commission Amount" SortExpression="tblcomm"
                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" />
                                <asp:BoundField DataField="itclcomm" HeaderText="ITCL Commission Amount" SortExpression="itclcomm"
                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" />
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                            <EmptyDataTemplate>
                                No Record(s) Found.
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_Pos_Commission" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextBox5" Name="DateFrom" PropertyName="Text" Type="DateTime" />
                                <asp:ControlParameter ControlID="TextBox6" Name="DateTo" PropertyName="Text" Type="DateTime" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="Tab5">
                    <HeaderTemplate>
                        Commission Account
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:Panel ID="Panel4" runat="server" Visible="true">
                            <table class="Panel1" style="margin-left: 25px;">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="TextBox9" runat="server" placeholder="account no" Width="80px"></asp:TextBox>
                                    </td>
                                    <td class="style2 right">Date:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox7" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                                    </td>
                                    <td class="style2 right">to
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox8" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                                    </td>
                                    <td style="padding-left: 10px">
                                        <asp:Button ID="Button3" runat="server" Text="Show" OnClick="Button3_Click" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:GridView ID="GridView5" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                            AutoGenerateColumns="False" BackColor="White" PagerSettings-Position="TopAndBottom"
                            PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                            BorderWidth="1px" CellPadding="4" PageSize="20" DataKeyNames="itclcomm" ForeColor="Black"
                            DataSourceID="SqlDataSource3" Style="font-size: small" EnableSortingAndPagingCallbacks="True">
                            <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                            <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                            <Columns>
                                <asp:BoundField DataField="DebitAmount" HeaderText="Debit Amount" SortExpression="DebitAmount"
                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" />
                                <asp:BoundField DataField="CreditAmount" HeaderText="Credit Amount" SortExpression="CreditAmount"
                                    ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}" />
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                            <EmptyDataTemplate>
                                No Record(s) Found.
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_Commission_Account_Summary" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextBox9" Name="Account" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="TextBox7" Name="DateFrom" PropertyName="Text" Type="DateTime" />
                                <asp:ControlParameter ControlID="TextBox8" Name="DateTo" PropertyName="Text" Type="DateTime" />
                            </SelectParameters>
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
