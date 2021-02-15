<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="POSMerchantReport.aspx.cs" Inherits="POSMerchantReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .HoverLink {
            color: Blue;
            text-decoration: none;
        }

            .HoverLink:hover {
                color: Blue;
                text-decoration: underline;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    POS Merchant Report
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table class="Panel1 ui-corner-all">
                <tr>
                    <td>
                        <asp:TextBox ID="txtFilter" runat="server" Width="250px" onfocus="this.select()"
                            AutoPostBack="true" placeholder="merchant name"></asp:TextBox>
                    </td>

                    <td>
                        <asp:DropDownList ID="DropDownListBranch" runat="server" DataSourceID="SqlDataSource2" DataTextField="Branchname" DataValueField="BranchID"
                            AppendDataBoundItems="True" AutoPostBack="true">
                            <asp:ListItem Value="-1" Text="All"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboStatus" Width="170px" runat="server" AppendDataBoundItems="True" AutoPostBack="true">
                           <%-- <asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                            <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
                            
                        </asp:DropDownList>

                    </td>
                    <td style="padding-left: 10px">
                        <asp:Button ID="cmdFilter" runat="server" Font-Bold="true" Text="Filter" Width="80px"
                            OnClick="cmdFilter_Click" />
                    </td>
                </tr>
            </table>
            <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="MerchantID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" PageSize="30" AllowSorting="True"
                EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>                    
                    <asp:BoundField DataField="MerchantID" HeaderText="Merchant ID" SortExpression="MerchantID"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="MerchantName" HeaderText="Merchant Name" SortExpression="MerchantName"
                        ItemStyle-HorizontalAlign="left" />
                    <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address"
                        ItemStyle-HorizontalAlign="left" />
                    <asp:BoundField DataField="MobileNo" HeaderText="Mobile" SortExpression="MobileNo"
                        ItemStyle-HorizontalAlign="left" />
                    <asp:BoundField DataField="MerchantShadowAccNo" HeaderText="Merchant <br \> Shadow Acc No"
                        HtmlEncode="false" SortExpression="MerchantShadowAccNo" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="MerchantOrginalAccNo" HeaderText="Merchant <br \> Orginal Acc No"
                        HtmlEncode="false" SortExpression="MerchantOrginalAccNo" ItemStyle-HorizontalAlign="Center" />
                    <asp:TemplateField HeaderText="On-Us <br \> Commission Percent" SortExpression="OnUsCommissionPercent">
                        <ItemTemplate>
                            <%# Eval("OnUsCommissionPercent", "{0:N2} %")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Of-Us <br \>Commission Percent" SortExpression="OfUsCommissionPercent">
                        <ItemTemplate>
                            <%# Eval("OfUsCommissionPercent", "{0:N2} %")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" SortExpression="Status">
                        <ItemTemplate>
                            <%# Eval("Status").ToString() == "True" ? "Active" : "InActive" %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="NoOfPOS" HeaderText="No Of POS" SortExpression="NoOfPOS"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="SIMInfo" HeaderText="SIM Info" SortExpression="SIMInfo"
                        ItemStyle-HorizontalAlign="left" />
                    <asp:BoundField DataField="POSSerialNo" HeaderText="POS Serial No" SortExpression="POSSerialNo"
                        ItemStyle-HorizontalAlign="left" />
                    <asp:TemplateField HeaderText="Inserted on" SortExpression="InsertDT">
                        <ItemTemplate>
                            <div class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                            <uc3:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Updated on" SortExpression="UpdateDT">
                        <ItemTemplate>
                            <div class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                            <uc3:EMP ID="EMP2" runat="server" Username='<%# Eval("UpdateBY") %>' />
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Merchant_Search" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter Name="Filter" ControlID="txtFilter" PropertyName="Text" Type="String"
                        DefaultValue="*" />
                    <asp:ControlParameter Name="Status" ControlID="cboStatus" PropertyName="SelectedValue" Type="String" />
                   <asp:ControlParameter Name="BranchID" ControlID="DropDownListBranch" PropertyName="SelectedValue" DefaultValue="-1" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label><br />
            <asp:Button runat="server" ID="downloadxlsx" Text="Download XLSX" OnClick="downloadxlsx_Click" />
             <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT BranchID ,BranchName FROM   dbo.v_BranchOnly" SelectCommandType="Text" >               
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
