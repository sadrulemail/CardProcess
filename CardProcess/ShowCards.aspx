<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReconciliationFile_Upload.aspx.cs" Inherits="ReconciliationFile_Upload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ShowCards.aspx.cs" Inherits="ShowCards" %>

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
    Card Issue
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                AllowSorting="true" AllowPaging="true" PagerSettings-Position="TopAndBottom" CssClass="Grid"
                PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="20" PageSize="50"
                BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="ID"
                DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical" Style="font-size: small; font-family: Arial, Helvetica, sans-serif">
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
                    <asp:BoundField DataField="InsertDT" HeaderText="InsertDT" SortExpression="InsertDT" ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="InsertDT" SortExpression="InsertDT" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%# TrustControl1.ToRelativeDate((DateTime)Eval("InsertDT"))%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ReqBranch" HeaderText="ReqBranch" SortExpression="ReqBranch"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="InsertBy" SortExpression="InsertBy" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DeliveryToBranch" HeaderText="DeliveryToBranch" ItemStyle-HorizontalAlign="Center"
                        SortExpression="DeliveryToBranch" />
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM [CardProcess] WHERE SendToProcess = 0 AND CardType = @CardType AND DeliveryToBranch = @Branch"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter Name="CardType" QueryStringField="cardtype" />
                    <asp:QueryStringParameter Name="Branch" QueryStringField="branch" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label Font-Names="Arial" runat="server" ID="lblStatus" Text="" Font-Size="Small"></asp:Label>
            <br />
            <br />
            <%--<asp:Button ID="cmdExport" runat="server" Enabled="False" OnClick="cmdExport_Click"
                Text="Export to ITCL" Width="130px" />--%>
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
