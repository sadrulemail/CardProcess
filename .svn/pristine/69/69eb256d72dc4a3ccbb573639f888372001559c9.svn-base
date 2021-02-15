<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Atm_Cash_Load_Show.aspx.cs" Inherits="Atm_Cash_Load_Show" %>


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

            <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" CssClass="Grid"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" DataKeyNames="ID" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="True" PageSize="7" PagerSettings-Mode="NumericFirstLast"
                PagerSettings-PageButtonCount="30" PagerSettings-Position="TopAndBottom" OnRowUpdated="GridView1_RowUpdated">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <%# Eval("ID") %>
                            <asp:LinkButton runat="server" ID="lnkEdit" CommandName="Edit" Visible='<%# (bool)Eval("isEditable") %>'><img src="Images/cross.png" width="20" height="20" border="0" title="Delete" /></asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            Delete Reason:
                            <asp:TextBox ID="txtReason" runat="server" Width="400px" Text='<%# Bind("Reason") %>'></asp:TextBox><br />
                            <asp:RequiredFieldValidator runat="server" ID="reqDelete1" ControlToValidate="txtReason" ForeColor="Red">Enter delete reason</asp:RequiredFieldValidator>
                            <br />
                            <asp:Button runat="server" ID="cmdDelete" Text="Delete" CommandName="Update" />
                            <asp:LinkButton runat="server" ID="Button1" Text="Cancel" CommandName="Cancel" CausesValidation="false" />
                            <asp:ConfirmButtonExtender runat="server" ID="conDelete1" TargetControlID="cmdDelete" ConfirmText="Do you want to Delete?" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Atm ID" SortExpression="AtmID">
                        <ItemTemplate>
                            <asp:Label ID="lblAtmID" runat="server" Text='<%# Eval("AtmID") %>'></asp:Label>
                            <div title='<%# Eval("ID") %>'>
                                <%# (Eval("isLatest").ToString() == "True" ? "<img src='Images/new.gif' width=35' height='22' >" : "")%>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ATM Name/ Feeding Branch" SortExpression="AtmName">
                        <ItemTemplate>
                            <div style="font-weight: bold">
                                <%# Eval("AtmName") %>
                            </div>
                            <div style="color: Gray" title="Feeding Branch">
                                <%# Eval("FeedingBranchName")%>
                                <%# Eval("FeedingBranch","({0})")%>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cash Load Instruction" SortExpression="Instruction_TotalAmount">
                        <ItemTemplate>
                            <table class='cash-table <%# (bool)Eval("isVisibleCashLoadInstruction") == true ? "" : "hide" %>' width="100%">
                                <tr>
                                    <td>1000
                                    </td>
                                    <td>x
                                    </td>
                                    <td>
                                        <%# Eval("Instruction_Note_1000")%>
                                    </td>
                                    <td>=
                                    </td>
                                    <td>
                                        <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Instruction_Note_1000_Amount"))%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>500
                                    </td>
                                    <td>x
                                    </td>
                                    <td>
                                        <%# Eval("Instruction_Note_500")%>
                                    </td>
                                    <td>=
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
                                        <td>1000
                                        </td>
                                        <td>x
                                        </td>
                                        <td>
                                            <%# Eval("Unload_Note_1000")%>
                                        </td>
                                        <td>=
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
                                        <td>500
                                        </td>
                                        <td>x
                                        </td>
                                        <td>
                                            <%# Eval("Unload_Note_500")%>
                                        </td>
                                        <td>=
                                        </td>
                                        <td>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Unload_Note_500_Amount"))%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1000
                                        </td>
                                        <td>x
                                        </td>
                                        <td>
                                            <%# Eval("Load_Note_1000")%>
                                        </td>
                                        <td>=
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
                                        <td>500
                                        </td>
                                        <td>x
                                        </td>
                                        <td>
                                            <%# Eval("Load_Note_500")%>
                                        </td>
                                        <td>=
                                        </td>
                                        <td>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_Note_500_Amount"))%>
                                        </td>
                                    </tr>
                                    <tr style="border-top: 1px solid silver" class='<%# (int)Eval("Unload_TotalAmount") > 0 ? "" : "hide" %>'>
                                        <td class="bold" colspan="7">After Load:
                                            <%# Eval("TotalAmount", "{0:N0}")%>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </ItemTemplate>

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
                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("Load_ConfirmDT")) %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("Load_ConfirmDT"))%>
                                <div class='time-small'>
                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("Load_ConfirmDT")) %>'></time>
                                </div>
                            </div>
                            <uc2:EMP ID="EMP5" runat="server" Username='<%# Eval("Load_ConfirmBy") %>' Prefix="By: " />
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
                SelectCommand="s_ATM_Load_Select" SelectCommandType="StoredProcedure" UpdateCommand="s_ATM_Load_Delete"
                UpdateCommandType="StoredProcedure" OnUpdated="SqlDataSource1_Updated">
                <SelectParameters>
                    <asp:SessionParameter Name="EmpBranch" SessionField="BRANCHID" Type="Int32" />
                    <asp:SessionParameter Name="EmpId" SessionField="EmpId" />
                    <asp:QueryStringParameter Name="ID" QueryStringField="id" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:QueryStringParameter Name="ID" QueryStringField="id" />
                    <asp:SessionParameter Name="EmpID" SessionField="EMPID" />
                    <asp:Parameter Name="Reason" Size="255" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>

            <div style="padding-left:50px" id="DeleteHistoryDiv" runat="server">
                <h3>Delete History:</h3>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_ATM_Load_Delete_Log_Select" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource2_Selected" >
                <SelectParameters>
                    <asp:QueryStringParameter Name="ATM_Load_ID" QueryStringField="id" />
                </SelectParameters>
               
            </asp:SqlDataSource>
                <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2" CssClass="Grid"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" DataKeyNames="ID" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="True" PageSize="7" PagerSettings-Mode="NumericFirstLast"
                PagerSettings-PageButtonCount="30" PagerSettings-Position="TopAndBottom">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="Delete Reason" SortExpression="DeleteReason">
                        <ItemTemplate>
                            <%# Eval("DeleteReason") %>
                        </ItemTemplate>
                        <ItemStyle Font-Size="Medium" CssClass="bold" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delete" SortExpression="DeleteDT">
                        <ItemTemplate>
                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("DeleteDT")) %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("DeleteDT"))%>
                                <div class='time-small'>
                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("DeleteDT")) %>'></time>
                                </div>
                            </div>
                            <uc2:EMP ID="EMPDelete" runat="server" Username='<%# Eval("DeleteBy") %>' Prefix="By: " />
                        
                        </ItemTemplate>
                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Atm ID" SortExpression="AtmID">
                        <ItemTemplate>
                            <asp:Label ID="lblAtmID" runat="server" Text='<%# Eval("AtmID") %>'></asp:Label>
                            
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
                            <div>
                                <table class='cash-table'>
                                    <tr class='<%# (int)Eval("Unload_TotalAmount") > 0 ? "" : "hide" %>'>
                                        <td>1000
                                        </td>
                                        <td>x
                                        </td>
                                        <td>
                                            <%# Eval("Unload_Note_1000")%>
                                        </td>
                                        <td>=
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
                                    <tr style="border-bottom: 1px solid silver;">
                                        <td>500
                                        </td>
                                        <td>x
                                        </td>
                                        <td>
                                            <%# Eval("Unload_Note_500")%>
                                        </td>
                                        <td>=
                                        </td>
                                        <td>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Unload_Note_500_Amount"))%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>1000
                                        </td>
                                        <td>x
                                        </td>
                                        <td>
                                            <%# Eval("Load_Note_1000")%>
                                        </td>
                                        <td>=
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
                                        <td>500
                                        </td>
                                        <td>x
                                        </td>
                                        <td>
                                            <%# Eval("Load_Note_500")%>
                                        </td>
                                        <td>=
                                        </td>
                                        <td>
                                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("Load_Note_500_Amount"))%>
                                        </td>
                                    </tr>
                                    <tr style="border-top: 1px solid silver" class='<%# (int)Eval("Unload_TotalAmount") > 0 ? "" : "hide" %>'>
                                        <td class="bold" colspan="7">After Load:
                                            <%# Eval("TotalAmount", "{0:N0}")%>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </ItemTemplate>

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
                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("Load_ConfirmDT")) %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("Load_ConfirmDT"))%>
                                <div class='time-small'>
                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("Load_ConfirmDT")) %>'></time>
                                </div>
                            </div>
                            <uc2:EMP ID="EMP5" runat="server" Username='<%# Eval("Load_ConfirmBy") %>' Prefix="By: " />
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