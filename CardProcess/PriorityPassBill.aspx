<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PriorityPassBill.aspx.cs" Inherits="PriorityPassBill" Culture="en-NZ" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Priority Pass Bill
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <div>
                <table class="Panel1 ui-corner-all">
                    <tr>
                        <td>YMID:
                        </td>
                        <td>
                            <asp:TextBox ID="txtYMID" runat="server"  Width="80px" placeholder="yyyymm"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Show" Width="80px" />
                        </td>
                    </tr>
                </table>
            </div>
            <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="BillingMonth" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#DEDFDE" PageSize="30"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True"
                EmptyDataText="Data Not Found" OnRowCommand="GridView1_RowCommand">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:TemplateField HeaderText="Billing Month" SortExpression="BillingMonth" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("BillingMonth")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Transaction" SortExpression="TotalTransaction" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("TotalTransaction")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Unauthorize Transaction" SortExpression="TotalUnauthorize" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("TotalUnauthorize")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Member Visit" SortExpression="TotalMemberVisit" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <%# Eval("TotalMemberVisit")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Guest Visit" SortExpression="TotalGuestVisit" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("TotalGuestVisit")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Trns Amount" SortExpression="TotalTrnsAmount" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("TotalTrnsAmount")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Waive" SortExpression="Waive" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("Waive")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bill generated" SortExpression="BillGeneratedBY">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP214" Username='<%# Eval("BillGeneratedBY") %>' runat="server" />
                            <br />
                            <span class="time-small" title='<%# Eval("BillGeneratedDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("BillGeneratedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:Button ID="cmdBill" runat="server" Text="Generate Bill" CommandName="GenerateBill" Visible='<%# (Eval("BillGenerated").ToString().ToUpper() 
                                    == "FALSE" && Session["BRANCHID"].ToString()=="1"? true : false) %>'
                                CommandArgument='<%# Eval("BillingMonth") %>' ToolTip="Generate Bill" />
                            <asp:ConfirmButtonExtender ID="conBill" runat="server" ConfirmText="Do you want to Generate Bill?"
                                TargetControlID="cmdBill"></asp:ConfirmButtonExtender>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download">
                        <ItemTemplate>
                            <div runat="server" id="asdksakdnask" visible='<%# (Eval("BillGenerated").ToString().ToUpper()== "TRUE"? true : false) %>'>
                                <a href='<%# "PriorityPassBillDownload.aspx?type=xlsx&bm=" + Eval("BillingMonth") %>' target="_blank"
                                    class="Link">XLSX</a> | <a href='<%# "PriorityPassBillDownload.aspx?type=bill&bm=" + Eval("BillingMonth") %>' target="_blank"
                                        class="Link">XLSX(Only Bill)</a>
                                | <a href='<%# "PriorityPassBillDownload.aspx?type=view&bm=" + Eval("BillingMonth")%>' target="_blank"
                                    class="Link">View</a>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Summary Download">
                        <ItemTemplate>
                            <div runat="server" id="asdksakdnask1" visible='<%# (Eval("BillGenerated").ToString().ToUpper()== "TRUE"? true : false) %>'>
                                <a href='<%# "PriorityPassBillDownload.aspx?type=xlsxSM&bm=" + Eval("BillingMonth") %>' target="_blank"
                                    class="Link">XLSX</a> 
                               <%-- | <a href='<%# "PriorityPassBillDownload.aspx?type=xlsxST&bm=" + Eval("BillingMonth") %>' target="_blank"
                                        class="Link">XLSX(Including this month)</a>  --%>                              
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>                            
                            <asp:LinkButton ID="DeleteBtn" 
                                Visible='<%# DeleteEnabled(Eval("BillDate"), Eval("CurrentDate")) %>'
                                runat="server" CommandName="Delete1" 
                                CommandArgument='<%# Eval("BillingMonth") %>' 
                                ToolTip="Delete"><img src="Images/cross.png" alt="" />
                            </asp:LinkButton>
                            <asp:ConfirmButtonExtender runat="server" ID="DeleteID" ConfirmText="Do you want to delete bill?"
                                TargetControlID="DeleteBtn"></asp:ConfirmButtonExtender>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:Label runat="server" ID="lblstatus" Text=""></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_PriorityPassBill_Browse" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter Name="YYMM" ControlID="txtYMID" PropertyName="Text" DefaultValue="-1" />
                </SelectParameters>
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
