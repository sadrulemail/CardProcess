<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Dispute_Search.aspx.cs" Inherits="Dispute_Search" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .HoverLink {
            color: Blue;
            text-decoration: none;
        }

            .HoverLink:hover {
                color: Blue;
                text-decoration: underline;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Search Dispute
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table class="Panel1 ui-corner-all">
                <tr>
                    <td>
                        <table style="border-collapse: collapse;">
                            <tr>
                                <td>
                                    <table style="border-collapse: collapse;">
                                        <tr>
                                            <%--<td>
                                                <asp:DropDownList ID="ddlSearchType" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                                    DataTextField="SearchName" DataValueField="SearchValue"
                                                    OnDataBound="cboBranch_DataBound">
                                                    <asp:ListItem Value="" Text="All"></asp:ListItem>
                                                    <asp:ListItem Value="DisputeID" Text="Dispute ID"></asp:ListItem>
                                                    <asp:ListItem Value="Account" Text="Account"></asp:ListItem>
                                                    <asp:ListItem Value="CardNumber" Text="Card Number"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>--%>
                                            <td>
                                                <asp:TextBox ID="txtFilter" runat="server" Width="250px" onfocus="this.select()"
                                                    AutoPostBack="true" placeholder="dispute id, a/c no, card no"></asp:TextBox>
                                            </td>
                                            <td style="padding-left: 10px">Requested From:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="cboBranch" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                                    DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID"
                                                    OnDataBound="cboBranch_DataBound">
                                                    <asp:ListItem Value="" Text="All Branches"></asp:ListItem>
                                                    <asp:ListItem Value="1" Text="Head Office"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                                    SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] where Branchid &lt;&gt; 1 order by BranchName"></asp:SqlDataSource>
                                            </td>

                                            <td style="padding-left: 10px">Request Date:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                                            </td>
                                            <td>to
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                                            </td>

                                        </tr>
                                    </table>
                                    <table style="border-collapse: collapse;">
                                        <tr>
                                            <td>Acquirer Bank:</td>
                                            <td>
                                                <asp:DropDownList ID="cboBanks" DataSourceID="SqlDataSource2" DataValueField="Bank_Code"
                                                    DataTextField="Bank_Name" runat="server"
                                                    AppendDataBoundItems="true" AutoPostBack="true">
                                                    <asp:ListItem Text="All Bank" Value="*"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="padding-left: 10px">Status:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="cboStatus" Width="170px" runat="server" AppendDataBoundItems="True" AutoPostBack="true"
                                                    DataTextField="StatusName" DataValueField="StatusID" DataSourceID="SqlDataSourceStatus">
                                                    <asp:ListItem Value="" Text="All"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                                    SelectCommand="s_Dispute_Status_Select" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                            </td>
                                            <td style="padding-left: 10px">
                                                <asp:Button ID="cmdFilter" runat="server" Font-Bold="true" Text="Filter" Width="80px"
                                                    OnClick="cmdFilter_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_bank_select" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <br />
            <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="ID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True"
                OnRowCommand="GridView1_RowCommand" EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:TemplateField HeaderText="ID" SortExpression="ID" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <b><a title="Open" target="_blank" href='<%# "Dispute.aspx?ID=" + Eval("ID") %>'
                                class="HoverLink">
                                <%# Eval("ID") %></a></b>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="A/C Info" SortExpression="AccNo">
                        <ItemTemplate>
                            <%# Eval("Type","<div>Trns Type:<b>{0}</b></div>")%>
                            <%# Eval("AccNo","<b>{0}</b>") %>
                            <%# Eval("CustomerName", "<div>{0}</div>")%>
                            <div style="color: Silver; font-size: 85%">
                                <%# Eval("CardNumber", "Card: {0}")%>
                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Trans Info" SortExpression="TxnDate">
                        <ItemTemplate>
                            <%# Eval("TxnDate","<div>Txn Date:{0:dd/MM/yyyy}</div>") %>
                            <%# Eval("TxnAmount","<div>Txn Amount:{0}</div>")%>
                            <%# Eval("DisputeAmount","<div>Dispute Amount:<b>{0}</b></div>")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="StatusName" HeaderText="Status" SortExpression="StatusName"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="AuthStatus" HeaderText="Auth Status" SortExpression="AuthStatus"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Others Info" SortExpression="TraceNo">
                        <ItemTemplate>
                            <%# Eval("TraceNo","<div>Trace No:{0}</div>") %>
                            <%# Eval("ApprovalCode","<div>Approval Code:{0}")%>
                            <%# Eval("TerminalID","<div>Terminal ID:{0}</div>")%>
                            <%# Eval("Bank_Name","<div>Acquirer Bank:{0}</div>")%>
                            <%# Eval("NPSBCode","<div>NPSB/QDMS Code:{0}</div>")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Request Info" SortExpression="InsertBy">
                        <ItemTemplate>
                            <div title="insert info">Insert by:</div>
                            <uc3:EMP ID="EMP214" Username='<%# Eval("InsertBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                            <div style="color: Silver; font-size: 95%">
                                <%# Eval("BranchName","<div>{0}</div>")%>
                            </div>
                            <div runat="server" id="divauth" title="Auth info" visible='<%# (Eval("Authorize").ToString().ToUpper() == "FALSE"?false:true) %>'>Auth by:</div>
                            <div><%# (bool)Eval("Authorize") ? "<img src='Images/tick.png' width='24' >" : "" %></div>
                            <uc3:EMP ID="EMP22" Username='<%# Eval("AuthBY") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("AuthDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("AuthDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                            <div runat="server" id="divposting" title="Posting from branch" visible='<%# (Eval("PostingBY").ToString().ToUpper() == ""?false:true) %>'>Posting By:</div>
                            <uc3:EMP ID="EMP12429934" Username='<%# Eval("PostingBY") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("PostingDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("PostingDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                            <%# Eval("BranchName_Settlement","<div>Settlement Branch/Dept.:<b>{0}</b></div>")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Verify Info" SortExpression="AuthBY">
                        <ItemTemplate>
                            <div runat="server" id="divverify" title="Verify Info" visible='<%# (Eval("UpdateBY").ToString().ToUpper() == ""?false:true) %>'>Verify By:</div>
                            <uc3:EMP ID="EMP24757222" Username='<%# Eval("UpdateBY") %>'
                                runat="server" />
                            <span class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                            <div runat="server" id="divApprove" title="Approve Info" visible='<%# (Eval("Approve").ToString().ToUpper() == "FALSE"?false:true) %>'>Approve By:</div>
                            <div><%# (bool)Eval("Approve") ? "<img src='Images/tick.png' width='24' >" : "" %></div>
                            <uc3:EMP ID="EMP12429934" Username='<%# Eval("ApproveBY") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("ApproveDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("ApproveDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Flora Info(Dispute Posting)" SortExpression="TraceNo">
                        <ItemTemplate>
                            <%# Eval("FloraTransactionNumber","<div>Trans No:{0}</div>") %>
                            <%# Eval("FloraTranDT","<div>Trans Date:{0:dd/MM/yyyy}")%>
                            <span class="time-small" title='<%# Eval("FloraTranDT", "{0:dddd, dd MMMM yyyy}")%>'>
                                <time class="timeago" datetime='<%# Eval("FloraTranDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                            <%--<%# Eval("amount_tk","<div>Amount:<b>{0}</b>")%>
                            <%# Eval("remark","<div>Remark:{0}")%>--%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" Wrap="true" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Dispute_Search" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter Name="Filter" ControlID="txtFilter" PropertyName="Text" Type="String"
                        ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter Name="ReqBranch" ControlID="cboBranch" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter Name="Status" ControlID="cboStatus" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter ControlID="txtDateFrom" Name="FromDate" PropertyName="Text"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="txtDateTo" Name="ToDate" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter Name="AcquirerBank" ControlID="cboBanks" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" DefaultValue="*" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
            <br />
            <asp:Button ID="cmdExport" runat="server" Text="Download XLSX" Width="210px" OnClick="cmdExport_Click1"
                Height="30px" Font-Bold="true" />
            <%-- <asp:ConfirmButtonExtender ID="cmdExport_ConfirmButtonExtender" runat="server" ConfirmText="Please Save the File"
                Enabled="True" TargetControlID="cmdExport">
            </asp:ConfirmButtonExtender>--%>

            <br />
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
