<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Dispute_Print_Log_Search.aspx.cs" Inherits="Dispute_Print_Log_Search" %>

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
    Search Dispute Print Log
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <table class="Panel1 ui-corner-all">
                    <tr>
                        <td>
                            <asp:TextBox ID="txtDispute" runat="server" placeholder="dispute number" Width="100px"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txtEmp" runat="server" placeholder="emp id" Width="70px"></asp:TextBox></td>
                        <td>Print Branch:
                        </td>
                        <td>
                            <asp:DropDownList ID="dboReqBranch" runat="server" AppendDataBoundItems="true" AutoPostBack="true" DataSourceID="SqlDataSource3"
                                DataValueField="BranchID" DataTextField="BranchName" OnDataBound="dboBranchCode_DataBound">
                                <asp:ListItem Value="-1" Text="All"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="SELECT  [BranchID],[BranchName] FROM [CardData].[dbo].[v_BranchOnly]" SelectCommandType="Text"
                                EnableCaching="True" CacheDuration="60"></asp:SqlDataSource>
                        </td>
                        <td>Print Date:
                        </td>
                        <td>
                            <asp:TextBox ID="txtReqBegDate" runat="server" Width="80px" CssClass="Date"></asp:TextBox>
                        </td>
                        <td>to
                        </td>
                        <td>
                            <asp:TextBox ID="txtReqEndDate" runat="server" Width="80px" CssClass="Date"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Show" Width="80px" />

                        </td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_bank_select" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <br />
            <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="ID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True" PageSize="30"
                OnRowCommand="GridView1_RowCommand" EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:TemplateField HeaderText="#">
                        <ItemTemplate>
                            <%#Container.DataItemIndex + 1 %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dispute ID" SortExpression="DisputeID" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <b><a title="Open" target="_blank" href='<%# "Dispute.aspx?ID=" + Eval("DisputeID") %>'
                                class="HoverLink">
                                <%# Eval("DisputeID") %></a></b>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Branch Name" SortExpression="BranchName">
                        <ItemTemplate>
                            <%# Eval("BranchName","{0}") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Print By" SortExpression="PrintBY">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP214" Username='<%# Eval("PrintBY") %>' runat="server" />                          
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="DT" HeaderText="Print On" SortExpression="DT"
                                    DataFormatString="{0:dd/MM/yyyy hh:mm tt}" />
                    <asp:TemplateField HeaderText="About" SortExpression="DT">
                        <ItemTemplate>
                            <span class="time-small" title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Dispute_Print_Log_Search" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtDispute" Name="DisputeID" PropertyName="Text" DefaultValue="-1" Type="Int32" Size="20" />
                    <asp:ControlParameter ControlID="txtEmp" Name="EMPID" PropertyName="Text" DefaultValue="*" Type="String" Size="20" />
                    <asp:ControlParameter ControlID="dboReqBranch" Name="BranchID" PropertyName="SelectedValue" DefaultValue="-1" />
                    <asp:ControlParameter ControlID="txtReqBegDate" Name="DateFrom" PropertyName="Text" DefaultValue="01/01/1900" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtReqEndDate" Name="DateTo" PropertyName="Text" Type="DateTime" DefaultValue="01/01/1900" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
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