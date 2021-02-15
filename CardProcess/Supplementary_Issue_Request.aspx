﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supplementary_Issue_Request.aspx.cs" Inherits="Supplementary_Issue_Request" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="Supplementary Card Service Request"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hidReqAccount" runat="server" Value="" />
            <asp:HiddenField ID="hidReqID" runat="server" Value="0" />
            <asp:Panel ID="Panel1" runat="server">
                <table class="Panel1 ui-corner-all">
                    <tr>
                        <td>
                            <b>Account Number: </b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFilter" runat="server" Width="150px" TabIndex="0"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="cmdOK" runat="server" Text="Search" Width="80px" OnClick="cmdOK_Click"
                                CausesValidation="false" />
                        </td>
                    </tr>
                </table>
                <br />
            </asp:Panel>
            <asp:Panel ID="Panel22" runat="server" Visible="false">
                <asp:Label runat="server" ID="lblprimaryID" Text="Primary Card Info" Font-Size="Medium" Font-Bold="true"></asp:Label>
                <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                    BorderStyle="Solid" BorderWidth="1px" CellPadding="6" ForeColor="Black" Style="font-size: small"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True" CssClass="Grid">
                    <FooterStyle BackColor="#CCCC99" />
                    <RowStyle BackColor="#F7F7DE" />
                    <Columns>
                        <asp:TemplateField HeaderText="SL">
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Account" HeaderText="Account" ReadOnly="True" SortExpression="Account"
                            ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="CardNumber" HeaderText="Card Number" ReadOnly="True" SortExpression="CardNumber"
                            ItemStyle-CssClass="bold" />
                        <asp:BoundField DataField="NAME ON CARD" HeaderText="Name on Card" ReadOnly="True"
                            SortExpression="NAME ON CARD" ItemStyle-CssClass="bold" />
                        <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status"
                            ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bold" />
                        <asp:TemplateField HeaderText="Created" SortExpression="CREATED" ItemStyle-Wrap="false"
                            ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <div title='<%# TrustControl1.ToDateTimeTitle(Eval("CREATED")) %>'>
                                    <%# TrustControl1.ToRecentDate(Eval("CREATED"))%>
                                    <div class='time-small'>
                                        <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("CREATED")) %>'></time>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="DeliveryDT" HeaderText="Delivery DT" ReadOnly="True" SortExpression="DeliveryDT" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Date of Birth" HeaderText="Date of Birth" ReadOnly="True"
                            SortExpression="Date of Birth" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Address" HeaderText="Address" ReadOnly="True" SortExpression="Address"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="Mobile" HeaderText="Mobile" ReadOnly="True" SortExpression="Mobile"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="ITCLID" HeaderText="ITCLID" ReadOnly="True" SortExpression="ITCLID"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="CardType" HeaderText="Card Type" ReadOnly="True" SortExpression="CardType"
                            ItemStyle-HorizontalAlign="left" />
                    </Columns>
                    <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" PageButtonCount="30" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <EmptyDataTemplate>
                        No primary card found.
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_Search_Primary_All_Card_For_Supplementary_Issue" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Filter" QueryStringField="acc" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <asp:Label runat="server" ID="lblSupplementary" Text="Supplementary Card Info" Font-Size="Medium" Font-Bold="true"></asp:Label>
                <asp:GridView ID="GridView2" runat="server" BackColor="White" BorderColor="#DEDFDE"
                    BorderStyle="Solid" BorderWidth="1px" CellPadding="6" ForeColor="Black" Style="font-size: small"
                    AutoGenerateColumns="False" DataSourceID="SqlDataSource2" AllowSorting="True"
                    CssClass="Grid">
                    <FooterStyle BackColor="#CCCC99" />
                    <RowStyle BackColor="#F7F7DE" />
                    <Columns>
                        <asp:TemplateField HeaderText="SL">
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Account" HeaderText="Account" ReadOnly="True" SortExpression="Account"
                            ItemStyle-Wrap="false" />
                        <asp:BoundField DataField="CardNumber" HeaderText="Card Number" ReadOnly="True" SortExpression="CardNumber"
                            ItemStyle-CssClass="bold" />
                        <asp:BoundField DataField="NAME ON CARD" HeaderText="Name on Card" ReadOnly="True"
                            SortExpression="NAME ON CARD" ItemStyle-CssClass="bold" />
                        <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status"
                            ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bold" />
                        <asp:TemplateField HeaderText="Created" SortExpression="CREATED" ItemStyle-Wrap="false"
                            ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <div title='<%# TrustControl1.ToDateTimeTitle(Eval("CREATED")) %>'>
                                    <%# TrustControl1.ToRecentDate(Eval("CREATED"))%>
                                    <div class='time-small'>
                                        <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("CREATED")) %>'></time>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Wrap="False" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="DeliveryDT" HeaderText="Delivery DT" ReadOnly="True" SortExpression="DeliveryDT" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Date of Birth" HeaderText="Date of Birth" ReadOnly="True"
                            SortExpression="Date of Birth" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Address" HeaderText="Address" ReadOnly="True" SortExpression="Address"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="Mobile" HeaderText="Mobile" ReadOnly="True" SortExpression="Mobile"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="ITCLID" HeaderText="ITCLID" ReadOnly="True" SortExpression="ITCLID"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="CardType" HeaderText="Card Type" ReadOnly="True" SortExpression="CardType"
                            ItemStyle-HorizontalAlign="left" />
                    </Columns>
                    <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" PageButtonCount="30" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <EmptyDataTemplate>
                        No supplementary card found.
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="s_Search_Supplementary_All_Card_For_Supplementary_Issue" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Filter" QueryStringField="acc" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:Panel CssClass="group" runat="server" ID="div2">
                    <h4>
                       
                                Apply for supplementary card</h4>
                    <div class="group-body">
                        <asp:DetailsView ID="DetailsView_Supplementary" runat="server" BackColor="White"
                            CssClass="Grid" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4"
                            ForeColor="Black" GridLines="Vertical" DataSourceID="SqlDataSource_Supplementary"
                            AutoGenerateRows="False" DataKeyNames="ID" DefaultMode="ReadOnly" OnItemInserted="DetailsView_Supplementary_ItemInserted" OnItemUpdated="DetailsView_Supplementary_ItemUpdated">
                            <AlternatingRowStyle BackColor="White" />
                            <EmptyDataTemplate>
                                <asp:LinkButton runat="server" ID="cmdcredit" CommandName="New" Visible='<%# getIsEditable() %>'>
                                     Apply for card
                                </asp:LinkButton>
                            </EmptyDataTemplate>
                            <EmptyDataRowStyle Height="50px" HorizontalAlign="Center" Font-Size="Large" BackColor="#DDDDDD" />
                            <Fields>
                                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" SortExpression="ID"
                                    ReadOnly="true" ItemStyle-ForeColor="Silver" HeaderStyle-ForeColor="Silver">
                                    <HeaderStyle ForeColor="Silver" />
                                    <ItemStyle ForeColor="Silver" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtName1" Width="300px" MaxLength="50" runat="server" Text='<%# Bind("Name") %>' placeholder="supplimentary card holder name"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1sdfgf" runat="server"
                                            ControlToValidate="txtName1" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$"
                                            Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3trhjhj" runat="server" ControlToValidate="txtName1"
                                            ValidationGroup="Part2" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txtName1" MaxLength="50" Width="300px" runat="server" placeholder="supplimentary card holder name" Text='<%# Bind("Name") %>'></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1dfzxcawethu" runat="server"
                                            ControlToValidate="txtName1" ValidationGroup="Part2" ErrorMessage="RegularExpressionValidator"
                                            ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$" Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3kgrgrrt" runat="server" ControlToValidate="txtName1"
                                            ForeColor="Red" ValidationGroup="Part2" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Name")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name On Card" SortExpression="NameOnCard">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txNameOnCard1" Width="300px" MaxLength="18" runat="server" placeholder="supplimentary name on card" Text='<%# Bind("NameOnCard") %>'></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txNameOnCard1"
                                            ErrorMessage="RegularExpressionValidator" ValidationGroup="Part2" ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$"
                                            Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txNameOnCard1"
                                            ValidationGroup="Part2" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txNameOnCard1" MaxLength="18" Width="300px" runat="server" placeholder="supplimentary name on card" Text='<%# Bind("NameOnCard") %>'></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txNameOnCard1"
                                            ValidationGroup="Part2" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$"
                                            Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txNameOnCard1"
                                            ForeColor="Red" ErrorMessage="RequiredFieldValidator" ValidationGroup="Part2">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("NameOnCard")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Gender">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSEX" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cboSEX" runat="server" SelectedValue='<%# Bind("Gender") %>'>
                                           <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                             <asp:ListItem Text="Male" Value="M"></asp:ListItem>                                            
                                        </asp:DropDownList>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cboSEX" runat="server" SelectedValue='<%# Bind("Gender") %>'>
                                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                            <asp:ListItem Text="Male" Value="M"></asp:ListItem>                                            
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TITLE">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cmdTitle" runat="server" DataSourceID="SqlDataSource_cmdTitle" SelectedValue='<%# Bind("TitleID") %>' DataTextField="Title" DataValueField="TitleID">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource_cmdTitle" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                            SelectCommand="SELECT * FROM v_Title ORDER BY orderCol" SelectCommandType="Text"></asp:SqlDataSource>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cmdTitle" runat="server" DataSourceID="SqlDataSource_cmdTitle" SelectedValue='<%# Bind("TitleID") %>' DataTextField="Title" DataValueField="TitleID">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource_cmdTitle" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                            SelectCommand="SELECT * FROM v_Title ORDER BY orderCol" SelectCommandType="Text"></asp:SqlDataSource>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Relation With Primary Cardholder" SortExpression="RelationWithPrimaryCardholder"
                                    HeaderStyle-Wrap="false">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cboRelationWith" runat="server" SelectedValue='<%# Bind("RelationWithPrimaryCardholder") %>'
                                            AppendDataBoundItems="true">
                                            <%--<asp:ListItem Text="" Value=""></asp:ListItem>--%>
                                            <asp:ListItem Text="Spouse" Value="Spouse"></asp:ListItem>
                                            <asp:ListItem Text="Parent" Value="Parent"></asp:ListItem>
                                            <asp:ListItem Text="Brother" Value="Brother"></asp:ListItem>
                                            <asp:ListItem Text="Sister" Value="Sister"></asp:ListItem>
                                            <asp:ListItem Text="Son" Value="Son"></asp:ListItem>
                                            <asp:ListItem Text="Daughter" Value="Daughter"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cboRelationWith" runat="server" SelectedValue='<%# Bind("RelationWithPrimaryCardholder") %>'
                                            AppendDataBoundItems="true">
                                            <%--<asp:ListItem Text="" Value=""></asp:ListItem>--%>
                                            <asp:ListItem Text="Spouse" Value="Spouse"></asp:ListItem>
                                            <asp:ListItem Text="Parent" Value="Parent"></asp:ListItem>
                                            <asp:ListItem Text="Brother" Value="Brother"></asp:ListItem>
                                            <asp:ListItem Text="Sister" Value="Sister"></asp:ListItem>
                                            <asp:ListItem Text="Son" Value="Son"></asp:ListItem>
                                            <asp:ListItem Text="Daughter" Value="Daughter"></asp:ListItem>
                                        </asp:DropDownList>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("RelationWithPrimaryCardholder")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mobile" SortExpression="Mobile">
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" ID="txtMobile1" Text='<%# Bind("Mobile") %>' MaxLength="20" placeholder="8801000000000"
                                            Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4dsd" ValidationGroup="Part2"
                                            runat="server" ControlToValidate="txtMobile1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{6,15}$"
                                            ValidationGroup="Part2" ControlToValidate="txtMobile1" ErrorMessage="RegularExpressionValidator">Invalid</asp:RegularExpressionValidator>

                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" ID="txtMobile1" Text='<%# Bind("Mobile") %>' MaxLength="20" placeholder="8801000000000"
                                            Width="200px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4wewq" runat="server" ControlToValidate="txtMobile1"
                                            ValidationGroup="Part2" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{6,15}$"
                                            ControlToValidate="txtMobile1" ValidationGroup="Part2" ErrorMessage="RegularExpressionValidator"
                                            ForeColor="Red">Invalid</asp:RegularExpressionValidator>

                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Mobile")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date of Birth" SortExpression="DOB">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDOB1" CssClass="Date" runat="server" Text='<%# Bind("DOB","{0:dd/MM/yyyy}") %>'
                                            MaxLength="80" Width="85px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3343" runat="server" ControlToValidate="txtDOB1"
                                            ValidationGroup="Part2" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txtDOB1" CssClass="Date" runat="server" Text='<%# Bind("DOB","{0:dd/MM/yyyy}") %>'
                                            MaxLength="80" Width="85px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3s343" runat="server" ControlToValidate="txtDOB1"
                                            ValidationGroup="Part2" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("DOB","{0:dd/MM/yyyy}") %>
                                        <span class="time-small" style="margin-left: 20px" title="Age">
                                            <%# Common.getAge(Eval("DOB")) %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delivery Branch">
                                    <ItemTemplate>
                                        <%# Eval("BranchName")%>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cboDeliveryBranch" runat="server" SelectedValue='<%# Bind("DeliveryBranchID") %>'
                                            AppendDataBoundItems="true" DataSourceID="SqlDataSource_DeliveryBranch" DataTextField="BranchName"
                                            DataValueField="BranchID">
                                            <asp:ListItem Text="My Current Branch" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorDeliveryBranch" runat="server"
                                            ValidationGroup="Part2" ControlToValidate="cboDeliveryBranch" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        <asp:SqlDataSource ID="SqlDataSource_DeliveryBranch" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                            SelectCommand="SELECT BranchID,BranchName FROM v_BranchOnly" SelectCommandType="Text"></asp:SqlDataSource>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cboDeliveryBranch" runat="server" SelectedValue='<%# Bind("DeliveryBranchID") %>'
                                            DataSourceID="SqlDataSource_DeliveryBranch" DataTextField="BranchName" DataValueField="BranchID"
                                            AppendDataBoundItems="true">
                                            <asp:ListItem Text="My Current Branch" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorDeliveryBranch" runat="server"
                                            ValidationGroup="Part2" ControlToValidate="cboDeliveryBranch" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                        <asp:SqlDataSource ID="SqlDataSource_DeliveryBranch" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                            SelectCommand="SELECT BranchID,BranchName FROM v_BranchOnly" SelectCommandType="Text"></asp:SqlDataSource>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Card Type">
                                    <ItemTemplate>
                                        <%# Eval("CardTypeName")%>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="cboCardType" runat="server" SelectedValue='<%# Bind("CardType") %>'
                                            AppendDataBoundItems="true" DataSourceID="SqlDataSourceCardType" DataTextField="CardType"
                                            DataValueField="CardTypeCode" OnDataBound="cboCardType_DataBound1">
                                            <asp:ListItem Text="" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSourceCardType" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                            SelectCommand="s_getCardTypesSupplementary" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Account" QueryStringField="acc" Type="String" />
                                                <asp:SessionParameter Name="BranchID" SessionField="BranchID" DefaultValue="1" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </InsertItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="cboCardType" runat="server" SelectedValue='<%# Bind("CardType") %>'
                                            DataSourceID="SqlDataSourceCardType" DataTextField="CardType" DataValueField="CardTypeCode"
                                            OnDataBound="cboCardType_DataBound">
                                            <asp:ListItem Text="" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSourceCardType" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                            SelectCommand="s_getCardTypesSupplementary" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Account" QueryStringField="acc" Type="String" />
                                                <asp:SessionParameter Name="BranchID" SessionField="BranchID" DefaultValue="1" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Comments" SortExpression="Comments">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtComments" Width="300px" MaxLength="250" runat="server" Text='<%# Bind("Comments") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txtComments" MaxLength="250" Width="300px" runat="server" Text='<%# Bind("Comments") %>'></asp:TextBox>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Comments")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False" ControlStyle-Width="80px">
                                    <EditItemTemplate>
                                        <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" CommandName="Update"
                                            ValidationGroup="Part2" Text="Update" />
                                        <asp:ConfirmButtonExtender ID="conUpdate" runat="server" ConfirmText="Do you want to Update?"
                                            TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                        &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="True" CommandName="Cancel"
                                            ValidationGroup="Part2" Text="Cancel" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Button ID="cmdInsert" runat="server" CausesValidation="true" CommandName="Insert"
                                            ValidationGroup="Part2" Text="Save" />
                                        <asp:ConfirmButtonExtender ID="conInsert" runat="server" ConfirmText="Do you want to Save?"
                                            TargetControlID="cmdInsert"></asp:ConfirmButtonExtender>
                                        &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="false" CommandName="Cancel"
                                            ValidationGroup="Part2" Text="Cancel" />
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Button ID="cmdEdit1" runat="server" Enabled='<%# Eval("SendToProcess").ToString() == "True" ? false : true %>'
                                            CausesValidation="True" ValidationGroup="Part2" CommandName="Edit" Text="Edit" />
                                        <asp:Button ID="cmdDelete" runat="server" Enabled='<%# Eval("SendToProcess").ToString() == "True" ? false : true %>'
                                            CausesValidation="True" ValidationGroup="Part2" CommandName="Delete" Text="Delete" />
                                        <asp:ConfirmButtonExtender ID="conDelete" runat="server" ConfirmText="Do you want to Delete?"
                                            TargetControlID="cmdDelete"></asp:ConfirmButtonExtender>
                                    </ItemTemplate>
                                    <ControlStyle Width="80px" />
                                </asp:TemplateField>
                            </Fields>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                        </asp:DetailsView>

                        <asp:SqlDataSource ID="SqlDataSource_Supplementary" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_SupplementaryCardRequest_browse"
                            SelectCommandType="StoredProcedure" InsertCommand="s_SupplementaryCardRequest_Add_Edit"
                            InsertCommandType="StoredProcedure" UpdateCommand="s_SupplementaryCardRequest_Add_Edit"
                            UpdateCommandType="StoredProcedure" DeleteCommand="s_SupplementaryCardRequest_Delete"
                            DeleteCommandType="StoredProcedure" OnInserted="SqlDataSource_Supplementary_Inserted"
                            OnUpdated="SqlDataSource_Supplementary_Updated"
                            OnDeleted="SqlDataSource_Supplementary_Deleted">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="grdvSupplementary" Name="ID" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                            <InsertParameters>
                                <asp:ControlParameter ControlID="hidReqID" Name="ID" PropertyName="Value" Direction="InputOutput" Type="Int32" />
                                <asp:ControlParameter ControlID="hidReqAccount" Name="Account" PropertyName="Value" Type="String" />
                                <asp:Parameter Name="Name" Type="String" />
                                <asp:Parameter Name="NameOnCard" Type="String" />
                                <asp:Parameter Name="RelationWithPrimaryCardholder" Type="String" />
                                <asp:Parameter Name="Mobile" Type="String" />
                                <asp:Parameter Name="Gender" Type="String" />
                                <asp:Parameter Name="TitleID" Type="Int32" />
                                <asp:SessionParameter Name="RequestBranchID" Type="Int32" SessionField="BranchID" />
                                <asp:Parameter Name="CardType" Type="String" />
                                <asp:Parameter Name="DOB" Type="DateTime" />
                                <asp:Parameter Name="DeliveryBranchID" Type="Int32" />
                                <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                                <asp:Parameter Direction="InputOutput" Name="Msg" Type="String" Size="250" />
                                <asp:Parameter Direction="InputOutput" Name="Done" Type="Boolean" DefaultValue="false" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:ControlParameter ControlID="hidReqID" Name="ID" PropertyName="Value" Direction="InputOutput" Type="Int32" />
                                <asp:ControlParameter ControlID="hidReqAccount" Name="Account" PropertyName="Value" Type="String" />
                                <asp:Parameter Name="Name" Type="String" />
                                <asp:Parameter Name="NameOnCard" Type="String" />
                                <asp:Parameter Name="RelationWithPrimaryCardholder" Type="String" />
                                <asp:Parameter Name="Mobile" Type="String" />
                                <asp:Parameter Name="Gender" Type="String" />
                                <asp:Parameter Name="TitleID" Type="Int32" />
                                <asp:SessionParameter Name="RequestBranchID" Type="Int32" SessionField="BranchID" />
                                <asp:Parameter Name="DOB" Type="DateTime" />
                                <asp:Parameter Name="CardType" Type="String" />
                                <asp:Parameter Name="DeliveryBranchID" Type="Int32" />
                                <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                                <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                                <asp:Parameter Direction="InputOutput" Name="Done" Type="Boolean" DefaultValue="false" />
                            </UpdateParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="ID" />
                                <asp:Parameter Name="Msg" Type="String" Size="250" Direction="InputOutput" DefaultValue="" />
                                <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                            </DeleteParameters>
                        </asp:SqlDataSource>

                        <asp:GridView ID="grdvSupplementary" runat="server" DataKeyNames="ID" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource3" CssClass="Grid no-shadow" BorderStyle="None" BackColor="White"
                            ShowHeader="true" AllowPaging="false" AllowSorting="false" EnableViewState="true" ShowFooter="true"
                            BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="5" ForeColor="Black" GridLines="Vertical"
                            OnRowCommand="grdvSupplementary_RowCommand">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkTrnSelect" runat="server" CausesValidation="False" CommandName="Select" Visible='<%# (Eval("SendToProcess").ToString().ToUpper() == "FALSE"  ? true : false) %>'>
                                                                <img src="Images/edit-label.png" width="20" height="20" border="0" />
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="True" ForeColor="Blue" />
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="ID" DataField="ID" SortExpression="ID" />
                                <asp:BoundField HeaderText="Account" DataField="Account" SortExpression="Account" />
                                <asp:BoundField HeaderText="Name" DataField="Name" SortExpression="Name" />
                                <asp:BoundField HeaderText="Name On Card" DataField="NameOnCard" SortExpression="NameOnCard" />
                                <asp:BoundField HeaderText="Relation" DataField="RelationWithPrimaryCardholder" SortExpression="RelationWithPrimaryCardholder" />
                                <asp:BoundField HeaderText="Mobile" DataField="Mobile" SortExpression="Mobile" />
                                <asp:BoundField HeaderText="Gender" DataField="Gender" SortExpression="Gender" />
                                <asp:BoundField HeaderText="Title" DataField="Title" SortExpression="Title" />
                                <asp:BoundField HeaderText="DOB" DataField="DOB" SortExpression="DOB" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField HeaderText="CardTypeName" DataField="CardTypeName" SortExpression="CardTypeName" />
                                <asp:BoundField HeaderText="SendToProcess" DataField="SendToProcess" SortExpression="SendToProcess" />
                                <asp:BoundField HeaderText="Delivery Branch" DataField="BranchName" SortExpression="BranchName" />
                                <asp:BoundField HeaderText="Title" DataField="Title" SortExpression="Title" />
                                <asp:TemplateField HeaderText="Inserted on" SortExpression="InsertDT">
                                    <ItemTemplate>
                                        <div class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                        <uc3:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Send on" SortExpression="SendBY">
                                    <ItemTemplate>
                                        <div class="time-small" title='<%# Eval("SendDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("SendDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </div>
                                        <uc3:EMP ID="EMP11" runat="server" Username='<%# Eval("SendBY") %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                            <FooterStyle BackColor="#CCCC99" Font-Bold="true" HorizontalAlign="Right" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_SupplementaryCardRequest_Select" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="Account" QueryStringField="acc" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                </asp:Panel>
            </asp:Panel>
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