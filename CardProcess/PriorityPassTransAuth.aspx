<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PriorityPassTransAuth.aspx.cs" Inherits="PriorityPassTransAuth" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Priority Pass Trans Authorization
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
                            <asp:TextBox ID="txtYMID" runat="server" Width="80px" placeholder="yyyymm"></asp:TextBox>
                        </td>
                        <td>Authorize:</td>
                        <td>
                            <asp:DropDownList ID="ddlAuthorize" runat="server" AppendDataBoundItems="true" AutoPostBack="true">
                                <asp:ListItem Value="0" Text="Pending"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Completed"></asp:ListItem>
                                <asp:ListItem Value="2" Text="All"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Show" Width="80px" />

                        </td>
                    </tr>
                </table>
            </div>
            <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="ID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True" OnRowCommand="GridView1_RowCommand"
                EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />                    
                    <asp:TemplateField HeaderText="Billing Month" SortExpression="BillingMonth" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("BillingMonth")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Card Info" SortExpression="CardNo" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("CardNo","<div><b>Card No.:</b>{0}</div>") %>
                            <%# Eval("CustomerName","<div><b>Customer Name:</b>{0}</div>")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Other Info" SortExpression="LoungeName" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("LoungeName","<div><b>Lounge Name:</b>{0}</div>") %>
                            <%# Eval("Country","<div><b>Country:</b>{0}</div>")%>
                            <%# Eval("Terminal","<div><b>Terminal:</b>{0}</div>") %>
                            <%# Eval("City","<div><b>City:</b>{0}</div>")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>                  
                    <asp:TemplateField HeaderText="Visit Date" SortExpression="VisitDate" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("VisitDate","{0:dd/MM/yyyy}<br/>") %>
                            <span class="time-small" title='<%# Eval("VisitDate", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("VisitDate","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="No. Of Visit Member" SortExpression="NoOfVisitMember" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("NoOfVisitMember")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="No. Of Visit Guest" SortExpression="NoOfVisitGuest" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("NoOfVisitGuest")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="BillAmount" SortExpression="Bill Amount" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("BillAmount")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remarks" SortExpression="Remarks" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("Remarks")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Inserted on" SortExpression="InsertDT">
                        <ItemTemplate>
                            <div class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Updated on" SortExpression="UpdateDT">
                        <ItemTemplate>
                            <div class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("UpdateBY") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Auth on" SortExpression="AuthorizeDT">
                        <ItemTemplate>                             
                            <div><%# (bool)Eval("Authorize") ? "<img src='Images/tick.png' width='24' >" : "" %></div>
                            <uc2:EMP ID="EMP247572" Username='<%# Eval("AuthorizeBY") %>'
                                runat="server" />
                            <span class="time-small" title='<%# Eval("AuthorizeDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("AuthorizeDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:Button ID="cmdAutorize" runat="server" Text="Authorize" CommandName="Authorize"
                                Visible='<%# (Eval("Authorize").ToString().ToUpper() == "FALSE" ? true : false) %>'
                                CommandArgument='<%# Eval("ID") %>' ToolTip="Authorize" />
                            <asp:ConfirmButtonExtender ID="conAutho" runat="server" ConfirmText="Do you want to Authorize?"
                                TargetControlID="cmdAutorize"></asp:ConfirmButtonExtender>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:Label runat="server" ID="lblStatus" Text=""></asp:Label>
            <asp:Button runat="server" ID="downloadxlsx" Text="Download XLSX" OnClick="downloadxlsx_Click" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_PriorityPassTransaction_Browse" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtYMID" PropertyName="Text" Name="YMID" Type="Int32" />
                    <asp:ControlParameter ControlID="ddlAuthorize" Name="Authorize" PropertyName="SelectedValue" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>
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