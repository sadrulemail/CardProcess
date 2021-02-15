<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Card_Activation_Search.aspx.cs" Inherits="Card_Activation_Search" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Search Card Activation Request
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table class="Panel1 ui-corner-all" cellpadding="4">
                <tr>
                    <td style="font-size: small; font-weight: bold">
                        Card Number:
                    </td>
                    <td>
                        <asp:TextBox ID="txtCardNumner" Text="" runat="server" Width="250px" TabIndex="0"
                            Font-Size="Large" MaxLength="20" onfocus="this.select()" AutoPostBack="True"
                            OnTextChanged="txtCardNumner_TextChanged"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="cmdSearch" runat="server" Text="Search" Width="80px" Height="25px"
                            Font-Bold="true" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                CssClass="Grid" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                DataKeyNames="CardNumber" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical"
                Style="font-size: small" AllowPaging="True" AllowSorting="True">
                <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                <Columns>
                    <asp:BoundField DataField="CardNumber" HeaderText="Card Number" ReadOnly="True" SortExpression="CardNumber"
                        HtmlEncode="false" />
                    <asp:TemplateField HeaderText="Requested By" SortExpression="EmpID" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("EmpID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="Requested Branch" SortExpression="BranchName">
                        <ItemTemplate>
                            <span title='<%# Eval("BranchID") %>'><%# Eval("BranchName")%></span>
                        </ItemTemplate>
                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Requested" SortExpression="DT">
                        <ItemTemplate>
                            <span title='<%# Eval("DT","{0:dddd, \ndd MMMM yyyy, \nhh:mm:ss tt}") %>'><%# TrustControl1.ToRecentDateTime(Eval("DT"))%></span>
                        </ItemTemplate>
                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="About" SortExpression="DT" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%# TrustControl1.ToRelativeDate(Eval("DT"))%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="BatchNo" HeaderText="Batch No" SortExpression="BatchNo" />
                    <asp:TemplateField HeaderText="Sent On" SortExpression="Sent On">
                        <ItemTemplate>
                            <span title='<%# Eval("Sent On","{0:dddd, \ndd MMMM yyyy, \nhh:mm:ss tt}") %>'><%# TrustControl1.ToRecentDateTime(Eval("Sent On"))%></span>
                        </ItemTemplate>
                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="About" SortExpression="Sent On" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%# TrustControl1.ToRelativeDate(Eval("Sent On"))%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sent By" SortExpression="Sent By" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("Sent By") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <EmptyDataTemplate>
                    No Card Activation Request Found.
                </EmptyDataTemplate>
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Card_Activation_Browse" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCardNumner" PropertyName="Text" Name="CardNumber"
                        Type="String" DefaultValue="" ConvertEmptyStringToNull="true" Size="20" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
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