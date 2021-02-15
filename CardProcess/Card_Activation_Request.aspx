<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Card_Activation_Request.aspx.cs" Inherits="Card_Activation_Request" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .LargeEntryBox
        {
            font-size: xx-large;
            font-family: Courier New;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="Card Activation Request"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <uc2:MyControl ID="MyControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <div style="padding: 10px; font-size: x-large; color: Blue;">
                <asp:Literal ID="lblNotice" runat="server" Text=""></asp:Literal>
                </div>
            <table width="100%">
                <tr>
                    <td>
                        <asp:Panel runat="server" ID="Panel1">
                            <table class="Panel1 ui-corner-all" cellpadding="7"
                                cellspacing="7">
                                <tr>
                                    <td>
                                        <b>Card Number</b>
                                    </td>
                                    <td style="margin-left: 80px">
                                        <asp:TextBox ID="txtCardNumber" CssClass="LargeEntryBox" runat="server" TabIndex="0"
                                            Width="480px" MaxLength="20" AutoPostBack="True" Style="text-align: center" OnTextChanged="txtCardNumber_TextChanged"
                                            onfocus="this.select()"></asp:TextBox>
                                        <asp:FilteredTextBoxExtender ID="txtCardNumber_FilteredTextBoxExtender" runat="server"
                                            Enabled="True" TargetControlID="txtCardNumber" ValidChars="0123456789">
                                        </asp:FilteredTextBoxExtender>
                                    </td>
                                    <td>
                                        <asp:Button ID="cmdOK" runat="server" Text="Add Request" Width="120px" Height="40px"
                                            OnClick="cmdOK_Click" />
                                    </td>
                                </tr>
                            </table>
                            <div style="padding: 20px">
                                <asp:Label ID="lblStatus" runat="server" Text="" Font-Size="X-Large"></asp:Label>
                            </div>
                        </asp:Panel>
                    </td>
                    <td align="left" valign="top">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow"
                            BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSourceCount" ForeColor="Black"
                            GridLines="Both" Width="120px" CssClass="Grid">
                            <Columns>
                                <asp:TemplateField HeaderText="Number of Request Ready to Activate">
                                    <ItemTemplate>
                                        <span style="font-size: xx-large">
                                            <%# Eval("Total") %></span> <a href='Activation_Ready.aspx?branch=<%= Session["BRANCHID"] %>'
                                                style='display: <%# (Eval("Total").ToString() == "0") ? "none" : "''" %>' target="_blank"
                                                title="View Card Numbers">
                                                <br />
                                                View</a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle Font-Size="Small" HorizontalAlign="Center" />
                            <HeaderStyle ForeColor="White" Font-Bold="True" Font-Size="Small" HorizontalAlign="Center" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceCount" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="SELECT COUNT(*) AS Total FROM [CardActivation] WHERE BatchNo = 0 AND [BranchID] = @BranchID">
                            <SelectParameters>
                                <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hidID" runat="server" />
            <asp:HiddenField ID="hidMsg" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_CardActivation_Insert" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCardNumber" Name="CardNumber" PropertyName="Text"
                        Type="String" />
                    <asp:SessionParameter Name="EmpID" SessionField="EMPID" Type="String" />
                    <asp:SessionParameter SessionField="BRANCHID" Name="BranchID" Type="Int32" />
                    <asp:Parameter DefaultValue=" " Direction="InputOutput" Name="Msg" Size="200" Type="String" />
                    <asp:Parameter DefaultValue="false" Direction="InputOutput" Name="Done" Type="Boolean" />
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
