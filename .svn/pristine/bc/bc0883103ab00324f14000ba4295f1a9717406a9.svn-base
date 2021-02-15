<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CreditCard_Summary.aspx.cs" Inherits="CreditCard_Summary" %>

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
    Credit Card Summary Report
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server">
                <table class="Panel1 ui-corner-all" style="display: inline-block">

                    <tr>
                        <td>Issue Date:                        
                            <asp:TextBox ID="txtIssueDateFrom" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                            to                        
                            <asp:TextBox ID="txtIssueDateTo" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>

                            <b>Issue Branch:</b>
                            <asp:DropDownList ID="DropDownListIssueBranch" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                DataSourceID="SqlDataSourceIssueBranch" DataTextField="BranchName" DataValueField="BranchID"
                                OnDataBound="DropDownListIssueBranch_DataBound">
                                <asp:ListItem Value="-1" Text="All Branches"></asp:ListItem>
                                <asp:ListItem Value="1" Text="Head Office"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSourceIssueBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] where Branchid &lt;&gt; 1 order by BranchName"></asp:SqlDataSource>

                            <asp:Button ID="cmdFilter" runat="server" Font-Bold="true" Text="Show" Width="80px"
                                OnClick="cmdFilter_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="BranchName" DataSourceID="SqlDataSource2" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True"
                EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:BoundField DataField="BranchName" HeaderText="Branch Name" />
                    <asp:BoundField DataField="PREPAID CARD" HeaderText="PREPAID CARD" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="HAJJ CARD" HeaderText="HAJJ CARD" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="PIN REISSUE" HeaderText="PIN REISSUE" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="SUPPLY CARD" HeaderText="SUPPLY CARD" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="REISSUE CARD" HeaderText="REISSUE CARD" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="NEW CARD" HeaderText="NEW CARD" ItemStyle-HorizontalAlign="Center" />
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_CreditCard_Summary_Search" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource2_Selected">
                <SelectParameters>
                    <asp:ControlParameter Name="IssueBranch" ControlID="DropDownListIssueBranch" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" DefaultValue="-1" />
                    <asp:ControlParameter ControlID="txtIssueDateFrom" Name="IssueDateFrom" PropertyName="Text" DefaultValue="01/01/1900" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtIssueDateTo" Name="IssueDateTo" PropertyName="Text" Type="DateTime" DefaultValue="01/01/1900" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
            <br />

            <asp:Button ID="Button1" runat="server" Text="Download Summary XLSX" Width="210px" OnClick="Button1_Click1"
                Height="30px" Font-Bold="true" />


            <br />
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="Button1" />
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
