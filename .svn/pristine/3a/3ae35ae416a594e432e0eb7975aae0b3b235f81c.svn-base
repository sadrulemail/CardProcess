<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Card_Search.aspx.cs" Inherits="Card_Search" %>

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

        .form-inline {
            display: inline-block;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Search Card
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="Panel1 ui-corner-all" style="display: inline-block; line-height: 2.5em">

                <div class="form-inline">

                    <asp:TextBox ID="txtFilter" runat="server" Width="150px" onfocus="this.select()"
                        Watermark="enter text to filter" OnTextChanged="txtFilter_TextChanged"></asp:TextBox>
                </div>
                <div class="form-inline">
                    Requested From:
                                            
                                                <asp:DropDownList ID="cboBranch" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                                    DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID"
                                                    OnSelectedIndexChanged="cboBranch_SelectedIndexChanged" OnDataBound="cboBranch_DataBound">
                                                    <asp:ListItem Value="" Text="All Branches"></asp:ListItem>
                                                    <asp:ListItem Value="1" Text="Head Office"></asp:ListItem>
                                                </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                        SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] where Branchid &lt;&gt; 1 order by BranchName"></asp:SqlDataSource>
                </div>



                <div class="form-inline">
                    Delivery To:
                                            
                                                <asp:DropDownList ID="cboDeliveryBranch" runat="server" AppendDataBoundItems="true"
                                                    AutoPostBack="true" DataSourceID="SqlDataSourceBranch" DataTextField="BranchName"
                                                    DataValueField="BranchID">
                                                    <asp:ListItem Text="All Branches" Value=""></asp:ListItem>
                                                    <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>
                                                </asp:DropDownList>
                </div>

                <div class="form-inline">
                    Status:
                                                <asp:DropDownList ID="cboSent" runat="server" AutoPostBack="True" CausesValidation="false"
                                                    OnSelectedIndexChanged="cboSent_SelectedIndexChanged">
                                                    <asp:ListItem Text="Not Sent Items" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="Sent Items Only" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="All Sent and Not Sent" Value=""></asp:ListItem>
                                                </asp:DropDownList>
                </div>

                <div class="form-inline">
                    Request Date:
                                            
                                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                    to
                                          
                                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="Date" Width="80px" AutoPostBack="true"></asp:TextBox>
                </div>

                <div class="form-inline">
                    Card Type:
                                                <asp:DropDownList ID="cboCardType" runat="server" AppendDataBoundItems="true" AutoPostBack="True"
                                                    CausesValidation="false" DataSourceID="SqlDataSourceCardType" DataTextField="CardType"
                                                    DataValueField="CardTypeCode" OnSelectedIndexChanged="cboCardType_SelectedIndexChanged">
                                                    <asp:ListItem Text="All Type Cards" Value=""></asp:ListItem>
                                                </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceCardType" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="SELECT [CardTypeCode], [CardType] FROM [CardTypes] ORDER BY [CardType]"></asp:SqlDataSource>
                </div>
                <div class="form-inline">
                    <asp:DropDownList ID="cboOtherAccounts" runat="server" AutoPostBack="true" CausesValidation="false"
                        OnSelectedIndexChanged="cboOtherAccounts_SelectedIndexChanged">
                        <asp:ListItem Text="All" Value=""></asp:ListItem>
                        <asp:ListItem Text="Has Other A/C" Value="OTHER"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-inline">
                    Show:
                                                <asp:DropDownList ID="cboPageSize" runat="server" AutoPostBack="true" CausesValidation="false">
                                                    <asp:ListItem>500</asp:ListItem>
                                                    <asp:ListItem>1000</asp:ListItem>
                                                    <asp:ListItem>5000</asp:ListItem>
                                                    <asp:ListItem>10000</asp:ListItem>
                                                    <asp:ListItem>50000</asp:ListItem>
                                                    <asp:ListItem>100000</asp:ListItem>
                                                </asp:DropDownList>
                </div>
                <div class="form-inline">
                    <asp:Button ID="cmdFilter" runat="server" Font-Bold="true" Text="Show" Width="80px" />
                </div>

            </div>
            <br />
            <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="ID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" OnRowDataBound="GridView1_RowDataBound"
                AllowSorting="True" OnRowCommand="GridView1_RowCommand" EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:TemplateField HeaderText="Customer Name" SortExpression="FIO" ItemStyle-Font-Size="11pt">
                        <ItemTemplate>
                            <a class="HoverLink" title="Open" target="_blank" href='<%# "Card_AddEdit.aspx?ID=" + Eval("ID") %>'>
                                <%# Eval("FIO")%></a>
                            <%# Eval("Account","<div>{0}</div>") %>
                            <%# Eval("NameOnCard","<div>{0}</div>")%>
                            <%# Eval("CardNumber","<div>{0}</div>")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SEX" HeaderText="SEX" SortExpression="SEX" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Date of Birth" SortExpression="DOB">
                        <ItemTemplate>
                            <%# Eval("DOB", "{0:dd/MM/yyyy}")%>
                            <%-- <br />
                            (<%# TrustControl1.getAge(Eval("DOB"))%>)--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remarks">
                        <ItemTemplate>
                            <a href='AttachmentCard.ashx?aid=<%# Eval("ID") %>&view=yes' target="_blank">
                                <img title="View" loadimg='ShowCardImage.ashx?aid=<%# Eval("ID") %>&key=e' width="80" src="Images/loading.gif" class="AttachmentThumb card-image" />
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cellphone, Phone, Email">
                        <ItemTemplate>
                            <b>Cellphone:</b><br />
                            <%# Eval("Cellphone")%>
                            <br />
                            <b>Phone:</b><br />
                            <%# Eval("Phone")%>
                            <br />
                            <b>Email:</b><br />
                            <%# Eval("Email")%>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:CheckBoxField DataField="SendToProcess" HeaderText="Sent" ItemStyle-HorizontalAlign="Center"
                        SortExpression="SendToProcess">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:BoundField DataField="CardTypeName" HeaderText="Card Type" ItemStyle-HorizontalAlign="Center"
                        SortExpression="CardTypeName">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Insert By" InsertVisible="False" SortExpression="InsertBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP1" Username='<%# Eval("InsertBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Update By" InsertVisible="False" SortExpression="ModifyBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP2" Username='<%# Eval("ModifyBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("ModifyDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("ModifyDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Send By" InsertVisible="False" SortExpression="SendBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP3" Username='<%# Eval("SendBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("SendOn", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("SendOn","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delivery By" InsertVisible="False" SortExpression="DeliveryBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP4" Username='<%# Eval("DeliveryBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("DeliveryDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("DeliveryDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ForwardingBatch" HeaderText="Forwarding Batch" SortExpression="ForwardingBatch" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ForwardingBranch" HeaderText="Forwarding Branch" SortExpression="ForwardingBranch" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_CardProcess_Browse" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter Name="Filter" ControlID="txtFilter" PropertyName="Text" Type="String"
                        ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter Name="SendToProcess" ControlID="cboSent" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter Name="ReqBranch" ControlID="cboBranch" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter Name="DeliveryBranch" ControlID="cboDeliveryBranch" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter Name="CardType" ControlID="cboCardType" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />
                    <asp:ControlParameter Name="OtherAccount" ControlID="cboOtherAccounts" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />
                    <%--<asp:ControlParameter Name="PageSize" ControlID="cboPageSize" PropertyName="SelectedValue"
                        ConvertEmptyStringToNull="false" />--%>
                    <asp:ControlParameter ControlID="txtDateFrom" Name="FromDate" PropertyName="Text"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="txtDateTo" Name="ToDate" PropertyName="Text" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
            <br />
            <br />
            <asp:Button ID="cmdExport" runat="server" Text="Export xlsx" Width="120px" Font-Bold="true"
                Height="30px" OnClick="cmdExport_Click" Visible="false" />
            <br />
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
