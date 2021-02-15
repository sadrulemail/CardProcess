﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ForwardingView.aspx.cs" Inherits="ForwardingView" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Forwarding View
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <asp:Panel ID="Panel1" runat="server">

                <table class="Panel1 ui-corner-all" style="padding-left: 10px">
                    <tr>
                        <td>
                            <b>Account :</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSearch" runat="server" Width="150px"></asp:TextBox></td>
                        <td><b>Request Type :</b></td>
                        <td>
                            <asp:DropDownList ID="ddlReqType" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                DataTextField="SearchName" DataValueField="SearchValue">
                                <asp:ListItem Value="*" Text="All"></asp:ListItem>
                                <asp:ListItem Value="C" Text="New Issue"></asp:ListItem>
                                <asp:ListItem Value="R" Text="Reissue"></asp:ListItem>
                                <asp:ListItem Value="S" Text="Supplementary"></asp:ListItem>
                                <asp:ListItem Value="O" Text="Others"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
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
                                OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"
                                OnSelectedIndexChanging="GridView1_SelectedIndexChanging" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                                AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                                CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" AutoGenerateColumns="False"
                                CssClass="Grid" EnableSortingAndPagingCallbacks="True" DataKeyNames="ID" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30">
                                <Columns>
                                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" Visible="false"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <asp:TemplateField HeaderText="" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="SELECT" CommandArgument='<%# Eval("AccountNo") %>'
                                                Height="20px" ToolTip="Open" CausesValidation="false">
                                <img alt="" height="16px" width="16px" src='Images/new_window.png' border="0" />
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Batch" HeaderText="Batch" SortExpression="Batch"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="CardNumber" HeaderText="Card Number" SortExpression="CardNumber"
                                        ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="AccountNo" HeaderText="Account No"
                                        SortExpression="AccountNo" ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="CustomerName" HeaderText="Custome rName" SortExpression="CustomerName"
                                        ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="BranchName" HeaderText="Delivery Branch" SortExpression="BranchName"
                                        ItemStyle-HorizontalAlign="Left" />
                                    <asp:TemplateField HeaderText="Insert By" SortExpression="EmpID">
                                        <ItemTemplate>
                                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Forward On" SortExpression="DT" ItemStyle-Wrap="false"
                                        ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("DT")) %>'>
                                                <%# TrustControl1.ToRecentDate(Eval("DT"))%>
                                                <div class='time-small'>
                                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("DT")) %>'></time>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Type" SortExpression="ReqType">
                                        <ItemTemplate>
                                            <%# Eval("ReqType") %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="DeleteBtn" Visible='<%# Eval("dtt").ToString() == Eval("CurrentDate").ToString() ? true : false %>'
                                                runat="server" CommandName="Delete" ToolTip="Delete"><img src="Images/cross.png" />
                                            </asp:LinkButton>
                                            <asp:ConfirmButtonExtender runat="server" ID="DeleteID" ConfirmText="Do you want to Delete?"
                                                TargetControlID="DeleteBtn"></asp:ConfirmButtonExtender>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                                <FooterStyle BackColor="#CCCC99" />
                                <EmptyDataTemplate>
                                    No Record Found.
                                </EmptyDataTemplate>
                                <SelectedRowStyle BackColor="#CE5D5A" ForeColor="White" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" />
                                <PagerSettings Position="TopAndBottom" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            </asp:GridView>
                            <br />
                            <asp:Label Font-Names="Arial" runat="server" ID="lblStatus" Text="" Font-Size="Small"></asp:Label>
                            <br />
                            <br />
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="s_ForwardingCards_Browse" SelectCommandType="StoredProcedure" DeleteCommand="s_SingleForwarding_Delete" DeleteCommandType="StoredProcedure"
                                OnSelected="SqlDataSource1_Selected" OnDeleted="SqlDataSource1_Deleted">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="Batch" QueryStringField="batch" Type="Int32" />
                                    <asp:ControlParameter ControlID="txtSearch" Name="AccountNo" PropertyName="Text"
                                        Type="String" DefaultValue="*" />
                                    <asp:ControlParameter ControlID="ddlReqType" Name="ReqType" PropertyName="SelectedValue" Type="String"
                                        DefaultValue="*" />
                                    <asp:Parameter Name="ID" DefaultValue="-1" Type="Int32" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="ID" Type="Int32" />
                                    <asp:SessionParameter Name="EmpID" SessionField="EMPID" />
                                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" DefaultValue="" Size="250" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                        </div>
                        <div class="group">
                            <h5>Deleted Card(s) from Forwarding</h5>
                            <asp:GridView ID="GridView3" runat="server" AllowSorting="True" BackColor="White"
                                AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                                CellPadding="4" DataSourceID="SqlDataSource4" ForeColor="Black" AutoGenerateColumns="False"
                                CssClass="Grid" EnableSortingAndPagingCallbacks="True" DataKeyNames="ID" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30">
                                <Columns>
                                    <%-- <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" Visible="false"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <asp:TemplateField HeaderText="" HeaderStyle-Font-Bold="true">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="SELECT" CommandArgument='<%# Eval("AccountNo") %>'
                                                Height="20px" ToolTip="Open" CausesValidation="false">
                                <img alt="" height="16px" width="16px" src='Images/new_window.png' border="0" />
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>--%>
                                    <asp:BoundField DataField="Batch" HeaderText="Batch" SortExpression="Batch"
                                        ItemStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="CardNumber" HeaderText="Card Number" SortExpression="CardNumber"
                                        ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="AccountNo" HeaderText="Account No"
                                        SortExpression="AccountNo" ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="CustomerName" HeaderText="Custome rName" SortExpression="CustomerName"
                                        ItemStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="BranchName" HeaderText="Delivery Branch" SortExpression="BranchName"
                                        ItemStyle-HorizontalAlign="Left" />
                                    <asp:TemplateField HeaderText="Insert By" SortExpression="EmpID">
                                        <ItemTemplate>
                                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Forward On" SortExpression="DT" ItemStyle-Wrap="false"
                                        ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("DT")) %>'>
                                                <%# TrustControl1.ToRecentDate(Eval("DT"))%>
                                                <div class='time-small'>
                                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("DT")) %>'></time>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Type" SortExpression="ReqType">
                                        <ItemTemplate>
                                            <%# Eval("ReqType") %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Deleted By" SortExpression="DeletedBY">
                                        <ItemTemplate>
                                            <uc2:EMP ID="EMP11" runat="server" Username='<%# Eval("DeletedBY") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Deleted On" SortExpression="DeleteDT" ItemStyle-Wrap="false"
                                        ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("DeleteDT")) %>'>
                                                <%# TrustControl1.ToRecentDate(Eval("DeleteDT"))%>
                                                <div class='time-small'>
                                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("DeleteDT")) %>'></time>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:TemplateField>

                                </Columns>
                                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                                <FooterStyle BackColor="#CCCC99" />
                                <EmptyDataTemplate>
                                    No Record Found.
                                </EmptyDataTemplate>
                                <SelectedRowStyle BackColor="#CE5D5A" ForeColor="White" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" />
                                <PagerSettings Position="TopAndBottom" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            </asp:GridView>
                            <br />
                            <asp:Label Font-Names="Arial" runat="server" ID="Label2" Text="" Font-Size="Small"></asp:Label>
                            <br />
                            <br />
                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="s_ForwardingCards_Deleted" SelectCommandType="StoredProcedure"
                                OnSelected="SqlDataSource4_Selected">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="Batch" QueryStringField="batch" Type="Int32" />                                    
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>

                                           
    
                    </td>
                    <td valign="top" style="padding-left: 20px">
                        <asp:GridView ID="GridView2" runat="server" AllowSorting="True" BackColor="White" ShowFooter="true"
                            AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                            CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="Black" AutoGenerateColumns="False" Font-Size="Large"
                            CssClass="Grid" EnableSortingAndPagingCallbacks="True" DataKeyNames="ReqType" 
                            PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30" OnDataBound="GridView2_DataBound">
                            <Columns>
                                <asp:BoundField DataField="ReqType" HeaderText="Req Type" SortExpression="ReqType"
                                    ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total"
                                    ItemStyle-HorizontalAlign="Right" />
                            </Columns>
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
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
                        <asp:Label Font-Names="Arial" runat="server" ID="Label1" Text="" Font-Size="Small"></asp:Label>
                        <br />
                        <br />
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_ForwardingCards_Summery" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="Batch" QueryStringField="batch" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlReqType" Name="ReqType" PropertyName="SelectedValue" Type="String"
                                        DefaultValue="*" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
             <%--  modal popup--%> 

            <span style="visibility: hidden">
                <asp:Button runat="server" ID="cmdPopup" /></span>
            <asp:ModalPopupExtender ID="modal" runat="server" CancelControlID="ModalClose"
                TargetControlID="cmdPopup"
                PopupControlID="ModalPanel"
                BackgroundCssClass="ModalPopupBG"
                RepositionMode="RepositionOnWindowResizeAndScroll"
                CacheDynamicResults="False"
                Drag="true">
            </asp:ModalPopupExtender>
            <asp:Panel ID="ModalPanel" runat="server"
                CssClass="ModalPanel1">
                <div style="background: green">
                    <asp:Panel runat="server" ID="ModalTitleBar" CssClass="MoveIcon"
                        HorizontalAlign="Center">
                        <table width="100%">
                            <tr>
                                <td align="left" style="color: White; font-size: 14pt; font-weight: bolder">
                                    <asp:Label ID="ModalTitle" runat="server" Text="Delivery Info"></asp:Label>
                                </td>
                                <td align="right">
                                    <a href="#" style="cursor: default">
                                        <asp:Image ID="ModalClose" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close" />
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" BorderColor="#DEDFDE" 
                        BorderStyle="Solid" BorderWidth="1px" CssClass="Grid modal-table" CellPadding="4" DataSourceID="SqlDataSource2"
                        ForeColor="Black" AutoGenerateRows="False" OnItemInserted="DetailsView1_ItemInserted"
                        OnItemUpdated="DetailsView1_ItemUpdated" DataKeyNames="ID" OnModeChanged="DetailsView1_ModeChanged"
                        OnDataBound="DetailsView1_DataBound">
                        <FooterStyle BackColor="#CCCC99" />
                        <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" />
                        <Fields>
                            <asp:TemplateField HeaderText="Batch ID">
                                <ItemTemplate>
                                    <asp:Label ID="lblBatch" runat="server" Text='<%# Bind("Batch") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Card Number">
                                <ItemTemplate>
                                    <asp:Label ID="lblCardNumber" runat="server" Text='<%# Bind("CardNumber") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account No">
                                <ItemTemplate>
                                    <asp:Label ID="lblAccountNo" runat="server" Text='<%# Bind("AccountNo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" SortExpression="CustomerName"
                                ReadOnly="true" ItemStyle-Font-Bold="true">
                                <ItemStyle Font-Bold="false" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Delivery Branch">
                                <ItemTemplate>
                                    <%# Eval("BranchName") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="cboDeliveryBranch" runat="server" SelectedValue='<%# Bind("DeliveryToBranch") %>' 
                                        DataSourceID="SqlDataSource_DeliveryBranch" DataTextField="BranchName" DataValueField="BranchID"
                                        AppendDataBoundItems="true">
                                        <%--<asp:ListItem Text="My Current Branch" Value="0"></asp:ListItem>--%>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorDeliveryBranch" runat="server"
                                        ControlToValidate="cboDeliveryBranch" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="SqlDataSource_DeliveryBranch" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                        SelectCommand="SELECT BranchID,BranchName FROM v_BranchOnly" SelectCommandType="Text"></asp:SqlDataSource>
                                </EditItemTemplate>
                                <ItemStyle Wrap="false" />
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False" ControlStyle-Width="100px" Visible="true">
                                <EditItemTemplate>
                                    <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="Update" />
                                    <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Do you want to Update?"
                                        Enabled="True" TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                    &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="Cancel" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit"
                                        Text="Edit" />
                                </ItemTemplate>
                                <ControlStyle Width="100px" />
                            </asp:TemplateField>
                        </Fields>
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:DetailsView>
                </div>
            </asp:Panel>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_ForwardingCards_Browse" SelectCommandType="StoredProcedure" UpdateCommand="s_Forwarding_Delivery_Branch_Update"
                UpdateCommandType="StoredProcedure" OnUpdated="SqlDataSource2_Updated">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="AccountNo" />
                    <asp:Parameter Name="CardNumber" />
                    <asp:Parameter Name="Batch" />
                    <asp:Parameter Name="DeliveryToBranch" />
                    <asp:SessionParameter Name="EmpID" SessionField="EMPID" />
                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" DefaultValue="" Size="250" />
                </UpdateParameters>
            </asp:SqlDataSource>
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
