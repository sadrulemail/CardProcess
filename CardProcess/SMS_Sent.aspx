<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SMS_Sent.aspx.cs" Inherits="SMS_Sent" EnableViewState="false" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    SMS Archive
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <table class="Panel1 ui-corner-all">
                <tr>

                    <td>
                        <asp:TextBox ID="txtFilter" runat="server" Watermark="enter text to filter" Width="200px" onfocus="this.select()"></asp:TextBox>
                    </td>
                    <td>Status:
                    </td>
                    <td>
                        <asp:DropDownList ID="cboStatus" runat="server" AutoPostBack="True" OnSelectedIndexChanged="cboStatus_SelectedIndexChanged">
                            <asp:ListItem Value="SENT">SENT</asp:ListItem>
                            <asp:ListItem Value="OUTBOX">PENDING</asp:ListItem>
                            <asp:ListItem Value="INVALID">REJECTED</asp:ListItem>
                            <asp:ListItem Value="FAILED">FAILED</asp:ListItem>
                            <asp:ListItem Value="-1">ALL SMS</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>Batch:
                        <asp:TextBox ID="txtBatch" runat="server" Text="" placeholder="batch id" Width="80px"></asp:TextBox>
                    </td>

                    <td>Top:
                        <asp:DropDownList ID="ddlTop" runat="server" AutoPostBack="true">
                            <asp:ListItem Value="100" Text="100"></asp:ListItem>
                            <asp:ListItem Value="500" Text="500"></asp:ListItem>
                            <asp:ListItem Value="1000" Text="1 k"></asp:ListItem>
                            <asp:ListItem Value="5000" Text="5 k"></asp:ListItem>
                            <asp:ListItem Value="10000" Text="10 k"></asp:ListItem>
                            <asp:ListItem Value="50000" Text="50 k"></asp:ListItem>
                            <asp:ListItem Value="100000" Text="1 lac"></asp:ListItem>
                            <asp:ListItem Value="500000" Text="5 lac"></asp:ListItem>
                            <asp:ListItem Value="1000000" Text="10 lac"></asp:ListItem>
                            <asp:ListItem Value="-1" Text="All"></asp:ListItem>
                        </asp:DropDownList></td>
                    <td>
                        <asp:Button ID="cmdFilter" runat="server" Text="Filter" Width="80px" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1"
                ForeColor="Black" GridLines="Both" Style="font-size: small" AllowPaging="True"
                PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30" CssClass="Grid"
                AllowSorting="True" PagerSettings-Position="TopAndBottom">
                <PagerSettings Position="TopAndBottom" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="ID" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" ItemStyle-HorizontalAlign="Center"
                        HtmlEncode="false">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Received On" SortExpression="Received On" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <span title='<%# Eval("Received On")%>'>
                                <%# TrustControl1.ToRelativeDate(Eval("Received On")) %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Received SMS" HeaderText="Received SMS" SortExpression="Received SMS"
                        HtmlEncode="false" />
                    <asp:BoundField DataField="Sent SMS" HeaderText="Sent SMS" SortExpression="Sent SMS"
                        HtmlEncode="false" />
                    <asp:TemplateField HeaderText="Processed On" SortExpression="Processed On" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <span title='<%# Eval("Processed On")%>'>
                                <%# TrustControl1.ToRelativeDate(Eval("Processed On"))%></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="SentDT" SortExpression="SentDT" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <span title='<%# Eval("SentDT")%>'>
                                <%# TrustControl1.ToRelativeDate(Eval("SentDT"))%></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ModemID" HeaderText="ModemID" SortExpression="ModemID"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Batch" HeaderText="Batch" SortExpression="Batch"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="By" SortExpression="By" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("By") %>' Position="Left" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_SMS_Outbox_Card_Activation" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="cboStatus" Name="Status" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:ControlParameter ControlID="ddlTop" Name="Top" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:ControlParameter ControlID="txtFilter" Name="Filter" PropertyName="Text" DefaultValue=""
                        ConvertEmptyStringToNull="false" Type="String" />
                    <asp:ControlParameter Name="Batch" ControlID="txtBatch" DefaultValue="-1" PropertyName="Text" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
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