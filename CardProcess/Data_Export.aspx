<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master"
    CodeFile="Data_Export.aspx.cs" Inherits="Data_Export"  %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Data Export to ITCL
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:TabContainer runat="server" ID="tabContainer" CssClass="NewsTab" OnDemand="true"
                ActiveTabIndex="0" Width="100%" OnActiveTabChanged="tabContainer_ActiveTabChanged">
                <asp:TabPanel runat="server" ID="tab1">
                    <HeaderTemplate>
                        Ready to Export
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:GridView ID="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="false"
                            BackColor="White" BorderColor="#6B696B" BorderStyle="Solid" BorderWidth="5px" EnableViewState="false"
                            CellPadding="3" DataSourceID="SqlDataSource3" ForeColor="Black" CssClass="Grid"
                            GridLines="Vertical" Style="font-size: small" Width="600px" OnDataBound="GridView2_DataBound"
                            ShowFooter="True">
                            <Columns>
                                <asp:BoundField DataField="CardTypeCode" HeaderText="Type Code" SortExpression="CardTypeCode"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CardType" HeaderText="Card Type" SortExpression="CardType" />
                                <asp:BoundField DataField="Ready To Send" HeaderText="Ready To Send" SortExpression="Ready To Send"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="%" SortExpression="Ready To Send">
                                    <ItemTemplate>
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" />
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                No Data Found.
                            </EmptyDataTemplate>
                            <EmptyDataRowStyle Height="100px" HorizontalAlign="Center" Font-Size="X-Large" />
                            <RowStyle BackColor="#F7F7DE" />
                            <FooterStyle BackColor="#F2C92B" Font-Bold="true" HorizontalAlign="Center" Font-Size="XX-Large" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tab2">
                    <HeaderTemplate>
                        Export History
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
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                            AutoGenerateColumns="False" BackColor="White" BorderColor="#478ACA" BorderStyle="Solid"
                            BorderWidth="1px" CellPadding="5" DataKeyNames="SL" DataSourceID="SqlDataSource2"
                            PagerSettings-Mode="NumericFirstLast" Style="font-size: small" GridLines="Both" OnRowCommand="GridView1_RowCommand"
                            PageSize="10" Width="95%" PagerSettings-Position="TopAndBottom" PagerSettings-PageButtonCount="20">
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" BorderColor="#478ACA" BorderStyle="Dotted"
                                BorderWidth="1px" VerticalAlign="Top" />
                            <PagerStyle BackColor="#478ACA" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="#F7F7F7" BorderStyle="Solid" BorderWidth="1px" BorderColor="#478ACA" />
                            <Columns>
                                <asp:BoundField DataField="SL" HeaderText="Batch" InsertVisible="False" ReadOnly="True"
                                    SortExpression="SL" ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Sent By" SortExpression="[Send By]">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP55" Username='<%# Eval("[Send By]") %>' runat="server" />
                                        <br />
                                        <span class="time-small" title='<%# Eval("Sent on", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("Sent on","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="CardType" HeaderText="Card Type" SortExpression="CardType"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="CardTypeName" HeaderText="Card Type Name" SortExpression="CardTypeName"
                                    ItemStyle-HorizontalAlign="Left">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Card_IssueFee" HeaderText="Card Issue Fee" SortExpression="Card_IssueFee"
                                    ItemStyle-HorizontalAlign="Left">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                               <%-- <asp:BoundField DataField="From ID" HeaderText="Start ID" SortExpression="From ID"
                                    ItemStyle-HorizontalAlign="center">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>--%>
                                <asp:BoundField DataField="Total Cards" HeaderText="Total Cards" SortExpression="Total Cards"
                                    ItemStyle-HorizontalAlign="Right">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                               <%-- <asp:TemplateField HeaderText="Branches" SortExpression="Branches">
                                    <ItemTemplate>
                                        <%# AddLinkToBranches(Eval("Branches"), Eval("SL")) %>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download" HeaderStyle-Width="90px">
                                    <ItemTemplate>
                                        <a href='<%# "Data_Export_Download.aspx?type=xlsx&batch=" + Eval("SL")+ "&CardType=" + Eval("CardType") + "&branches=" + (Eval("Branches")).ToString().Replace(" ", "") %>' target="_blank"
                                            class="Link">XLSX</a> | <a href='<%# "Data_Export_Download.aspx?type=csv&batch=" + Eval("SL")+ "&CardType=" + Eval("CardType") + "&branches=" + (Eval("Branches")).ToString().Replace(" ", "") %>' target="_blank"
                                                class="Link">CSV</a>| <a href='<%# "Data_Export_Download.aspx?type=view&batch=" + Eval("SL")+ "&CardType=" + Eval("CardType") + "&branches=" + (Eval("Branches")).ToString().Replace(" ", "") %>' target="_blank"
                                                    class="Link">View</a>| <a href='<%# "Data_Export_Download.aspx?type=xlsx1&batch=" + Eval("SL") %>' target="_blank"
                                                        class="Link">Fee</a>| <a href='<%# "Data_Export_Download.aspx?type=xml&batch=" + Eval("SL")+ "&CardType=" + Eval("CardType") + "&branches=" + (Eval("Branches")).ToString().Replace(" ", "") %>' target="_blank"
                                                            class="Link">XML</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Forwarding Letter" ItemStyle-HorizontalAlign="Center"
                                    Visible="false">
                                    <ItemTemplate>
                                        <a target="_blank" href='<%# "Forwarding.aspx?temp=&date=&batch=" + Eval("SL") %>'
                                            class="Link">Batch</a>&nbsp;&nbsp; <a target="_blank" href='<%# "Forwarding.aspx?temp=&batch=&date=" + Eval("Sent On","{0:dd/MM/yyyy}") %>'
                                                class="Link">Date</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Download Picture" ItemStyle-HorizontalAlign="Center"
                                    Visible="true">
                                    <ItemTemplate>
                                        <div class='<%# Eval("PictureRequired").ToString().ToUpper() == "TRUE" ? "" : "hidden" %>'>
                                            <a href='<%# "DownloadPicture.ashx?type=new&batch=" + Eval("SL") %>' target="_blank" class="Link">Download</a>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transfer">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="TransferBtn" CommandArgument='<%# Eval("SL") %>' Visible='<%# (decimal.Parse(Eval("Card_IssueFee").ToString()) >0 && Eval("TRANSFER").ToString() == "False" && decimal.Parse(Eval("Total Cards").ToString())>0  ? true : false) %>'
                                            runat="server" CommandName="Transfer" ToolTip="Transfer">Transfer
                                        </asp:LinkButton>
                                        <asp:ConfirmButtonExtender runat="server" ID="TransferID" ConfirmText="Do you want to Transfer?"
                                            TargetControlID="TransferBtn"></asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transfer By" SortExpression="TransferBY">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP551" Username='<%# Eval("TransferBY") %>' runat="server" />
                                        <br />
                                        <span class="time-small" title='<%# Eval("TransferDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("TransferDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>No data found.</EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_SentLog_Browse" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource2_Selected">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextBox1" Name="DateFrom" DefaultValue="01/01/1900"
                                    PropertyName="Text" Type="DateTime" />
                                <asp:ControlParameter ControlID="TextBox2" Name="DateTo" PropertyName="Text" DefaultValue="01/01/1900"
                                    Type="DateTime" />
                                <asp:Parameter Name="TotalCards" Direction="InputOutput" DefaultValue="0" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Label runat="server" ID="lblTotalReissue" Text="" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tab3">
                    <HeaderTemplate>
                        Export New Data
                    </HeaderTemplate>
                    <ContentTemplate>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td colspan="2">
                                    <div style="border: solid 5px #F2C92B; width: 510px; padding: 10px; background-color: #F6F8FC;">
                                        <table>
                                            <tr>
                                                <td class="SmallFont" style="text-align: right">Start ID:
                                                </td>
                                                <td style="width: 5px">&nbsp;
                                                </td>
                                                <td>
                                                    <asp:Label ID="txtStartID" runat="server" CssClass="Center" Font-Bold="true" Font-Names="Arial"
                                                        Font-Size="Small" Width="80px"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="SmallFont" style="text-align: right;" nowrap="nowrap">Card Type:
                                                </td>
                                                <td style="margin-left: 40px">&nbsp;
                                                </td>
                                                <td style="margin-left: 40px">
                                                    <asp:DropDownList ID="cboCardType" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                        DataSourceID="SqlDataSource3" DataTextField="CardType" DataValueField="CardTypeCode"
                                                        OnSelectedIndexChanged="cboCardType_SelectedIndexChanged">
                                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="SqlDataSourceCardType" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                                        SelectCommand="SELECT [CardTypeCode], [CardType] FROM [CardTypes] ORDER BY [CardType]"></asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="SmallFont" nowrap="nowrap" style="text-align: right;">Total Export:
                                                </td>
                                                <td style="margin-left: 40px">&nbsp;
                                                </td>
                                                <td style="margin-left: 40px">
                                                    <asp:DropDownList ID="cboMaxRowsToSent" runat="server" AutoPostBack="True" CausesValidation="false"
                                                        OnSelectedIndexChanged="cboMaxRowsToSent_SelectedIndexChanged">
                                                        <asp:ListItem></asp:ListItem>
                                                        <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                                        <asp:ListItem Text="100" Value="100"></asp:ListItem>
                                                        <asp:ListItem Text="150" Value="150"></asp:ListItem>
                                                        <asp:ListItem Text="200" Value="200"></asp:ListItem>
                                                        <asp:ListItem Text="250" Value="250"></asp:ListItem>
                                                        <asp:ListItem Text="300" Value="300"></asp:ListItem>
                                                        <asp:ListItem Text="350" Value="350"></asp:ListItem>
                                                        <asp:ListItem Text="400" Value="400"></asp:ListItem>
                                                        <asp:ListItem Text="500" Value="500"></asp:ListItem>
                                                        <asp:ListItem Text="600" Value="600"></asp:ListItem>
                                                        <asp:ListItem Text="700" Value="700"></asp:ListItem>
                                                        <asp:ListItem Text="800" Value="800"></asp:ListItem>
                                                        <asp:ListItem Text="900" Value="900"></asp:ListItem>
                                                        <asp:ListItem Text="1000" Value="1000"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="SmallFont"></td>
                                                <td style="text-align: right;">&nbsp;
                                                </td>
                                                <td style="text-align: left;">
                                                    <asp:Button ID="cmdExport" runat="server" Enabled="False" OnClick="cmdExport_Click"
                                                        Text="Export to ITCL" Width="130px" />
                                                    <asp:ConfirmButtonExtender ID="cmdExport_ConfirmButtonExtender" runat="server" ConfirmText="Do you want to export the selected data?"
                                                        Enabled="True" TargetControlID="cmdExport"></asp:ConfirmButtonExtender>
                                                    <asp:HyperLink ID="lnkCsv" runat="server" Visible="false" Text="<br>Download as CSV"
                                                        Target="_blank"></asp:HyperLink>
                                                    <asp:HyperLink ID="lnkXlsx" runat="server" Visible="false" Text="<br>Download as XLSX"
                                                        Target="_blank"></asp:HyperLink>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="SmallFont" style="text-align: right;">Ready to Export:
                                                </td>
                                                <td class="SmallFont" style="margin-left: 40px">&nbsp;
                                                </td>
                                                <td class="SmallFont" style="margin-left: 40px">
                                                    <asp:Label ID="lblTotalUnsent" runat="server" Font-Bold="true" Text="0"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="SmallFont" style="text-align: right;">Card Type:
                                                </td>
                                                <td style="margin-left: 40px" class="SmallFont">&nbsp;
                                                </td>
                                                <td class="SmallFont" style="margin-left: 40px">
                                                    <asp:Label ID="lblCardType" runat="server" Font-Bold="true" Text="0"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="SmallFont" style="text-align: right; padding-left: 10px" nowrap="nowrap"
                                                    valign="top">Delivery Branches:
                                                </td>
                                                <td style="margin-left: 40px" class="SmallFont">&nbsp;
                                                </td>
                                                <td class="SmallFont" style="margin-left: 40px">
                                                    <asp:Label ID="lblSelectedBrances" runat="server" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="background-color: #F2C92B; padding: 10px">
                                    <b>Select Delivery Branches:</b>
                                </td>
                            </tr>
                            <tr>
                                <td style="" valign="top">
                                    <div style="background-color: #F2C92B; padding: 10px 0px 10px 5px; width: 100px">
                                        <asp:CheckBox ID="chkSelectAllBranch" Text="Select All" CssClass="SmallFont" runat="server"
                                            AutoPostBack="True" OnCheckedChanged="chkSelectAllBranch_CheckedChanged" Enabled="false" />
                                    </div>
                                </td>
                                <td>
                                    <div style="height: 350px; overflow: auto; width: 425px; border-left: solid 5px #F2C92B; border-bottom: solid 5px #F2C92B; border-right: solid 5px #F2C92B; background-color: #FAFAD2">
                                        <asp:CheckBoxList ID="chkBranches" runat="server" Width="300px" DataSourceID="" DataTextField="BranchName"
                                            DataValueField="BranchID" Style="font-size: small" BorderColor="#FFCC66" BorderStyle="None"
                                            BorderWidth="0px" AutoPostBack="True" OnSelectedIndexChanged="chkBranches_SelectedIndexChanged"
                                            RepeatLayout="Table">
                                        </asp:CheckBoxList>
                                        <asp:GridView ID="GridView3" runat="server" AllowSorting="True" AutoGenerateColumns="false"
                                            BackColor="LightGoldenrodYellow" BorderWidth="0px" CellPadding="2" DataSourceID="SqlDataSource4"
                                            ForeColor="Black" Width="405px" GridLines="None" Style="font-size: small" CssClass="Grid"
                                            OnRowCommand="GridView3_RowCommand" OnDataBound="GridView3_DataBound">
                                            <Columns>
                                                <asp:TemplateField SortExpression="BranchID" HeaderText="ID">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkBranchSelect" runat="server" Text='<%# Eval("BranchID") %>'
                                                            AutoPostBack="true" OnCheckedChanged="chkBranchSelect_CheckedChanged1" EnableTheming="true" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Branch Name" SortExpression="BranchName">
                                                    <ItemTemplate>
                                                        <a class="Link" target="_blank" href='ShowCards.aspx?cardtype=<%# cboCardType.SelectedItem.Value %>&branch=<%# Eval("BranchID") %>'>
                                                            <span style="color: blue">
                                                                <%# Eval("BranchName") %></span> </a>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="ReadyToSend" HeaderText="Ready" SortExpression="ReadyToSend"
                                                    ItemStyle-HorizontalAlign="Center">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>
                                            </Columns>
                                            <EmptyDataTemplate>
                                                <br />
                                                <ul>
                                                    <li>No Data Found.</li>
                                                </ul>
                                            </EmptyDataTemplate>
                                            <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                                            <HeaderStyle BackColor="Tan" ForeColor="White" />
                                            <RowStyle BackColor="White" />
                                            <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="sp_Branch_wise_Card_Ready_To_Export" SelectCommandType="StoredProcedure"
                            OnSelected="SqlDataSource4_Selected">
                            <SelectParameters>
                                <asp:ControlParameter Name="CardType" ControlID="cboCardType" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="sp_ExportToITCL" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="EMPID" Name="EmpID" Type="String" />
                                <asp:ControlParameter Name="CardType" ControlID="cboCardType" PropertyName="SelectedValue" />
                                <asp:ControlParameter Name="MaxRowsToSent" ControlID="cboMaxRowsToSent" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="lblSelectedBrances" Name="BranchCodes" PropertyName="Text"
                                    DefaultValue="                                                                         " />
                                <asp:Parameter Name="Batch" Direction="InputOutput" Type="Int32" DefaultValue="0" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="sp_ExportToITCL_xlsx" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter SessionField="EMPID" Name="EmpID" Type="String" />
                                <asp:ControlParameter Name="CardType" ControlID="cboCardType" PropertyName="SelectedValue" />
                                <asp:ControlParameter Name="MaxRowsToSent" ControlID="cboMaxRowsToSent" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="lblSelectedBrances" Name="BranchCodes" PropertyName="Text"
                                    DefaultValue="                                                                         " />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tab4">
                    <HeaderTemplate>
                        Mark as Sent
                    </HeaderTemplate>
                    <ContentTemplate>
                        <table class="Panel1 ui-corner-all">
                            <tr>
                                <td>
                                    <b>ID/Account No: </b>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAccountNo" runat="server" MaxLength="15" Width="170px" CssClass="Center"
                                        Font-Size="Large"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="cmdOpen" runat="server" Text="Search" Width="80px" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:GridView ID="GridView4" runat="server" AllowPaging="True" AllowSorting="True"
                            AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                            BorderWidth="1px" CellPadding="4" DataKeyNames="ID" CssClass="Grid" DataSourceID="SqlDataSource_sp_CardProcess_Search_Mark_as_Sent_Single"
                            ForeColor="Black" GridLines="Vertical" OnRowCommand="GridView4_RowCommand">
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <Columns>
                                <asp:TemplateField HeaderText="ID" SortExpression="ID">
                                    <ItemTemplate>
                                        <%# Eval("ID","<a href='Card_AddEdit.aspx?ID={0}' target='_blank'><b>{0}</b></a>")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account"
                                    ItemStyle-Font-Bold="true" ItemStyle-Wrap="false">
                                    <ItemStyle Font-Bold="True" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FIO" HeaderText="FIO" SortExpression="FIO" />
                                <asp:TemplateField HeaderText="Card Type">
                                    <ItemTemplate>
                                        <%# Eval("CardTypeName")%><br />
                                        <%# Eval("CardType")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ReqBranchName" HeaderText="Request Branch" SortExpression="ReqBranchName" />
                                <asp:BoundField DataField="DeliveryToBranchName" HeaderText="Delivery Branch" SortExpression="DeliveryToBranchName" />
                                <asp:CheckBoxField DataField="SendToProcess" HeaderText="Sent" SortExpression="SendToProcess"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:CheckBoxField>
                                <asp:TemplateField HeaderText="Send By" SortExpression="SendBy">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" Username='<%# Eval("SendBy") %>' runat="server" />
                                        <br />
                                        <span class="time-small" title='<%# Eval("SendOn", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("SendOn","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="BatchNo" HeaderText="Batch" SortExpression="BatchNo" ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="cmdMarkAsSent" runat="server" Text="Mark as Sent" CommandArgument='<%# Eval("ID") %>'
                                            Visible='<%# (Eval("SendToProcess").ToString() == "True" ? false : true) %>'
                                            CommandName="MarkAsSent" />
                                        <asp:ConfirmButtonExtender runat="server" ConfirmText="Do you want to mark as sent?"
                                            TargetControlID="cmdMarkAsSent"></asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource_sp_CardProcess_Search_Mark_as_Sent_Single" runat="server"
                            ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="sp_CardProcess_Search_Mark_as_Sent_Single"
                            SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtAccountNo" Name="Filter" PropertyName="Text"
                                    Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tabDeleteAll">
                    <HeaderTemplate>
                        Delete
                    </HeaderTemplate>
                    <ContentTemplate>
                        <table class="Panel1 ui-corner-all">
                            <tr>
                                <td>
                                    <b>Account No: </b>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAccount" runat="server" MaxLength="20" Width="170px" CssClass="Center"
                                        Font-Size="Large"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="Button1" runat="server" Text="Search" Width="80px" OnClick="Button1_Click" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" BackColor="White"
                            Visible="true" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4"
                            DataKeyNames="ID" DataSourceID="SqlDataSourceSearch" ForeColor="Black" GridLines="Vertical"
                            CssClass="Grid">
                            <Columns>
                                <asp:TemplateField HeaderText="ID" SortExpression="ID">
                                    <ItemTemplate>
                                        <%# Eval("ID","<a href='Card_AddEdit.aspx?ID={0}' target='_blank'><b>{0}</b></a>")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ITCLID" HeaderText="ITCLID" SortExpression="ITCLID" />
                                <asp:BoundField DataField="Account" HeaderText="Account" ReadOnly="True" SortExpression="Account">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NameOnCard" HeaderText="Name On Card" SortExpression="NameOnCard" />
                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                <asp:BoundField DataField="BatchNo" HeaderText="Batch No" SortExpression="BatchNo">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SendToProcess" HeaderText="Send To Process" SortExpression="SendToProcess" />
                                <asp:TemplateField HeaderText="Send By" SortExpression="SendBy">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" Username='<%# Eval("SendBy") %>' runat="server" />
                                        <br />
                                        <span class="time-small" title='<%# Eval("SendOn", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("SendOn","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button runat="server" ID="cmdDelete1" CommandName="Delete" Text="Delete" Visible='<%# (Eval("SendOn", "{0:dd/MM/yyyy}").ToString() == Eval("CurrentDate", "{0:dd/MM/yyyy}").ToString() ? true : false) %>' />
                                        <asp:ConfirmButtonExtender runat="server" ID="ConfirmButtonExtenderDelete1" TargetControlID="cmdDelete1"
                                            ConfirmText="Do you want to Delete?"></asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <AlternatingRowStyle BackColor="White" />
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceSearch" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_CardProcess_Search" SelectCommandType="StoredProcedure" DeleteCommand="s_CardProcess_Delete_Mark"
                            DeleteCommandType="StoredProcedure" OnDeleted="SqlDataSourceSearch_Deleted">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtAccount" Name="Account" PropertyName="Text" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="ID" Type="Int32" />
                                <asp:Parameter Name="Msg" Type="String" Size="250" DefaultValue="" Direction="InputOutput" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tabNewExport">
                    <HeaderTemplate>
                        New Export
                    </HeaderTemplate>
                    <ContentTemplate>
                        <table class="Panel1 ui-corner-all">
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtaccountno1" runat="server" placeholder="account no." MaxLength="20" Width="120px" CssClass="left"></asp:TextBox>
                                </td>
                                <td><b>Card Type: </b></td>
                                <td>
                                    <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource3" DataTextField="CardType" DataValueField="CardTypeCode">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td><b>Req. Branch: </b></td>
                                <td>
                                    <asp:DropDownList ID="cboBranch" runat="server" AppendDataBoundItems="True"
                                        DataSourceID="SqlDataSource8" DataTextField="branchname" DataValueField="branchid">
                                        <asp:ListItem Text="All Branch" Value="-1"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>Total Export :</td>
                                <td>
                                    <asp:DropDownList ID="cboMaxRowsToSent1" runat="server" CausesValidation="false">
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                        <asp:ListItem Text="100" Value="100"></asp:ListItem>
                                        <asp:ListItem Text="150" Value="150"></asp:ListItem>
                                        <asp:ListItem Text="200" Value="200"></asp:ListItem>
                                        <asp:ListItem Text="250" Value="250"></asp:ListItem>
                                        <asp:ListItem Text="300" Value="300"></asp:ListItem>
                                        <asp:ListItem Text="350" Value="350"></asp:ListItem>
                                        <asp:ListItem Text="400" Value="400"></asp:ListItem>
                                        <asp:ListItem Text="500" Value="500"></asp:ListItem>
                                        <asp:ListItem Text="600" Value="600"></asp:ListItem>
                                        <asp:ListItem Text="700" Value="700"></asp:ListItem>
                                        <asp:ListItem Text="800" Value="800"></asp:ListItem>
                                        <asp:ListItem Text="900" Value="900"></asp:ListItem>
                                        <asp:ListItem Text="1000" Value="1000"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Button ID="Button2" runat="server" Text="Search" Width="80px" OnClick="Button2_Click" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:Label ID="lblmsg" runat="server" Text="" Visible="false"></asp:Label>
                        <asp:Button ID="cmdExport1" runat="server" Enabled="False" OnClick="cmdExport1_Click"
                            Text="Export to ITCL" Width="130px" />
                        <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="SELECT  [branchid],[branchname]  FROM [CardData].[dbo].[v_BranchOnly]"
                            SelectCommandType="Text"></asp:SqlDataSource>
                        <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" BackColor="White"
                            AllowSorting="true" AllowPaging="false" PagerSettings-Position="TopAndBottom" CssClass="Grid"
                            PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="20" PageSize="50"
                            BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="ID"
                            DataSourceID="SqlDataSource6" ForeColor="Black" GridLines="Vertical" Style="font-size: small; font-family: Arial, Helvetica, sans-serif">
                            <PagerSettings Mode="NumericFirstLast" PageButtonCount="20" Position="TopAndBottom"></PagerSettings>
                            <RowStyle BackColor="#F7F7DE" CssClass="Grid" />
                            <Columns>
                                <asp:TemplateField HeaderText="ID" SortExpression="ID">
                                    <ItemTemplate>
                                        <a href='Card_AddEdit.aspx?ID=<%# Eval("ID") %>' target="_blank" class="Link">
                                            <%# Eval("ID") %></a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="FIO" HeaderText="FIO" SortExpression="FIO" />
                                <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account" />
                                <asp:BoundField DataField="CardType" HeaderText="CardType" SortExpression="CardType"
                                    ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="BranchName" HeaderText="Req Name" SortExpression="BranchName"
                                    ItemStyle-HorizontalAlign="Left" />
                                <asp:TemplateField HeaderText="InsertBy" SortExpression="InsertBy" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                                        <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DeliveryToBranch" HeaderText="DeliveryToBranch" ItemStyle-HorizontalAlign="Center"
                                    SortExpression="DeliveryToBranch" />
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox runat="server" ID="headerLevelCheckBox" Text="Select All" AutoPostBack="true" OnCheckedChanged="headerLevelCheckBox_CheckedChanged" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="rowLevelCheckBox" Text='<%# Eval("ID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_Issue_Card_Ready_To_Export" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource6_Selected">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtaccountno1" Name="AccountNo" Type="String" DefaultValue="*" />
                                <asp:ControlParameter ControlID="DropDownList2" Name="CardType" Type="String" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="cboBranch" Name="ReqBranch" Type="String" DefaultValue="-1" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                    </ContentTemplate>
                </asp:TabPanel>
            </asp:TabContainer>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Cards_Ready_To_Send" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
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
