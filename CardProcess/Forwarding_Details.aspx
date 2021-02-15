<%@ Page Title="" Language="C#" AutoEventWireup="true" 
    CodeFile="Forwarding_Details.aspx.cs" Inherits="Forwarding_Details" Culture="en-NZ" ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="CSS/StyleSheet.css?rand=1" rel="stylesheet" type="text/css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <uc1:TrustControl ID="TrustControl1" runat="server" />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" ShowFooter="true"
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE"
                        BorderStyle="None" BorderWidth="1px" CellPadding="4" CssClass="Grid"
                        DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="Vertical"
                        OnDataBound="GridView1_DataBound">
                        <FooterStyle BackColor="#CCCC99" />
                        <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                        <Columns>
                            <%--<asp:BoundField DataField="#" HeaderText="#" 
                            SortExpression="#" ItemStyle-CssClass="SLCOL" />--%>
                            <asp:TemplateField HeaderText="SL">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ForwardingBranch" HeaderText="Branch"
                                SortExpression="ForwardingBranch" />
                            <asp:BoundField DataField="BranchName" HeaderText="Delivery Branch Name"
                                SortExpression="BranchName" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Total" HeaderText="Total Cards"
                                ReadOnly="True" SortExpression="Total" />
                            <asp:BoundField DataField="TotalReceived" HeaderText="Total Received"
                                ReadOnly="True" SortExpression="TotalReceived" />
                            <asp:BoundField DataField="TotalPending" HeaderText="Total Pending"
                                ReadOnly="True" SortExpression="TotalPending" />
                        </Columns>
                        <EmptyDataTemplate>No Data Found.</EmptyDataTemplate>
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                        <FooterStyle HorizontalAlign="Center" Font-Bold="true" />
                        <EmptyDataRowStyle Font-Size="XX-Large" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                        ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="s_Forwarding_Details" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="BatchID" QueryStringField="id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:Label Font-Names="Arial" runat="server" ID="lblStatus" Text="" Font-Size="Small"></asp:Label>
                    <br />
                    <br />
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
        </div>
    </form>
</body>
</html>
