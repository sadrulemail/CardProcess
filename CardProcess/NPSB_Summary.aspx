<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NPSB_Summary.aspx.cs" Inherits="NPSB_Summary" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NPSB_Summary.aspx.cs" Inherits="NPSB_Summary" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="NPSB Summary"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server">
                <table class="Panel1 ui-corner-all" style="display: inline-block">

                    <tr>
                        <td>Issue Date:                        
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                            to                        
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>

                            <asp:Button ID="cmdFilter" runat="server" Font-Bold="true" Text="Show" Width="80px"
                                OnClick="cmdFilter_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" CssClass="Grid"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" AllowPaging="True"
                AllowSorting="True" PageSize="20" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30"
                PagerSettings-Position="TopAndBottom">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="LocalDate" HeaderText="Local Date" SortExpression="LocalDate"
                        ReadOnly="True" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy}">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" ReadOnly="True"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Transaction Amount" SortExpression="Trans_Amount">
                        <ItemTemplate>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Trans_Amount")) %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bill Amount" SortExpression="Bill_Amount">
                        <ItemTemplate>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Bill_Amount"))%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reconcilation Amount" SortExpression="Recon_Amount">
                        <ItemTemplate>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Recon_Amount"))%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" ShowHeader="false">
                        <ItemTemplate>
                            <a href='NPSBView.aspx?date=<%# Eval("LocalDate","{0:dd/MM/yyyy}") %>' target="_blank"
                                class="Link">
                                <img src="Images/open.png" border="0" width="16" height="16" /></a>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="30" Position="TopAndBottom" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_NPSB_Summary" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected1">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtFromDate" Name="DateFrom" PropertyName="Text"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="txtToDate" Name="DateTo" PropertyName="Text" Type="DateTime" />

                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
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
