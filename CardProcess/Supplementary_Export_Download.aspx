<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supplementary_Export_Download.aspx.cs" Inherits="Supplementary_Export_Download" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />

    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
        AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
        CssClass="Grid" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="Black"
        Style="font-size: small; font-family: Arial, Helvetica, sans-serif" AutoGenerateColumns="False"
        EnableSortingAndPagingCallbacks="false" PagerSettings-PageButtonCount="30">
        <Columns>
            <%--<asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" ItemStyle-HorizontalAlign="Center" />--%>
            <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account"
                ItemStyle-HorizontalAlign="Center">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>         
            <asp:BoundField DataField="SName" HeaderText="Supplementary Card Holder Name" SortExpression="SName" />
            <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" />
            <asp:BoundField DataField="RelationWithPrimaryCardholder" HeaderText="Relation" SortExpression="RelationWithPrimaryCardholder" />
            <asp:BoundField DataField="CardType" HeaderText="Card Type" SortExpression="CardType" />
            <asp:CheckBoxField DataField="SendToProcess" HeaderText="SendToProcess" SortExpression="SendToProcess" />
            <asp:BoundField DataField="SendBatch" HeaderText="Send Batch" SortExpression="SendBatch" />
            <asp:TemplateField HeaderText="Insert By" SortExpression="InsertDT">
                <ItemTemplate>
                    <uc2:EMP ID="EMP1" Username='<%# Eval("InsertBy") %>' runat="server" />
                    <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                        <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Update By" SortExpression="UpdateBY">
                <ItemTemplate>
                    <uc2:EMP ID="EMP1" Username='<%# Eval("UpdateBY") %>' runat="server" />
                    <span class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                        <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Send By" SortExpression="SendBy">
                <ItemTemplate>
                    <uc2:EMP ID="EMP1" Username='<%# Eval("SendBy") %>' runat="server" />
                    <span class="time-small" title='<%# Eval("SendDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                        <time class="timeago" datetime='<%# Eval("SendDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle BackColor="#F7F7DE" />
        <FooterStyle BackColor="#CCCC99" />
        <EmptyDataTemplate>
            No  Record Found.
        </EmptyDataTemplate>
        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
        <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />
        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="s_Supplementary_Browse" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource3_Selected">
        <SelectParameters>
            <asp:QueryStringParameter Name="Batch" QueryStringField="batch" Type="Int32" DefaultValue="-1" />
            <asp:QueryStringParameter Name="BranchID" QueryStringField="branch" Type="Int32" DefaultValue="-1" />
            <asp:QueryStringParameter Name="cardtype" QueryStringField="CardType" Type="String" DefaultValue="*" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
    <br />
    <%--<asp:SqlDataSource ID="SqlDataSourceReExport" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="sp_ExportToITCL_Offline_CSV" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="branches" Name="BranchCodes" Type="String"
                DefaultValue="*" />
            <asp:QueryStringParameter QueryStringField="batch" Name="BatchID" Type="Int32" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
   <%-- <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="sp_ExportToITCL_Offline_xlsx" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="branches" Name="BranchCodes" Type="String"
                DefaultValue="*" />
            <asp:QueryStringParameter QueryStringField="batch" Name="BatchID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>--%>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="s_Supplementary_card_issue_fee" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="batch" Name="Batchno" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
