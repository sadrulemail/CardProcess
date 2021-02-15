<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Export_OnUs_Data.aspx.cs" Inherits="Export_OnUs_Data" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="POS Reconciliation"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hidReqID" runat="server" Value="-1" />
            <asp:Panel ID="Panel1" runat="server">
                <table class="Panel1 ui-corner-all">
                    <tr>
                        <td>
                            <b>Batch No.: </b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtBatch" runat="server" Width="150px" TabIndex="0"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="cmdOK" runat="server" Text="Search" Width="80px" CausesValidation="false"
                                OnClick="cmdOK_Click" />
                        </td>
                    </tr>
                </table>
                <br />
            </asp:Panel>
            <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label>
            <br />
            <br />
            <table style="margin-left: 100px;">
                <tr >
                    <td >
                        <asp:Button ID="btnDownload" runat="server" Text="Shifting Transaction Amount Download" 
                            Visible="false" OnClick="btnDownload_Click" />
                    </td>
                    <td >
                        <asp:Button ID="Button1" runat="server" Text="Commission Transfer Download" 
                            Visible="false" OnClick="Button1_Click" />
                    </td>
                    <td >
                        <asp:Button ID="Button2" runat="server" Text="Transfer Payment Amount Download" Visible="false" 
                            onclick="Button2_Click" />
                    </td>
                </tr>
            </table>
            
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="Black" Style="font-size: small"
                AutoGenerateColumns="False" AllowSorting="True" Visible="false" ShowFooter="true"
                FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right" CssClass="Grid"
                OnRowDataBound="GridView1_RowDataBound">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <%-- <asp:CommandField ShowSelectButton="True" ButtonType="Link" ItemStyle-Font-Bold="true"
                        ItemStyle-ForeColor="Blue" />--%>
                        <asp:TemplateField HeaderText="#" >
                        <ItemTemplate>
                            <%#Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="MerchantName" HeaderText="Merchant Name" ReadOnly="True"
                        SortExpression="MerchantName " ItemStyle-Wrap="false" />
                    <asp:BoundField DataField="MerchantOrginalAccNo" HeaderText="Merchant Orginal <br /> Account No"
                        ReadOnly="True" SortExpression="MerchantOrginalAccNo" HtmlEncode="false" />
                    <asp:BoundField DataField="MerchantShadowAccNo" HeaderText="Merchant Shadow <br /> Account No"
                        ReadOnly="True" HtmlEncode="false" SortExpression="MerchantShadowAccNo" />
                    <asp:BoundField DataField="TransactionAmount" HeaderText="Transaction <br /> Amount"
                        ReadOnly="True" HtmlEncode="false" SortExpression="TransactionAmount" DataFormatString="{0:N2}"
                        ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="PaymentAmount" HeaderText="Payment <br /> Amount" ReadOnly="True"
                        HtmlEncode="false" SortExpression="PaymentAmount" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="TBLCommission" HeaderText="TBL <br /> Commission" ReadOnly="True"
                        HtmlEncode="false" SortExpression="TBLCommission" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="ITCLCommission" HeaderText="ITCL <br /> Commission" ReadOnly="True"
                        HtmlEncode="false" SortExpression="ITCLCommission" DataFormatString="{0:N2}"
                        ItemStyle-HorizontalAlign="Right" />
                </Columns>
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" PageButtonCount="30" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                    No Record(s) Found.
                </EmptyDataTemplate>
            </asp:GridView>
           <%-- <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Search_All_Card_For_Reissue" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtBatch" Name="Filter" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>--%>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnDownload" />
            <asp:PostBackTrigger ControlID="Button1" />
            <asp:PostBackTrigger ControlID="Button2" />
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
