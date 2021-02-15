<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ForwardingReceiveAtBranch.aspx.cs" Inherits="ForwardingReceiveAtBranch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc22" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="Card Forwarding Receive at Branch"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server">
                <div class="Panel1 ui-corner-all" style="display: inline-block; vertical-align: top">
                    <b>Branch:</b>
                    <asp:DropDownList ID="cboBranch" runat="server" AppendDataBoundItems="false" DataSourceID="SqlDataSourceBranch"
                        DataTextField="BranchName"
                        DataValueField="BranchID" AutoPostBack="true" CausesValidation="false">
                        <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>
                        <asp:ListItem Text="All Branch" Value="-1"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                        SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranchOnly] where branchid = @branchid or @branchid = 1 order by BranchName">
                        <SelectParameters>
                            <asp:SessionParameter Name="branchid" SessionField="BRANCHID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <b>Forwarding Batch: </b>
                    <asp:TextBox ID="txtFilter" placeholder="batch no" runat="server" Width="80px" onfocus="this.select()" TabIndex="0" MaxLength="10"></asp:TextBox>
                    <asp:Button ID="cmdOK" runat="server" Text="View" Width="100px" CausesValidation="false"
                        OnClick="cmdOK_Click" />
                </div>
                <a href="http://172.22.1.26/blog/3917" target="_blank" style="font-size: large"><b>How to use?</b></a>
            </asp:Panel>
            <br />

            <asp:GridView ID="GridView2" runat="server" BackColor="White" AllowPaging="false"
                PageSize="30" CssClass="Grid" AllowSorting="true" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Both" AutoGenerateColumns="False"
                PagerSettings-PageButtonCount="30" DataSourceID="SqlDataSource2" Style="font-size: small; font-family: Arial" OnRowCommand="GridView2_RowCommand">
                <RowStyle BackColor="#F7F7DE" CssClass="Grid" VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField HeaderText="SL">
                        <ItemTemplate>
                            <%#Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Batch" HeaderText="Batch" ReadOnly="true" />
                    <asp:TemplateField HeaderText="Account" SortExpression="AccountNo" ItemStyle-Font-Size="11pt">
                        <ItemTemplate>
                            <%# Eval("Url","<a class='HoverLink' title='Open' target='_blank' href='{0}'></a>") %>
                            <%# Eval("AccountNo")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CardNumber" HeaderText="Card Number" SortExpression="CardNumber"
                        ReadOnly="true">
                        <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" ReadOnly="true" />
                    <%-- <asp:BoundField DataField="Mobile" HeaderText="Mobile" ReadOnly="true" />
                    <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="true" />--%>
                    <asp:TemplateField HeaderText="Request Branch">
                        <ItemTemplate>
                            <uc22:Branch ID="Branch222" runat="server" BranchID='<%# Eval("ReqBranch") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <%-- <asp:BoundField DataField="ReqTypeName" SortExpression="ReqTypeName" HeaderText="Request Type" ReadOnly="true"
                        ItemStyle-HorizontalAlign="Center" />--%>
                    <asp:TemplateField HeaderText="Forwarding By" InsertVisible="False" SortExpression="DT">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP2" Username='<%# Eval("EmpID") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- <asp:TemplateField HeaderText="Check for Receive">
                        <ItemTemplate>
                            <asp:CheckBox ID="SelectCheckBox" runat="server" AutoPostBack="true"
                                OnCheckedChanged="SelectCheckBox_OnCheckedChanged" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Receive Button" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnedit" runat="server" CommandName="Receive" Visible='<%# (Eval("DeliveryToBranch").ToString()==Session["BRANCHID"].ToString() ? true : false) %>'
                                CommandArgument='<%# Eval("ID") %>' CssClass="bold">Receive</asp:LinkButton>
                            <asp:ConfirmButtonExtender runat="server" ID="con_lnkConfirm" TargetControlID="btnedit"
                                ConfirmText="Do you want to Receive this Card?"></asp:ConfirmButtonExtender>
                            <%-- Visible='<%# Eval("DeliveryToBranch").ToString()=="1"?true:false %>'--%>

                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="ReceiveSMS" Visible='<%# (Eval("DeliveryToBranch").ToString()==Session["BRANCHID"].ToString() ? true : false) %>' CommandArgument='<%# Eval("ID") %>'> 
								<div style='color:red'>Receive without SMS & Email</div>
                            </asp:LinkButton>
                            <asp:ConfirmButtonExtender runat="server" ID="ConfirmButtonExtender1" TargetControlID="LinkButton1"
                                ConfirmText="Do you want to Receive without SMS & Email this Card?"></asp:ConfirmButtonExtender>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="headerLevelCheckBox" Text="Select All" AutoPostBack="true" OnCheckedChanged="headerLevelCheckBox_CheckedChanged" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="rowLevelCheckBox" Text='<%# Eval("ID") %>' Visible='<%# (Eval("isReceived").ToString().ToUpper() == "FALSE" && Eval("DeliveryToBranch").ToString()==Session["BRANCHID"].ToString() ? true : false) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" Font-Names="Arial Narrow" />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                    <div style="border: solid 1px silver; padding: 10px; background-color: #F6F6F6; width: 500px">
                        No Data Found.
                    </div>
                </EmptyDataTemplate>
                <EditRowStyle BackColor="#C5E2FD" />
            </asp:GridView>
            <asp:Label runat="server" ID="lblMsg" Text="" Visible="false"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btn_ReceiveAll" runat="server" Text="Receive Selected Cards Only" OnClick="btn_ReceiveAll_Click" />
            <asp:Button ID="cmdExport" runat="server" Text="Download XLSX" Width="210px" OnClick="cmdExport_Click1"
                Height="30px" Font-Bold="true" />
            <asp:ConfirmButtonExtender ID="con1" ConfirmText="Do you want to receive selected cards listed in the Grid?" runat="server" TargetControlID="btn_ReceiveAll" />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_search_Forwarding_Pending_Cards" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource2_Selected">
                <SelectParameters>
                    <asp:ControlParameter Name="BranchID" ControlID="cboBranch" PropertyName="SelectedValue" DefaultValue="-1" />
                    <%-- <asp:QueryStringParameter QueryStringField="batch" Name="ForwardingBatch"
                        DefaultValue="-1" />--%>
                    <asp:ControlParameter ControlID="txtFilter" Name="ForwardingBatch" PropertyName="Text" DefaultValue="-1" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="cmdExport" />
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
