﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PriorityPassBillDownload.aspx.cs" Inherits="PriorityPassBillDownload" EnableSessionState="True" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />

    <asp:GridView ID="GridView2" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="ID" DataSourceID="SqlDataSource4" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" PageSize="30" AllowSorting="True"
                EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                   
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                    <asp:BoundField DataField="ITCLID" HeaderText="ITCL ID" ReadOnly="True" SortExpression="ITCLID"
                        ItemStyle-Font-Bold="true">
                        <ItemStyle Font-Bold="True" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="CardNo" SortExpression="CardNo" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("CardNo") %>
                        
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" Font-Bold="true" Font-Size="Large" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CustomerName" SortExpression="Customer Name" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("CustomerName")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Annual Waive Qty" SortExpression="WaiveQty" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <%# Eval("WaiveQty")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Waive Qty" SortExpression="WaiveQtyget" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <%# Eval("WaiveQtyget")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Date" SortExpression="IssueDate" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("IssueDate","{0:dd/MM/yyyy}") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Expiry Date" SortExpression="ExpiryDate" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("ExpiryDate","{0:dd/MM/yyyy}") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" SortExpression="Status" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("Status","{0}") %>
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
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
            <br />
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM [PriorityPass] with (nolock) where CardNo=@CardNo" >
                <SelectParameters>
                <asp:QueryStringParameter QueryStringField="card" Name="CardNo" Type="String" DefaultValue="*" />
                </SelectParameters>
            </asp:SqlDataSource>



    <asp:GridView ID="GridView3" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="ID" DataSourceID="SqlDataSource5" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True"
                EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    
                   <asp:TemplateField>
                <ItemTemplate>
                    <%#Container.DataItemIndex + 1 %>
                </ItemTemplate>
            </asp:TemplateField>
                   
                    <asp:TemplateField HeaderText="Billing Month" SortExpression="BillingMonth" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("BillingMonth")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Lounge Name" SortExpression="LoungeName" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("LoungeName")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Country" SortExpression="Country" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("Country")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Terminal" SortExpression="Terminal" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("Terminal")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="City" SortExpression="City" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("City")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Visit Date" SortExpression="VisitDate" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("VisitDate","{0:dd/MM/yyyy}") %>
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
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:Label runat="server" ID="Label1" Text=""></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM [PriorityPassTransaction] with (nolock) where CardNo=@CardNo ORDER BY BillingMonth, ID Desc" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="card" Name="CardNo" Type="String" DefaultValue="*" />
                </SelectParameters>
            </asp:SqlDataSource>


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid" ShowFooter="true"
        BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
        CellPadding="4" DataSourceID="SqlDataSource1"
        ForeColor="Black" GridLines="Vertical" Style="font-size: small"
        AllowSorting="True" OnDataBound="GridView1_DataBound">
        <FooterStyle BackColor="#CCCC99" />
        <RowStyle BackColor="#F7F7DE" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <%#Container.DataItemIndex + 1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="BillingMonth" HeaderText="BillingMonth"
                SortExpression="BillingMonth" />
            <asp:BoundField DataField="CustomerName" HeaderText="CustomerName"
                SortExpression="CustomerName" />
            <asp:BoundField DataField="ITCLID" HeaderText="ITCLID"
                SortExpression="ITCLID" />
            <asp:BoundField DataField="CardNo" HeaderText="CardNo"
                SortExpression="CardNo" />

            


            <asp:BoundField DataField="Member" HeaderText="Member"
                SortExpression="Member" />
            <asp:BoundField DataField="Guest" HeaderText="Guest"
                SortExpression="Guest" />
            <asp:BoundField DataField="Total" HeaderText="Total"
                SortExpression="Total" />
            <asp:BoundField DataField="ChargePerVisit" HeaderText="ChargePerVisit"
                SortExpression="ChargePerVisit" />
            <asp:BoundField DataField="TotalAmount" HeaderText="TotalAmount"
                SortExpression="TotalAmount" />
            <asp:BoundField DataField="Waive" HeaderText="Waive"
                SortExpression="Waive" />
            <asp:BoundField DataField="NoOfCharge" HeaderText="NoOfCharge"
                SortExpression="NoOfCharge" />
            <asp:BoundField DataField="ChargeAmount" HeaderText="ChargeAmount"
                SortExpression="ChargeAmount" />
            <asp:TemplateField HeaderText="By" ShowHeader="true" InsertVisible="false">
                <ItemTemplate>
                    <uc2:EMP ID="EMPCreatedBy" runat="server" Username='<%# Eval("BillGeneratedBy") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Generate On" ShowHeader="true" InsertVisible="false">
                <ItemTemplate>
                    <div title='<%# Eval("BillGeneratedDT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                        <%# TrustControl1.ToRecentDateTime(Eval("BillGeneratedDT"))%><br />
                        <time class="timeago time-small-gray" datetime='<%# Eval("BillGeneratedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            No data found.
        </EmptyDataTemplate>
         <FooterStyle BackColor="#CCCC99" Font-Bold="true" HorizontalAlign="Right" />
        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:Label runat="server" ID="lblMsg" Text="" Visible="false"></asp:Label>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="SELECT * FROM dbo.v_PriorityPassTransactionBill with (nolock) WHERE (BillingMonth=@BillingMonth or CardNo=@CardNo) " SelectCommandType="Text" OnSelected="SqlDataSource1_Selected">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="bm" Name="BillingMonth" Type="String" DefaultValue="0" />
            <asp:QueryStringParameter QueryStringField="card" Name="CardNo" Type="String" DefaultValue="*" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="SELECT * FROM dbo.v_PriorityPassTransactionBill with (nolock) WHERE (BillingMonth=@BillingMonth or CardNo =@CardNo) AND ChargeAmount > 0" SelectCommandType="Text">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="bm" Name="BillingMonth" Type="String" DefaultValue="0" />
            <asp:QueryStringParameter QueryStringField="card" Name="CardNo" Type="String" DefaultValue="*" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
        SelectCommand="s_PriorityPassTransactionBillSummary" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="bm" Name="BillingMonth" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
