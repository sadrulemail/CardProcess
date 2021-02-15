<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DiputePostingPending.aspx.cs" Inherits="DiputePostingPending" %>


<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Dispute Posting Pending
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="Panel1">
                <table>
                    <tr>                       
                        <td>Feeding Branch(ATM):
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
                        <td>Approve Date:
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
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                AllowPaging="True" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30"
                PagerSettings-Position="TopAndBottom" CssClass="Grid" BorderColor="#DEDFDE" BorderStyle="Solid"
                BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" 
                AllowSorting="True" Font-Size="Small" >
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" HorizontalAlign="Center" />
                <Columns>
                    <asp:TemplateField HeaderText="#">
                        <ItemTemplate>
                            <%#Container.DataItemIndex + 1 %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Branch Name" SortExpression="BranchName">
                        <ItemTemplate>
                            <%# Eval("BranchName") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total" SortExpression="Total">
                        <ItemTemplate>
                            <%# Eval("Total","<b>{0}</b>") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding: 15px 50px">
                        No record found.
                    </div>
                </EmptyDataTemplate>
                <FooterStyle BackColor="#CCCC99" HorizontalAlign="Center" Font-Bold="true" />
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="30" Position="TopAndBottom" />
                <PagerStyle HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <br />
            <asp:Label runat="server" ID="lblStatus" Text=""></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Dispute_Posting_Pending_Summary" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="dboReqBranch" Name="FeedingBranch" PropertyName="SelectedValue" DefaultValue="-1" />
                    <asp:ControlParameter ControlID="txtReqBegDate" Name="DateFrom" PropertyName="Text" DefaultValue="01/01/1900" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtReqEndDate" Name="DateTo" PropertyName="Text" Type="DateTime" DefaultValue="01/01/1900" />
                </SelectParameters>
            </asp:SqlDataSource>
           
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DynamicLayout="false" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="10">
        <ProgressTemplate>
            <div class="TransparentGrayBackground">
            </div>
            <asp:Image ID="Image1" runat="server" alt="" ImageUrl="~/Images/processing.gif" CssClass="LoadingImage"
                Width="214" Height="138" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:AlwaysVisibleControlExtender ID="UpdateProgress1_AlwaysVisibleControlExtender"
        runat="server" Enabled="True" HorizontalSide="Center" TargetControlID="Image1"
        UseAnimation="false" VerticalSide="Middle"></asp:AlwaysVisibleControlExtender>
</asp:Content>
