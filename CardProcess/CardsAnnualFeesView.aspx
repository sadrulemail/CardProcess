﻿<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReconciliationFile_Upload.aspx.cs" Inherits="ReconciliationFile_Upload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CardsAnnualFeesView.aspx.cs" Inherits="CardsAnnualFeesView" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Card Fees
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hidBatch" runat="server" Value="" />

            <asp:Panel ID="Panel1" runat="server">

                <table class="Panel1 ui-corner-all" style="padding-left: 10px">
                    <tr>
                        <td>
                            <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" />
                            <asp:DropDownList ID="DropDownList1" runat="server" Enabled="false" >
                                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                 <asp:ListItem Text="2" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                            <b>Account :</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSearch" runat="server" Width="150px"></asp:TextBox></td>

                        <td>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" Width="80px" CausesValidation="false"
                                OnClick="btnSearch_Click" />
                        </td>
                    </tr>
                </table>

            </asp:Panel>
            <table>
                <tr>
                    <td>
                        <div>
                            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                                AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px" DataKeyNames="ID"
                                CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" AutoGenerateColumns="False"
                                CssClass="Grid" EnableSortingAndPagingCallbacks="True">
                                <Columns>
                                    <asp:TemplateField HeaderText="SL">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" Visible="false"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="RefID" HeaderText="Ref ID" SortExpression="RefID">
                                        <ItemStyle Wrap="False" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ClientID" HeaderText="Client ID" SortExpression="ClientID">
                                        <ItemStyle Wrap="False" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CardHolderName" HeaderText="Card Holder Name" SortExpression="CardHolderName">
                                        <ItemStyle Wrap="True" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CardNumber" HeaderText="Card Number" SortExpression="CardNumber">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AccountNumber" HeaderText="Account Number" SortExpression="AccountNumber">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Fees" HeaderText="Fees" SortExpression="Fees">
                                        <ItemStyle Wrap="False" HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CardStatus" HeaderText="Card Status" SortExpression="CardStatus">
                                        <ItemStyle Wrap="False" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CreationDate" HeaderText="Creation Date" SortExpression="CreationDate"
                                        DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ExpireDate" HeaderText="Expire Date" SortExpression="ExpireDate"
                                        DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Dstatus" HeaderText="Dstatus" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="DeleteBtn" Visible='<%# Eval("RefID").ToString() == "" ? true : false %>'
                                                runat="server" CommandName="Delete" ToolTip="Delete"><img src="Images/cross.png" />
                                            </asp:LinkButton>
                                            <asp:ConfirmButtonExtender runat="server" ID="DeleteID" ConfirmText="Do you want to Delete?"
                                                TargetControlID="DeleteBtn"></asp:ConfirmButtonExtender>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#F7F7DE" />
                                <FooterStyle BackColor="#CCCC99" />
                                <EmptyDataTemplate>
                                    No Record Found.
                                </EmptyDataTemplate>
                                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" />
                                <PagerSettings Position="TopAndBottom" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            </asp:GridView>
                            <br />
                            <asp:Label Font-Names="Arial" runat="server" ID="lblStatus" Text="" Font-Size="Small" Visible="false"></asp:Label>
                            <br />
                            <br />
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="s_CardChargeDeduction_Batch" SelectCommandType="StoredProcedure"
                                OnSelected="SqlDataSource1_Selected" DeleteCommand="s_CardChargeDeductionBatchAccount_Delete" DeleteCommandType="StoredProcedure" OnDeleted="SqlDataSource1_Deleted">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="ID" QueryStringField="batchId" Type="Int32" />
                                    <asp:ControlParameter ControlID="txtSearch" Name="Account" PropertyName="Text"
                                        Type="String" DefaultValue="*" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="ID" Type="Int32" />
                                    <asp:SessionParameter Name="EmpID" SessionField="EMPID" />
                                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" DefaultValue="" Size="250" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                        </div>
                    </td>
                    <td valign="top">
                        <div>
                            <asp:GridView ID="GridView2" runat="server" AllowSorting="True" ShowFooter="True" BackColor="White"
                                AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                                CellPadding="4" DataSourceID="SqlDataSource2" OnDataBound="GridView2_DataBound" ForeColor="Black" AutoGenerateColumns="False"
                                CssClass="Grid" EnableSortingAndPagingCallbacks="True">
                                <Columns>
                                    <asp:TemplateField HeaderText="SL">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Account" DataField="Account" SortExpression="Account" />
                                    <asp:BoundField HeaderText="Credit" DataField="Credit" SortExpression="Credit" />
                                    <asp:BoundField HeaderText="Debit" DataField="Debit" SortExpression="Debit" />
                                </Columns>
                                <RowStyle BackColor="#F7F7DE" />
                                <FooterStyle BackColor="#CCCC99" Font-Bold="True" HorizontalAlign="Right" />
                                <EmptyDataTemplate>
                                    No Record Found.
                                </EmptyDataTemplate>
                                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" />
                                <PagerSettings Position="TopAndBottom" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            </asp:GridView>
                            <br />
                            <asp:Label Font-Names="Arial" runat="server" ID="Label1" Text="" Font-Size="Small" Visible="false"></asp:Label>
                            <br />
                            <br />
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="s_CardChargeDeductionDistrubutionSummary" SelectCommandType="StoredProcedure"
                                OnSelected="SqlDataSource2_Selected">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="ID" QueryStringField="batchId" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </td>
                </tr>
            </table>
            <asp:Button runat="server" ID="downloadxlsx" Text="Download XLSX" OnClick="downloadxlsx_Click" />

            <table>
                <tr>
                   
                    <td>
                        <div>
                            <asp:GridView ID="GridView3" runat="server" AllowSorting="True" ShowFooter="false" BackColor="White"
                                AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                                CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="Black" AutoGenerateColumns="False"
                                CssClass="Grid" DataKeyNames="CardTypeCode" EnableSortingAndPagingCallbacks="True" OnSelectedIndexChanged="GridView3_SelectedIndexChanged">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"><img src="Images/edit-label.png" width="20" height="20" border="0" /></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="True" ForeColor="Blue" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SL">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Batch" DataField="Batch" SortExpression="Batch" ReadOnly="true" />

                                    <asp:BoundField HeaderText="CardTypeCode" DataField="CardTypeCode" SortExpression="CardTypeCode" ReadOnly="true" />
                                    <asp:BoundField HeaderText="CardType" DataField="CardType" SortExpression="CardType" ReadOnly="true" />
                                    <asp:BoundField HeaderText="Fees" DataField="Fees" SortExpression="Fees" />
                                    <asp:BoundField HeaderText="AnnualFees[CardType]" DataField="AnnualFeesType" SortExpression="AnnualFeesType" ReadOnly="true" />
                                    <asp:BoundField HeaderText="Total" DataField="Total" SortExpression="Total" ReadOnly="true" />
                                    <%--<asp:CommandField ShowEditButton="true" /> --%>
                                </Columns>
                                <RowStyle BackColor="#F7F7DE" />
                                <FooterStyle BackColor="#CCCC99" Font-Bold="True" HorizontalAlign="Right" />
                                <EmptyDataTemplate>
                                    No Record Found.
                                </EmptyDataTemplate>
                                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" />
                                <PagerSettings Position="TopAndBottom" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            </asp:GridView>
                            <br />
                            <asp:Label Font-Names="Arial" runat="server" ID="Label2" Text="" Font-Size="Small" Visible="false"></asp:Label>
                            <br />
                            <br />
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="s_CardChargeDeduction_Summary" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="batch" QueryStringField="batchId" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </td>
                     <td valign="top">
                        <asp:DetailsView ID="DetailsView1" runat="server" CssClass="Grid" AutoGenerateRows="False"
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px" Visible="true"
                            CellPadding="4" DataKeyNames="CardTypeCode" DataSourceID="SqlDataSource4" ForeColor="Black"
                            GridLines="Vertical" Style="font-size: small">
                            <FooterStyle BackColor="#CCCC99" />
                            <RowStyle BackColor="#F7F7DE" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <Fields>
                                <asp:BoundField DataField="Batch" HeaderText="Batch" SortExpression="Batch" ReadOnly="True"/>
                                <asp:BoundField DataField="CardTypeCode" HeaderText="Type Code" ReadOnly="True" SortExpression="CardTypeCode"
                                    ControlStyle-Width="150px" ItemStyle-Font-Bold="true">
                                    <ControlStyle Width="150px" />
                                </asp:BoundField>
                               <%-- <asp:BoundField DataField="CardType" HeaderText="CardType" ReadOnly="True" SortExpression="CardType"
                                    ControlStyle-Width="150px" ItemStyle-Font-Bold="true">
                                    <ControlStyle Width="150px" />
                                </asp:BoundField>--%>
                                <asp:TemplateField HeaderText="Annual Fees" SortExpression="AnnualFees">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtAnnualFees" runat="server" Text='<%# Bind("Fees", "{0:N2}") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="txtAnnualFees" runat="server" Text='<%# Bind("Fees", "{0:N2}") %>'></asp:TextBox>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label33333333" runat="server" Text='<%# Bind("Fees", "{0:N2}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ControlStyle Width="150px" />
                                </asp:TemplateField>
                                <asp:CommandField ShowInsertButton="True" ButtonType="Button" ShowEditButton="True"
                                    ControlStyle-Width="80px">
                                    <ControlStyle Width="80px" />
                                </asp:CommandField>
                            </Fields>
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_CardChargeDeduction_Summary"
                            SelectCommandType="StoredProcedure" UpdateCommand="s_CardChargeDeduction_Update" UpdateCommandType="StoredProcedure"
                            OnUpdated="SqlDataSource4_Updated">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView3" Name="CardTypeCode" PropertyName="SelectedValue"
                                    Type="String" />
                                <asp:ControlParameter ControlID="hidBatch" Name="Batch" PropertyName="Value"
                                    Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:ControlParameter ControlID="hidBatch" Name="Batch" PropertyName="Value"  />
                                <asp:Parameter Name="CardTypeCode"  />                                
                                <asp:Parameter Name="Fees" DefaultValue="0"/>
                                <asp:Parameter Name="Msg" Direction="InputOutput" Size="250" DefaultValue="" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>

        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="downloadxlsx" />
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
