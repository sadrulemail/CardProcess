<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Acc_Types.aspx.cs" Inherits="Acc_Types" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Account Types
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <asp:Button ID="cmdNew" runat="server" Text="Add New Account Type" Width="180px"
                OnClick="cmdNew_Click" />
            <asp:DetailsView ID="DetailsView1" runat="server" CssClass="Grid"
                AutoGenerateRows="False" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                DataKeyNames="accountType" DataSourceID="SqlDataSource2" ForeColor="Black"
                GridLines="Vertical" Style="font-size: small">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <Fields>
                    <asp:BoundField DataField="accountType" HeaderText="Account Type Code"
                        ReadOnly="True" SortExpression="accountType" />
                    <asp:CheckBoxField DataField="allowcreation" HeaderText="Allow Creation"
                        SortExpression="allowcreation" />
                    <asp:CommandField ShowInsertButton="true" ButtonType="Button"
                        ShowEditButton="True" ControlStyle-Width="80px" />
                </Fields>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                InsertCommand="s_AccountTypes_insert" InsertCommandType="StoredProcedure"
                SelectCommand="s_AccountTypes_Select" SelectCommandType="StoredProcedure" UpdateCommand="s_AccountTypes_Update" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSource2_Inserted"
                OnUpdated="SqlDataSource2_Updated">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="accountType"
                        PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="accountType" />
                    <asp:Parameter Name="allowcreation" />
                    <asp:SessionParameter Name="UpdateBy" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="accountType" />
                    <asp:Parameter Name="allowcreation" />
                    <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                    <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="4" DataKeyNames="AccountType" DataSourceID="SqlDataSource1"
                ForeColor="Black" GridLines="Vertical" Style="font-size: small"
                AllowSorting="True"
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" ButtonType="Link" ItemStyle-Font-Bold="true" ItemStyle-ForeColor="Blue" />
                    <asp:BoundField DataField="AccountType" HeaderText="Type Code"
                        ReadOnly="True" SortExpression="AccountType" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                    <asp:BoundField DataField="glhead" HeaderText="Account Type"
                        SortExpression="glhead" />
                    <asp:CheckBoxField DataField="AllowCreation" HeaderText="Allow"
                        ItemStyle-HorizontalAlign="Center"
                        SortExpression="AllowCreation"></asp:CheckBoxField>
                    <asp:TemplateField HeaderText="Insert By" ShowHeader="true" InsertVisible="false">
                        <ItemTemplate>
                            <uc2:EMP ID="EMPCreatedBy" runat="server" Username='<%# Eval("InsertBy") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Insert On" ShowHeader="true" InsertVisible="false">
                        <ItemTemplate>
                            <div title='<%# Eval("InsertDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("InsertDT"))%>
                                <time class="timeago time-small-gray" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Update By" ShowHeader="true" InsertVisible="false">
                        <ItemTemplate>
                            <uc2:EMP ID="EMPUpdateBy" runat="server" Username='<%# Eval("Updateby") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Update On" ShowHeader="true" InsertVisible="false">
                        <ItemTemplate>
                            <div title='<%# Eval("UpdateDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("UpdateDT"))%>
                                <time class="timeago time-small-gray" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:Label ID="lblMsg" Text="" runat="server" Visible="false"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM [v_AccountTypes]" OnSelected="SqlDataSource1_Selected"></asp:SqlDataSource>
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
