﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Card_Reissue_Batch.aspx.cs" Inherits="Card_Reissue_Batch" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="Card Reissue Batch #"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CssClass="Grid" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black"
                Style="font-size: small; font-family: Arial, Helvetica, sans-serif" AutoGenerateColumns="False"
                EnableSortingAndPagingCallbacks="True" PagerSettings-PageButtonCount="30">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CardNumber" HeaderText="Card Number" SortExpression="CardNumber" />
                    <asp:BoundField DataField="NameOnCard" HeaderText="Name On Card" SortExpression="NameOnCard" />
                    <asp:TemplateField HeaderText="Insert By" SortExpression="InsertBy" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="InsertDT" HeaderText="Insered On" SortExpression="InsertDT" />
                    <asp:TemplateField HeaderText="About" SortExpression="InsertDT">
                        <ItemTemplate>
                            <%# TrustControl1.ToRelativeDate((DateTime)Eval("InsertDT"))%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="UploadBatch" HeaderText="Upload Batch" SortExpression="UploadBatch"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Reason" SortExpression="ReasonDescription">
                        <ItemTemplate>
                            <span title='<%# Eval("Reason") %>'>
                                <%# Eval("ReasonDescription") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle BackColor="#F7F7DE" />
                <FooterStyle BackColor="#CCCC99" />
                <EmptyDataTemplate>
                    No Activation Request Found.
                </EmptyDataTemplate>
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Card_Reissue_Batch" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter Name="BatchID" QueryStringField="batch" Type="Int32" />
                    <asp:QueryStringParameter QueryStringField="branches" DefaultValue=" " Name="BranchCodes"
                        Type="String" Size="4000" />
                    <asp:QueryStringParameter Name="RequestType" QueryStringField="RequestType" Type="String"
                        Size="500" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <asp:Label ID="lblDelMsg" runat="server" Text="" Font-Bold="true" Font-Size="Larger"></asp:Label>
            <br />
            <br />
            <asp:GridView ID="GridViewDel" runat="server" AllowSorting="True" BackColor="White"
                AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CssClass="Grid" CellPadding="4" DataSourceID="SqlDataSourceDel" ForeColor="Black"
                Style="font-size: small; font-family: Arial, Helvetica, sans-serif" AutoGenerateColumns="False"
                EnableSortingAndPagingCallbacks="True" PagerSettings-PageButtonCount="30">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CardNumber" HeaderText="Card Number" SortExpression="CardNumber" />
                    <asp:BoundField DataField="NameOnCard" HeaderText="Name On Card" SortExpression="NameOnCard" />
                    <asp:TemplateField HeaderText="Insert By" SortExpression="InsertBy" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="InsertDT" HeaderText="Insered On" SortExpression="InsertDT" />
                    <asp:TemplateField HeaderText="About" SortExpression="InsertDT">
                        <ItemTemplate>
                            <%# TrustControl1.ToRelativeDate((DateTime)Eval("InsertDT"))%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="UploadBatch" HeaderText="Upload Batch" SortExpression="UploadBatch"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Reason" SortExpression="ReasonDescription">
                        <ItemTemplate>
                            <span title='<%# Eval("Reason") %>'>
                                <%# Eval("ReasonDescription") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Deleted">
                        <ItemTemplate>
                            <img height='20px' width='20px' src='Images/tick.png' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <RowStyle BackColor="#F7F7DE" />
                <FooterStyle BackColor="#CCCC99" />
                <EmptyDataTemplate>
                    No Deleted Item Found.
                </EmptyDataTemplate>
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceDel" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Card_Reissue_Batch_Del_Items" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSourceDel_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter Name="BatchID" QueryStringField="batch" Type="Int32" />
                    <asp:QueryStringParameter QueryStringField="branches" DefaultValue=" " Name="BranchCodes"
                        Type="String" Size="4000" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="lblstatusDel" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <asp:Button ID="cmdExport" runat="server" Text="Download as xlsx" Width="150px" Height="30px"
                Visible="true" Font-Bold="true" OnClick="cmdExport_Click" />
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
