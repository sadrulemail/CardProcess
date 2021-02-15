<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PIN_Export.aspx.cs" Inherits="PIN_Export" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    PIN Export to ITCL
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
                        <asp:GridView ID="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                            BackColor="White" BorderColor="#6B696B" BorderStyle="Solid" BorderWidth="5px"
                            CellPadding="1" DataSourceID="SqlDataSource3" ForeColor="Black" CssClass="Grid"
                            ShowFooter="true" GridLines="Vertical" Style="font-size: small"
                            OnDataBound="GridView2_DataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="Req Branch ID" SortExpression="BranchID">
                                    <ItemTemplate>
                                        <%# Eval("BranchID")%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Req Branch Name" SortExpression="BranchName">
                                    <ItemTemplate>
                                        <a href='PIN_Reissue_Branch.aspx?branch=<%# Eval("BranchID") %>' title="View" target="_blank">
                                            <%# Eval("BranchName")%></span></a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Ready to Send" HeaderText="Ready to Send" SortExpression="Ready to Send"
                                    ItemStyle-HorizontalAlign="Center" ReadOnly="True">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="%" SortExpression="Ready To Send">
                                    <ItemTemplate>
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle BackColor="#F7F7DE" />
                            <FooterStyle BackColor="#BBDBF8" Font-Bold="true" HorizontalAlign="Center" Font-Size="XX-Large" />
                            <EmptyDataTemplate>
                                No Pin Request Found.
                            </EmptyDataTemplate>
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_Pin_Reissue_Ready" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource3_Selected"></asp:SqlDataSource>
                        <br />
                        <asp:Button ID="cmdExport" runat="server" Text="Export Pin Reissue List" Width="210px"
                            OnClick="cmdExport_Click1" Height="30px" Font-Bold="true" />
                        <asp:ConfirmButtonExtender ID="cmdExport_ConfirmButtonExtender" runat="server" ConfirmText="Please Save the File"
                            Enabled="True" TargetControlID="cmdExport"></asp:ConfirmButtonExtender>
                        <br />
                        <br />
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tabNewExport">
                    <HeaderTemplate>
                        Export To ITCL
                    </HeaderTemplate>
                    <ContentTemplate>
                        <table class="Panel1 ui-corner-all">
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtaccountno1" runat="server" placeholder="account no." MaxLength="20" Width="120px" CssClass="left"></asp:TextBox>
                                </td>                                
                                <td><b>Delivery Branch: </b></td>
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
                                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
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
                                        <a href='New_Reissue_Request.aspx?ID=<%# Eval("ID") %>' target="_blank" class="Link">
                                            <%# Eval("ID") %></a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="NameOnCard" HeaderText="NameOnCard" SortExpression="NameOnCard" />
                                <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account" />
                                
                                <asp:BoundField DataField="BranchName" HeaderText="Delivery Branch Name" SortExpression="BranchName"
                                    ItemStyle-HorizontalAlign="Left" />
                                <asp:TemplateField HeaderText="InsertBy" SortExpression="InsertBy" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                                        <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
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
                        <asp:Label ID="lblmsg1" runat="server" Visible="true"></asp:Label>
                        <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_Issue_PIN_Ready_To_Export" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource6_Selected">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtaccountno1" Name="AccountNo" Type="String" DefaultValue="*" />                                
                                <asp:ControlParameter ControlID="cboBranch" Name="ReqBranch" Type="String" DefaultValue="-1" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                    </ContentTemplate>
                </asp:TabPanel>

                <asp:TabPanel runat="server" ID="tab2">
                    <HeaderTemplate>
                        PIN Export History
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
                           OnRowCommand="GridView1_RowCommand" BorderWidth="1px" CellPadding="5" DataKeyNames="SL" DataSourceID="SqlDataSource2"
                            Style="font-size: small" GridLines="Both" PageSize="10" PagerSettings-Position="TopAndBottom"
                            PagerSettings-PageButtonCount="20">
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" BorderColor="#478ACA" BorderStyle="Dotted"
                                BorderWidth="1px" HorizontalAlign="Center" />
                            <PagerStyle BackColor="#478ACA" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="#F7F7F7" BorderStyle="Solid" BorderWidth="1px" BorderColor="#478ACA" />
                            <Columns>
                                <asp:BoundField DataField="SL" HeaderText="SL" InsertVisible="False" ReadOnly="True"
                                    SortExpression="SL" ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>

                                <asp:TemplateField HeaderText="Sent By" SortExpression="[Send By]">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP55" Username='<%# Eval("SendBy") %>' runat="server" />
                                        <br />
                                        <span class="time-small" title='<%# Eval("SendDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("SendDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" ItemStyle-HorizontalAlign="Right">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download">
                                    <ItemTemplate>
                                        <a href='<%# "Pin_Export.aspx?type=xlsx&batch=" + Eval("SL") %>' target="Pin_Export"
                                            class="Link">XLSX</a> | <a href='<%# "Pin_Export.aspx?type=dbf&batch=" + Eval("SL") %>'
                                                target="Pin_Export" class="Link">DBF</a>| <a href='<%# "PIN_Reissue_Batch.aspx?batch=" + Eval("SL") %>'
                                                    target="_blank" class="Link">View</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download Mailer">
                                    <ItemTemplate>
                                        <div class='<%# Eval("FinalizeProcess").ToString().ToUpper() == "TRUE" ? "" : "hidden" %>'>
                                            <a href='<%# "PINForwarding.aspx?batch=" + Eval("SL") %>' target="_blank" class="Link">Download</a>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="BtnUpdate" Visible='<%# Eval("FinalizeProcess").ToString().ToUpper() == "FALSE" ? true : false %>'
                                            runat="server" CommandName="Update" ToolTip="Update">Receive from ITCL
                                        </asp:LinkButton>
                                        <asp:ConfirmButtonExtender runat="server" ID="BtnUpdateff" ConfirmText="Do you want to Finalize?"
                                            TargetControlID="BtnUpdate"></asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transfer">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="TransferBtn" CommandArgument='<%# Eval("SL") %>' Visible='<%# ( Eval("TRANSFER").ToString() == "False"  ? true : false) %>'
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
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_PIN_Reissue_Log" SelectCommandType="StoredProcedure" UpdateCommand="s_PIN_Reissue_Finalize"
                            UpdateCommandType="StoredProcedure" OnUpdated="SqlDataSource2_Updated" OnSelected="SqlDataSource2_Selected">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextBox1" Name="DateFrom" DefaultValue="01/01/1900"
                                    PropertyName="Text" Type="DateTime" />
                                <asp:ControlParameter ControlID="TextBox2" Name="DateTo" PropertyName="Text" DefaultValue="01/01/1900"
                                    Type="DateTime" />
                                <asp:Parameter Name="Total" Direction="InputOutput" DefaultValue="0" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="SL" />
                                <asp:SessionParameter Name="EmpID" SessionField="EMPID" Type="String" />
                                <asp:Parameter Name="Msg" Direction="InputOutput" Size="250" DefaultValue="" />
                                <asp:Parameter Name="Done" Direction="InputOutput" DefaultValue="0" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:Label runat="server" ID="lblTotalPin" Text="" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tab3">
                    <HeaderTemplate>
                        Delete
                    </HeaderTemplate>
                    <ContentTemplate>
                        <div class="group" style="width: 90%">
                            <h4>Pin Reissue Delete
                            </h4>
                            <table class="Panel1 ui-corner-all">
                                <tr>
                                    <td>
                                        <b>Account No: </b>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAccountNo" runat="server" MaxLength="15" Width="170px" CssClass="Center"
                                            Font-Size="Large"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button ID="cmdOpen" runat="server" Text="Search" Width="80px" OnClick="cmdOpen_Click" />
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <asp:GridView ID="GridView3" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                                AutoGenerateColumns="False" BackColor="White" BorderColor="#478ACA" BorderStyle="Solid"
                                BorderWidth="1px" CellPadding="5" DataKeyNames="ServiceRequestID" DataSourceID="SqlDataSource1"
                                Style="font-size: small" GridLines="Both" PageSize="10" PagerSettings-Position="TopAndBottom"
                                PagerSettings-PageButtonCount="20">
                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" BorderColor="#478ACA" BorderStyle="Dotted"
                                    BorderWidth="1px" HorizontalAlign="Center" />
                                <PagerStyle BackColor="#478ACA" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="#F7F7F7" BorderStyle="Solid" BorderWidth="1px" BorderColor="#478ACA" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Request ID" SortExpression="ServiceRequestID">
                                        <ItemTemplate>
                                            <a href='New_Reissue_Request.aspx?id=<%# Eval("ServiceRequestID") %>' title="View Request"
                                                target="_blank">
                                                <%# Eval("ServiceRequestID")%></a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account" />
                                    <asp:BoundField DataField="CardNumber" HeaderText="Card Number" SortExpression="CardNumber" />
                                    <asp:BoundField DataField="NameOnCard" HeaderText="Name On Card" SortExpression="NameOnCard" />
                                    <asp:TemplateField HeaderText="Deleted By" SortExpression="DeletedBy" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("DeletedBy") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Deleted on" SortExpression="DeletedDT">
                                        <ItemTemplate>
                                            <span title='<%# Eval("DeletedDT","{0:dddd, \ndd MMMM yyyy, \nhh:mm:ss tt}") %>'>
                                                <%# TrustControl1.ToRecentDateTime(Eval("DeletedDT"))%></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="SendBatchID" HeaderText="Send Batch ID" InsertVisible="False"
                                        ReadOnly="True" SortExpression="SendBatchID" ItemStyle-HorizontalAlign="Center">
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Sent on" SortExpression="SendDT">
                                        <ItemTemplate>
                                            <span title='<%# Eval("SendDT","{0:dddd, \ndd MMMM yyyy, \nhh:mm:ss tt}") %>'>
                                                <%# TrustControl1.ToRecentDateTime(Eval("SendDT"))%></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="About" SortExpression="SendDT">
                                        <ItemTemplate>
                                            <%# TrustControl1.ToRelativeDate(Eval("SendDT"))%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sent By" SortExpression="SendBy" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("SendBy") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="DeleteBtn" Visible='<%# Eval("SendDT", "{0:dd/MM/yyyy}").ToString() == Eval("CurrentDate", "{0:dd/MM/yyyy}").ToString() &  Eval("FinalizeProcess").ToString() == "False" ? true : false %>'
                                                runat="server" CommandName="Delete" ToolTip="Delete"><img src="Images/cross.png" />
                                            </asp:LinkButton>
                                            <asp:ConfirmButtonExtender runat="server" ID="DeleteID" ConfirmText="Do you want to Delete?"
                                                TargetControlID="DeleteBtn"></asp:ConfirmButtonExtender>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    No Record Found.
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="s_PIN_Reissue_Browse" SelectCommandType="StoredProcedure" DeleteCommand="s_PIN_Reissue_Delete"
                                DeleteCommandType="StoredProcedure" OnDeleted="SqlDataSource1_Deleted">
                                <SelectParameters>
                                    <asp:ControlParameter Name="Account" ControlID="txtAccountNo" PropertyName="Text" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <%--<asp:ControlParameter Name="ReqID" Type="String" ControlID="GridView3" PropertyName="SelectedValue" />--%>
                                    <asp:Parameter Name="ServiceRequestID" />
                                    <asp:SessionParameter Name="EmpID" SessionField="EMPID" Type="String" />
                                    <asp:Parameter Name="Msg" Direction="InputOutput" Size="250" DefaultValue="" />
                                    <asp:Parameter Name="Done" Direction="InputOutput" DefaultValue="0" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                        </div>
                    </ContentTemplate>
                </asp:TabPanel>
            </asp:TabContainer>
            <asp:SqlDataSource ID="SqlDataSourceReExportPin" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Pin_Reissue_download" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="BatchID" QueryStringField="batch" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceReExport" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Pin_Reissue_Export" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceReExport_Selected">
                <SelectParameters>
                    <asp:SessionParameter Name="EmpID" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="BatchNo" DefaultValue="0" Direction="InputOutput" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
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