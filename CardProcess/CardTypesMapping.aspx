<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CardTypesMapping.aspx.cs" Inherits="CardTypesMapping" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Account & Card Types Mapping
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <asp:Button ID="cmdNew" runat="server" Text="Add New Card Type Mapping" Width="180px"
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
                    <asp:TemplateField HeaderText="SL" InsertVisible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblSL" runat="server" Text='<%# Bind("SL") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Account Types">
                        <ItemTemplate>
                            <%# Eval("glhead") %>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="cboAccountTypes" runat="server" SelectedValue='<%# Bind("AccountType") %>'
                                DataSourceID="SqlDataSourceAccountTypes" DataTextField="glhead" DataValueField="AccountTypes"
                                AppendDataBoundItems="true">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator53245" runat="server" ControlToValidate="cboAccountTypes"
                                ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSourceAccountTypes" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="SELECT  AccountType as AccountTypes ,glhead FROM dbo.v_AccountTypes WHERE AllowCreation=1 ORDER BY glhead"></asp:SqlDataSource>
                        </InsertItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="cboAccountTypes" runat="server" SelectedValue='<%# Bind("AccountType") %>'
                                DataSourceID="SqlDataSourceAccountTypes" DataTextField="glhead" DataValueField="AccountTypes"
                                AppendDataBoundItems="true">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator55" runat="server" ControlToValidate="cboAccountTypes"
                                ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSourceAccountTypes" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="SELECT  AccountType as AccountTypes ,glhead FROM dbo.v_AccountTypes WHERE AllowCreation=1 ORDER BY glhead"></asp:SqlDataSource>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Card Types">
                        <ItemTemplate>
                            <%# Eval("CardTypeName") %>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="cboCardTypes" runat="server" SelectedValue='<%# Bind("CardType") %>'
                                DataSourceID="SqlDataSourceCardTypes" DataTextField="CardType" DataValueField="CardTypeCode"
                                AppendDataBoundItems="true">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator576" runat="server" ControlToValidate="cboCardTypes"
                                ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="cboCardTypes" runat="server" SelectedValue='<%# Bind("CardType") %>'
                                DataSourceID="SqlDataSourceCardTypes" DataTextField="CardType" DataValueField="CardTypeCode"
                                AppendDataBoundItems="true">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator57126" runat="server" ControlToValidate="cboCardTypes"
                                ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowInsertButton="true" ButtonType="Button"
                        ShowEditButton="True" ControlStyle-Width="80px" />
                </Fields>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                InsertCommand="s_CardTypesMapping_insert" InsertCommandType="StoredProcedure"
                SelectCommand="s_CardTypesMapping_Select" SelectCommandType="StoredProcedure" UpdateCommand="s_CardTypesMapping_Update" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSource2_Inserted"
                OnUpdated="SqlDataSource2_Updated">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="SL"
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SL" />
                    <asp:Parameter Name="AccountType" />
                    <%--<asp:ControlParameter ControlID="ctl00$ContentPlaceHolder2$DetailsView1$cboAccountTypes" Name="AccountType" PropertyName="SelectedValue" />--%>
                    <asp:Parameter Name="CardType" />
                    <asp:SessionParameter Name="UpdateBy" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="SL" />
                    <asp:Parameter Name="AccountType" />
                    <asp:Parameter Name="CardType" />
                    <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                    <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>


            <asp:SqlDataSource ID="SqlDataSourceCardTypes" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT  CardTypeCode , CardType FROM dbo.CardTypes ORDER BY CardType"></asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="4" DataKeyNames="SL" DataSourceID="SqlDataSource1"
                ForeColor="Black" GridLines="Vertical" Style="font-size: small"
                AllowSorting="True"
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <%--<asp:CommandField ShowDeleteButton="True" ButtonType="Link" ItemStyle-Font-Bold="true" ItemStyle-ForeColor="Blue"  />--%>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton runat="server"
                                ID="lnkDelete"
                                CommandArgument='<%# Eval("SL") %>'
                                CommandName="Delete"><img src="Images/cross.png" /></asp:LinkButton>
                            <asp:ConfirmButtonExtender runat="server" ID="con1"
                                TargetControlID="lnkDelete" ConfirmText="Do you want to Delete?" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="SL" DataField="SL" SortExpression="SL" />
                    <asp:BoundField DataField="AccountType" HeaderText="Account Type Code"
                        ReadOnly="True" SortExpression="AccountType" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                    <asp:BoundField DataField="glhead" HeaderText="Account Type"
                        SortExpression="glhead" />
                    <asp:BoundField DataField="CardType" HeaderText="Card Type Code"
                        SortExpression="CardType" />
                    <asp:BoundField DataField="CardTypeName" HeaderText="Card Type"
                        SortExpression="CardTypeName" />

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
                SelectCommand="SELECT * FROM [v_CardTypesMapping] order by SL" OnSelected="SqlDataSource1_Selected"
                DeleteCommand="s_CardTypesMapping_Delete" DeleteCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="SL"
                        PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <div class="group">
                <h4>Missing Card Types Mapping</h4>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                    BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataKeyNames="CardTypeCode" DataSourceID="SqlDataSource3"
                    ForeColor="Black" GridLines="Vertical" Style="font-size: small"
                    AllowSorting="True">
                    <FooterStyle BackColor="#CCCC99" />
                    <RowStyle BackColor="#F7F7DE" />
                    <Columns>
                        <asp:BoundField HeaderText="Card Type Code" DataField="CardTypeCode" SortExpression="CardTypeCode" />
                        <asp:BoundField DataField="CardType" HeaderText="Card Type"
                            ReadOnly="True" SortExpression="CardType" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="true" />
                    </Columns>
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:Label ID="Label1" Text="" runat="server" Visible="false"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                    ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_CardTypesMapping_Missing" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource3_Selected"></asp:SqlDataSource>
            </div>
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
