<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Data_Export_Activation.aspx.cs" Inherits="Data_Export_Activation" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Card Activation Data Export to ITCL
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
                            ShowFooter="true" GridLines="Vertical" Style="font-size: small" Width="600px"
                            OnDataBound="GridView2_DataBound">
                            <Columns>
                                <asp:BoundField DataField="BranchID" SortExpression="BranchID" HeaderText="Branch ID"
                                    ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderText="Branch Name" SortExpression="BranchName">
                                    <ItemTemplate>
                                        <a href='Activation_Ready.aspx?branch=<%# Eval("BranchID") %>' target="_blank" class="Link">
                                            <span style="color: blue">
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
                                No Card Activation Request Found.
                            </EmptyDataTemplate>
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="sp_Card_Activation_Ready_To_Send" SelectCommandType="StoredProcedure"
                            OnSelected="SqlDataSource3_Selected"></asp:SqlDataSource>
                        <br />
                        <asp:Button ID="cmdExport" runat="server" Text="Export Card Activation List" Width="210px"
                            OnClick="cmdExport_Click1" Height="30px" Font-Bold="true" />
                        <asp:ConfirmButtonExtender ID="cmdExport_ConfirmButtonExtender" runat="server" ConfirmText="Please Save the File"
                            Enabled="True" TargetControlID="cmdExport"></asp:ConfirmButtonExtender>
                        <br />
                        <br />
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
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
                            Style="font-size: small" GridLines="Both" PageSize="10" Width="600px" PagerSettings-Position="TopAndBottom"
                            PagerSettings-PageButtonCount="20">
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" BorderColor="#478ACA" BorderStyle="Dotted"
                                BorderWidth="1px" HorizontalAlign="Center" />
                            <PagerStyle BackColor="#478ACA" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="#F7F7F7" BorderStyle="Solid" BorderWidth="1px" BorderColor="#478ACA" />
                            <Columns>
                                <asp:BoundField DataField="SL" HeaderText="Batch_No" InsertVisible="False" ReadOnly="True"
                                    SortExpression="SL" ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Sent on" SortExpression="Sent On">
                                    <ItemTemplate>
                                        <span title='<%# Eval("Sent On","{0:dddd, \ndd MMMM yyyy, \nhh:mm:ss tt}") %>'>
                                            <%# TrustControl1.ToRecentDateTime(Eval("Sent On")) %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="About" SortExpression="Sent On">
                                    <ItemTemplate>
                                        <%# TrustControl1.ToRelativeDate(Eval("Sent On")) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sent By" SortExpression="Sent By" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("Sent By") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" ItemStyle-HorizontalAlign="Right">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download">
                                    <ItemTemplate>
                                        <a href='<%# "Data_Export_Activation.aspx?type=xlsx&batch=" + Eval("SL") %>' class="Link">XLSX</a> | <a href='<%# "Data_Export_Activation.aspx?type=dbf&batch=" + Eval("SL") %>'
                                            class="Link">DBF</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_Activation_SentLog" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource2_Selected">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextBox1" Name="DateFrom" DefaultValue="01/01/1900"
                                    PropertyName="Text" Type="DateTime" />
                                <asp:ControlParameter ControlID="TextBox2" Name="DateTo" PropertyName="Text" DefaultValue="01/01/1900"
                                    Type="DateTime" />
                                <asp:Parameter Name="Total" Direction="InputOutput" DefaultValue="0" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Label runat="server" ID="lblTotalActivation" Text="" Visible="false"></asp:Label>
                    </ContentTemplate>
                </asp:TabPanel>
            </asp:TabContainer>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Export_Activation" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter SessionField="EMPID" Name="EmpID" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceReExport" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Export_Activation_Offline" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="BatchID" QueryStringField="batch" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceReExportActivation" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Export_Activation" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceReExportActivation_Selected">
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
