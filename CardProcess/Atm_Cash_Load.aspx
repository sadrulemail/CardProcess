﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Atm_Cash_Load.aspx.cs" Inherits="Atm_Cash_Load" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="ATM Cash Load"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <table>
                <tr>
                    <td>
                        <table class="Panel1 ui-corner-all">
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="True" CausesValidation="True"
                                        onfocus="this.select()" Watermark="enter information to filter" Width="150px"></asp:TextBox>
                                </td>
                                <td style="padding-left: 10px; white-space: nowrap">
                                    Loading Branch:
                                </td>
                                <td>
                                    <asp:DropDownList ID="dboBranch" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                        CausesValidation="false" DataSourceID="SqlDataSourceBranchName" DataTextField="BranchName"
                                        DataValueField="BranchID" OnDataBound="dboBranch_DataBound">
                                        <asp:ListItem Text="All Branch" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceBranchName" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="SELECT BranchID, BranchName
FROM dbo.viewBranchOnly with (nolock)    
ORDER BY BranchName" EnableCaching="true" CacheDuration="600"></asp:SqlDataSource>
                                </td>
                                <td style="padding-left: 10px; white-space: nowrap">
                                    Status:
                                </td>
                                <td>
                                    <asp:DropDownList ID="dboStatus" runat="server" AutoPostBack="true">
                                        <asp:ListItem Text="Pending" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Ready to Confirm" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Ready to Load" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Confirmed" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="Show All" Value="*"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:DropDownList ID="dboIsLatest" runat="server" AutoPostBack="true">
                                        <asp:ListItem Text="Latest Only" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Show All" Value="*"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Button ID="cmdSearch" runat="server" Text="Filter" Width="80px" Style="font-weight: 700" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="padding-left: 10px; font-size: small; font-weight: bold">
                        <a href="https://intraweb.tblbd.com/blog/2602" target="_blank">How to use?</a>
                    </td>
                </tr>
            </table>
            <%-- test start--%>
            <%--<asp:Button ID="ButtonNew" runat="server" Text="Add New" OnClick="ButtonNew_Click" />--%>
            <%--test end--%>
            <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" CssClass="Grid"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" DataKeyNames="ID" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="True" PageSize="7" PagerSettings-Mode="NumericFirstLast"
                PagerSettings-PageButtonCount="30" PagerSettings-Position="TopAndBottom" OnRowUpdated="GridView1_RowUpdated"
                OnRowCommand="GridView1_RowCommand" OnPageIndexChanged="GridView1_PageIndexChanged"
                OnSorted="GridView1_Sorted">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField >
                        <ItemTemplate>
                            <a target="_blank" href='Atm_Cash_Load_Show.aspx?id=<%# Eval("ID") %>'>
                                <%# Eval("ID") %></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Atm ID" SortExpression="AtmID">
                        <ItemTemplate>
                            <asp:Label ID="lblAtmID" runat="server" Text='<%# Bind("AtmID") %>'></asp:Label>
                            <div title='<%# Eval("ID") %>'><a target="_blank" href='Atm_Cash_Load_Show.aspx?id=<%# Eval("ID") %>'>
                                <%# (Eval("isLatest").ToString() == "True" ? "<img src='Images/new.gif' width=35' height='22' >" : "")%></a></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ATM Name/ Feeding Branch" SortExpression="AtmName">
                        <ItemTemplate>
                            <div style="font-weight: bold">
                                <%# Eval("AtmName") %></div>
                            <div style="color: Gray" title="Feeding Branch">
                                <%# Eval("FeedingBranchName")%>
                                <%# Eval("FeedingBranch","({0})")%></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cash Load Instruction" SortExpression="Instruction_TotalAmount">
                        <ItemTemplate>
                            <table class='cash-table <%# (bool)Eval("isVisibleCashLoadInstruction") == true ? "" : "hide" %>' width="100%">
                                <tr>
                                    <td>
                                        1000
                                    </td>
                                    <td>
                                        x
                                    </td>
                                    <td>
                                        <%# Eval("Instruction_Note_1000")%>
                                    </td>
                                    <td>
                                        =
                                    </td>
                                    <td>
                                        <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Instruction_Note_1000_Amount"))%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        500
                                    </td>
                                    <td>
                                        x
                                    </td>
                                    <td>
                                        <%# Eval("Instruction_Note_500")%>
                                    </td>
                                    <td>
                                        =
                                    </td>
                                    <td>
                                        <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Instruction_Note_500_Amount"))%>
                                    </td>
                                </tr>
                                <tr style="border-top: 1px solid silver">
                                    </td>
                                    <td class="bold" colspan="5">
                                        <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Instruction_TotalAmount"))%>
                                    </td>
                                </tr>
                            </table>
                            <%--<div style="color: Green">
                                <%# Eval("Instruction_TotalAmountInword")%>
                            </div>--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Instruction_Comment" HeaderText="Instruction" SortExpression="Instruction_Comment"
                        ReadOnly="true" />
                    <asp:TemplateField HeaderText="Insert on" SortExpression="Instruction_DT">
                        <ItemTemplate>
                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("Instruction_DT")) %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("Instruction_DT"))%>
                                <div class='time-small'>
                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("Instruction_DT")) %>'></time>
                                </div>
                            </div>
                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("Instruction_By") %>' Prefix="By: " />
                            <%# Eval("BatchID", "<div>Batch: {0}</div>")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Load Branch" SortExpression="Load_Branch">
                        <ItemTemplate>
                            <uc3:Branch ID="Branch1" runat="server" BranchID='<%# Eval("Load_Branch") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cash Load Information" SortExpression="Load_TotalAmount">
                        <ItemTemplate>
                            <div class='<%# (bool)Eval("isVisible") == true ? "" : "hide" %>'>
                                <table class='cash-table'>
                                    <tr class='<%# (int)Eval("Unload_TotalAmount") > 0 ? "" : "hide" %>'>
                                        <td>
                                            1000
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                            <%# Eval("Unload_Note_1000")%>
                                        </td>
                                        <td>
                                            =
                                        </td>
                                        <td>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Unload_Note_1000_Amount"))%>
                                        </td>
                                        <td rowspan="2">
                                            <img src="Images/right1.png" title="Before Load Amount" width="32" height="32" border="0" />
                                        </td>
                                        <td rowspan="2" class="bold right">
                                            <%# Eval("Unload_TotalAmount", "{0:N0}")%>
                                        </td>
                                    </tr>
                                    <tr class='<%# (int)Eval("Unload_TotalAmount") > 0 ? "" : "hide" %>' style="border-bottom: 1px solid silver;">
                                        <td>
                                            500
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                            <%# Eval("Unload_Note_500")%>
                                        </td>
                                        <td>
                                            =
                                        </td>
                                        <td>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Unload_Note_500_Amount"))%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            1000
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                            <%# Eval("Load_Note_1000")%>
                                        </td>
                                        <td>
                                            =
                                        </td>
                                        <td>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_Note_1000_Amount"))%>
                                        </td>
                                        <td rowspan="2">
                                            <img src="Images/right.png" title="Load Amount" width="32" height="32" border="0" />
                                        </td>
                                        <td rowspan="2" class="bold right">
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_TotalAmount"))%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            500
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                            <%# Eval("Load_Note_500")%>
                                        </td>
                                        <td>
                                            =
                                        </td>
                                        <td>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_Note_500_Amount"))%>
                                        </td>
                                    </tr>
                                    <tr style="border-top: 1px solid silver" class='<%# (int)Eval("Unload_TotalAmount") > 0 ? "" : "hide" %>'>
                                        <td class="bold" colspan="7">
                                            After Load:
                                            <%# Eval("TotalAmount", "{0:N0}")%>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <asp:LinkButton runat="server" ID="lnkEdit" CommandName="Edit" Visible='<%# (bool)Eval("isEditable") %>'><img src="Images/edit-label.png" width="20" height="20" border="0" /></asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <table class='cash-table'>
                                <tr>
                                    </td>
                                    <td class="bold left" colspan="5" style="text-align: left">
                                        Before Load Amount:
                                    </td>
                                </tr>
                                <%--<tr style="border-top: 1px solid silver">                                    
                                </tr> --%>
                                <tr>
                                    <td>
                                        1000
                                    </td>
                                    <td>
                                        x
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtUnload_Note_1000" CssClass="Unload_Note_1000 right courier" Text='<%# Bind("Unload_Note_1000")%>'
                                            Width="50px" runat="server"></asp:TextBox>
                                        <input type="hidden" id="hidUnload_Note_1000" value='<%# Eval("Unload_Note_1000")%>' />
                                    </td>
                                    <td>
                                        =
                                    </td>
                                    <td>
                                        <span id='lblUnload_Note_1000_Amount'>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Unload_Note_1000_Amount"))%>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        500
                                    </td>
                                    <td>
                                        x
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtUnload_Note_500" CssClass="Unload_Note_500 right courier" Text='<%# Bind("Unload_Note_500")%>'
                                            Width="50px" runat="server"></asp:TextBox>
                                        <input type="hidden" id="hidUnload_Note_500" value='<%# Eval("Unload_Note_500")%>' />
                                    </td>
                                    <td>
                                        =
                                    </td>
                                    <td>
                                        <span id='lblUnload_Note_500_Amount'>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Unload_Note_500_Amount"))%>
                                        </span>
                                    </td>
                                </tr>
                                <tr style="border-top: 1px solid silver">
                                    <td class="bold" colspan="5">
                                        <span id='lblUnload_TotalAmount'>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Unload_TotalAmount"))%>
                                        </span>
                                    </td>
                                </tr>
                                <tr style="border-top: 1px solid silver">
                                    </td>
                                    <td class="bold left" colspan="5" style="text-align: left">
                                        Load Amount:
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 30px">
                                        1000
                                    </td>
                                    <td>
                                        x
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLoad_Note_1000" CssClass="Load_Note_1000 right courier" Text='<%# Bind("Load_Note_1000")%>'
                                            Width="50px" runat="server"></asp:TextBox>
                                        <input type="hidden" id="hidInstruction_Note_1000" value='<%# Eval("Instruction_Note_1000")%>' />
                                    </td>
                                    <td>
                                        =
                                    </td>
                                    <td>
                                        <span id='lblLoad_Note_1000_Amount'>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_Note_1000_Amount"))%>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        500
                                    </td>
                                    <td>
                                        x
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLoad_Note_500" CssClass="Load_Note_500 right courier" Text='<%# Bind("Load_Note_500")%>'
                                            Width="50px" runat="server"></asp:TextBox>
                                        <input type="hidden" id="hidInstruction_Note_500" value='<%# Eval("Instruction_Note_500")%>' />
                                    </td>
                                    <td>
                                        =
                                    </td>
                                    <td>
                                        <span id='lblLoad_Note_500_Amount'>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_Note_500_Amount"))%>
                                        </span>
                                    </td>
                                </tr>
                                <tr style="border-top: 1px solid silver">
                                    </td>
                                    <td class="bold" colspan="5">
                                        <span id='lblLoad_TotalAmount'>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_TotalAmount"))%>
                                        </span>
                                    </td>
                                </tr>
                                <tr style="border-top: 1px solid silver">
                                    <td class="bold" colspan="5">
                                        After Load Amount: <span id='lblTotalAmount'>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("TotalAmount"))%>
                                        </span>
                                    </td>
                                </tr>
                            </table>
                            <asp:TextBox ID="txtComment" placeholder="branch comment" Width="200px" Text='<%# Bind("Load_Comment") %>'
                                runat="server"></asp:TextBox>
                            <br />
                            <asp:Button runat="server" ID="cmdUpdate" CommandName="Update" Text="Save Info" />
                            <asp:ConfirmButtonExtender runat="server" ID="conUpdate" TargetControlID="cmdUpdate"
                                ConfirmText="Do you want to Save the Cash Loading Information?">
                            </asp:ConfirmButtonExtender>
                            <asp:Button runat="server" ID="cmdCancel" CommandName="Cancel" CausesValidation="false"
                                Text="Cancel" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Load_Comment" HeaderText="Comment" SortExpression="Load_Comment"
                        ReadOnly="true" />
                    <asp:TemplateField HeaderText="Loaded on" SortExpression="Load_DT">
                        <ItemTemplate>
                            <div>
                                <div title='<%# TrustControl1.ToDateTimeTitle(Eval("Load_DT")) %>'>
                                    <%# TrustControl1.ToRecentDateTime(Eval("Load_DT"))%>
                                    <div class='time-small'>
                                        <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("Load_DT")) %>'></time>
                                    </div>
                                </div>
                                <uc2:EMP ID="EMP3" runat="server" Username='<%# Eval("Load_By") %>' Prefix="By: " />
                            </div>
                            <div class='update-div <%# Eval("Load_Info_UpdateDT").ToString() ==  "" ? "hide" : "" %>'>
                                <div title='<%# TrustControl1.ToDateTimeTitle(Eval("Load_Info_UpdateDT")) %>'>
                                    <%# Eval("Load_Info_UpdateDT","Edit:")%>
                                    <%# TrustControl1.ToRecentDateTime(Eval("Load_Info_UpdateDT"))%>
                                    <div class='time-small'>
                                        <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("Load_Info_UpdateDT")) %>'></time>
                                    </div>
                                </div>
                                <uc2:EMP ID="EMP4" runat="server" Username='<%# Eval("Load_Info_UpdateBy") %>' Prefix="By: " />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Confirm On" SortExpression="Load_ConfirmDT">
                        <ItemTemplate>
                            <div>
                                <div title='<%# TrustControl1.ToDateTimeTitle(Eval("Load_ConfirmDT")) %>'>
                                    <%# TrustControl1.ToRecentDateTime(Eval("Load_ConfirmDT"))%>
                                    <div class='time-small'>
                                        <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("Load_ConfirmDT")) %>'></time>
                                    </div>
                                </div>
                                <uc2:EMP ID="EMP5" runat="server" Username='<%# Eval("Load_ConfirmBy") %>' Prefix="By: " />
                            </div>
                            <div style="text-align: center">
                                <asp:LinkButton ID="lnkConfirm" CommandName="Confirm" Visible='<%# (bool)Eval("ConfirmBtnVisible") %>'
                                    runat="server" Text="Confirm Cash Load" CssClass="Button" CommandArgument='<%# Eval("ID") %>'></asp:LinkButton>
                                <asp:ConfirmButtonExtender runat="server" ID="con_lnkConfirm" TargetControlID="lnkConfirm"
                                    ConfirmText="Do you want to Confirm the Cash Loading? (Edit is not allowed after confirmation)">
                                </asp:ConfirmButtonExtender>
                            </div>
                            <div class='<%# (Eval("ConfirmBtnVisible").ToString() == "True" ? "" : "hide") %>'>
                                <%--<a href='SettlementFileDownload.aspx?batchid=<%# Eval("ID") %>'><a target="_blank" href='ATM_Instruction_Print.aspx?id=<%# Eval("ID") %>'><img src="Images/printer-green-icon.png" width="32" height="32" border="0" /></a>--%>
                                <a target="_blank" href='ATM_Instruction_Print.aspx?id=<%# Eval("ID") %>'>
                                    <img src="Images/printer-green-icon.png" width="32" height="32" border="0" /></a>
                            </div>
                        </ItemTemplate>
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
                SelectCommand="s_ATM_Load_Browse" SelectCommandType="StoredProcedure" UpdateCommand="s_ATM_Load_Info_Update"
                UpdateCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected" OnUpdated="SqlDataSource1_Updated">
                <SelectParameters>
                    <asp:ControlParameter ControlID="dboBranch" Name="FeedingBranch" PropertyName="SelectedValue"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="dboStatus" Name="Status" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:ControlParameter ControlID="dboIsLatest" Name="isLatest" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:ControlParameter ControlID="txtSearch" Name="Filter" PropertyName="Text" Type="String"
                        DefaultValue="*" />
                    <asp:SessionParameter Name="EmpBranch" SessionField="BRANCHID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Load_Note_1000" Type="Int32" />
                    <asp:Parameter Name="Load_Note_500" Type="Int32" />
                    <asp:Parameter Name="Load_Comment" Type="String" />
                    <asp:Parameter Name="AtmID" Type="String" />
                    <asp:Parameter Name="ID" Type="Int32" />
                    <asp:SessionParameter Name="Load_By" SessionField="EMPID" />
                    <asp:SessionParameter Name="Load_Branch" SessionField="BRANCHID" />
                    <asp:Parameter Name="Done" Type="Boolean" DefaultValue="false" Direction="InputOutput" />
                    <asp:Parameter Name="Msg" Type="String" DefaultValue=" " Size="255" Direction="InputOutput" />
                    <asp:Parameter Name="Unload_Note_1000" Type="Int32" />
                    <asp:Parameter Name="Unload_Note_500" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
            <%-------------------------------Start Modal-----------------------------------------------------------%>
            <span style="visibility: visible">
                <br />
                <br />
                <asp:Button runat="server" ID="cmdPopup" Text="Add New Cash Load" 
                onclick="cmdPopup_Click" Visible="false" /></span>
            <asp:Panel ID="ModalPanel" runat="server" CssClass="Panel1">
                <div>
                    <table width="100%">
                        <tr>
                            <td style="font-size: 120%; font-weight: bold">
                                New Cash Load
                            </td>
                            <td align="right">
                                <asp:Image ID="ModalClose" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close"
                                    Style="cursor: pointer" Width="21px" Height="21px" />
                            </td>
                        </tr>
                    </table>
                    <asp:DetailsView ID="DetailsViewforModal" runat="server" BackColor="White" BorderColor="#DEDFDE"
                        BorderStyle="Solid" CellPadding="5" DefaultMode="Insert" ForeColor="Black" AutoGenerateRows="False"
                        DataSourceID="SqlDataSource2">
                        <FooterStyle BackColor="#CCCC99" />
                        <RowStyle BackColor="#F7F7DE" VerticalAlign="Middle" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <Fields>
                            <asp:TemplateField HeaderText="Atm" SortExpression="AtmID" >
                                <ItemTemplate>
                                    <asp:Label ID="lblAtmID" runat="server" Text='<%# Bind("AtmID") %>'></asp:Label>
                                    <div title='<%# Eval("ID") %>'>
                                        <%# (Eval("isLatest").ToString() == "True" ? "<img src='Images/new.gif' width=35' height='22' >" : "")%></div>
                                </ItemTemplate>
                                <InsertItemTemplate>
                                
                                    <asp:DropDownList ID="cbo_ATMs_Without_HO_Instraction" runat="server" 
                                        DataSourceID="SqlDataSource_ATM_List_Without_HO_Instraction" 
                                        DataTextField="Name" DataValueField="AtmID"  SelectedValue='<%# Bind("AtmID") %>' >
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource_ATM_List_Without_HO_Instraction" 
                                        runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" 
                                        SelectCommand="s_ATM_List_Without_HO_Instraction" 
                                        SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cash Load Information" SortExpression="Load_TotalAmount"
                                ShowHeader="false">
                                <EditItemTemplate>
                                    <table class='cash-table'>
                                        <tr>
                                            </td>
                                            <td class="bold left" colspan="5" style="text-align: left">
                                                Before Load Amount:
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                1000
                                            </td>
                                            <td>
                                                x
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUnload_Note_1000" CssClass="Unload_Note_1000 right courier" Text='<%# Bind("Unload_Note_1000")%>'
                                                    Width="50px" runat="server"></asp:TextBox>
                                                <input type="hidden" id="hidUnload_Note_1000" value='<%# Eval("Unload_Note_1000")%>' />
                                            </td>
                                            <td>
                                                =
                                            </td>
                                            <td>
                                                <span id='lblUnload_Note_1000_Amount'>
                                                    <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Unload_Note_1000_Amount"))%>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                500
                                            </td>
                                            <td>
                                                x
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUnload_Note_500" CssClass="Unload_Note_500 right courier" Text='<%# Bind("Unload_Note_500")%>'
                                                    Width="50px" runat="server"></asp:TextBox>
                                                <input type="hidden" id="hidUnload_Note_500" value='<%# Eval("Unload_Note_500")%>' />
                                            </td>
                                            <td>
                                                =
                                            </td>
                                            <td>
                                                <span id='lblUnload_Note_500_Amount'>
                                                    <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Unload_Note_500_Amount"))%>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr style="border-top: 1px solid silver">
                                            <td class="bold" colspan="5">
                                                <span id='lblUnload_TotalAmount'>
                                                    <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Unload_TotalAmount"))%>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr style="border-top: 1px solid silver">
                                            </td>
                                            <td class="bold left" colspan="5" style="text-align: left">
                                                Load Amount:
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding-left: 30px">
                                                1000
                                            </td>
                                            <td>
                                                x
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtLoad_Note_1000" CssClass="Load_Note_1000 right courier" Text='<%# Bind("Load_Note_1000")%>'
                                                    Width="50px" runat="server"></asp:TextBox>
                                                <input type="hidden" id="hidInstruction_Note_1000" value='<%# Eval("Instruction_Note_1000")%>' />
                                            </td>
                                            <td>
                                                =
                                            </td>
                                            <td>
                                                <span id='lblLoad_Note_1000_Amount'>
                                                    <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_Note_1000_Amount"))%>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                500
                                            </td>
                                            <td>
                                                x
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtLoad_Note_500" CssClass="Load_Note_500 right courier" Text='<%# Bind("Load_Note_500")%>'
                                                    Width="50px" runat="server"></asp:TextBox>
                                                <input type="hidden" id="hidInstruction_Note_500" value='<%# Eval("Instruction_Note_500")%>' />
                                            </td>
                                            <td>
                                                =
                                            </td>
                                            <td>
                                                <span id='lblLoad_Note_500_Amount'>
                                                    <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_Note_500_Amount"))%>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr style="border-top: 1px solid silver">
                                            </td>
                                            <td class="bold" colspan="5">
                                                <span id='lblLoad_TotalAmount'>
                                                    <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_TotalAmount"))%>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr style="border-top: 1px solid silver">
                                            <td class="bold" colspan="5">
                                                After Load Amount: <span id='lblTotalAmount'>
                                                    <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("TotalAmount"))%>
                                                </span>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:TextBox ID="txtComment" placeholder="branch comment" Width="200px" Text='<%# Bind("Load_Comment") %>'
                                        runat="server"></asp:TextBox>
                                    <br />
                                    <asp:Button runat="server" ID="cmdInsert" CommandName="Insert" Text="Save Info" />
                                    <asp:ConfirmButtonExtender runat="server" ID="conInsert" TargetControlID="cmdInsert"
                                        ConfirmText="Do you want to Save the Cash Loading Information?">
                                    </asp:ConfirmButtonExtender>
                                    <asp:Button runat="server" ID="cmdCancel" CommandName="Cancel" CausesValidation="false"
                                        Text="Cancel" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:DetailsView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        InsertCommand="s_ATM_NewDataInsert" InsertCommandType="StoredProcedure" 
                        oninserted="SqlDataSource2_Inserted">
                        <InsertParameters>
                            <asp:Parameter Name="Load_Note_1000" Type="Int32" />
                            <asp:Parameter Name="Load_Note_500" Type="Int32" />
                            <asp:Parameter Name="Load_Comment" Type="String" />
                             <asp:Parameter Name="AtmID" Type="String" />
                            <%--<asp:Parameter Name="ID" Type="Int32" />--%>
                            <asp:SessionParameter Name="Load_By" SessionField="EMPID" />
                            <asp:SessionParameter Name="Load_Branch" SessionField="BRANCHID" />
                            <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" />
                            <asp:Parameter Name="Done" Type="Boolean" DefaultValue="false" Direction="InputOutput" />
                            <asp:Parameter Name="Msg" Type="String" DefaultValue=" " Size="255" Direction="InputOutput" />
                            <asp:Parameter Name="Unload_Note_1000" Type="Int32" />
                            <asp:Parameter Name="Unload_Note_500" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>
            <div>
                <asp:Button ID="cmdShowModalHidden" runat="server" Text="Add New Cash Load" />
            </div>
            <asp:ModalPopupExtender ID="modal" runat="server" CancelControlID="ModalClose" TargetControlID="cmdShowModalHidden"
                PopupControlID="ModalPanel" BackgroundCssClass="ModalPopupBG" PopupDragHandleControlID="ModalTitleBar"
                RepositionMode="RepositionOnWindowResize" X="-1" Y="1" CacheDynamicResults="False"
                Drag="false">
            </asp:ModalPopupExtender>
            <%-----------------------------------------------------End Modal------------------------------------------------%>
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
