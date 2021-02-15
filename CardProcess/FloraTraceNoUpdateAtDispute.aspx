<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="FloraTraceNoUpdateAtDispute.aspx.cs" Inherits="FloraTraceNoUpdateAtDispute" %>

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
    Flora Trace Number Update at Dispute
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <table class="Panel1 ui-corner-all" style="display: inline-block">
                    <tr>
                        <td>
                            <b>Payment Branch:</b>

                            <asp:DropDownList ID="dboReqBranch" runat="server" AppendDataBoundItems="true" AutoPostBack="true" DataSourceID="SqlDataSource3"
                                DataValueField="BranchID" DataTextField="BranchName" OnDataBound="dboBranchCode_DataBound">
                                <asp:ListItem Value="-1" Text="All"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatordboReqBranch" runat="server"
                                ForeColor="Red" ControlToValidate="dboReqBranch">*</asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="SELECT  [BranchID],[BranchName] FROM [CardData].[dbo].[v_BranchOnly]" SelectCommandType="Text"
                                EnableCaching="True" CacheDuration="60"></asp:SqlDataSource>

                            <b>Approve Date:</b>


                            <asp:TextBox ID="txtReqBegDate" runat="server" Width="80px" CssClass="Date"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ForeColor="Red" ControlToValidate="txtReqBegDate">*</asp:RequiredFieldValidator>

                            <b>to</b>

                            <asp:TextBox ID="txtReqEndDate" runat="server" Width="80px" CssClass="Date"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ForeColor="Red" ControlToValidate="txtReqEndDate">*</asp:RequiredFieldValidator>
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <b>Flora Trn Date:</b>

                            <asp:TextBox ID="txtFloraDT" runat="server" Width="80px" CssClass="Date"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                ForeColor="Red" ControlToValidate="txtFloraDT">*</asp:RequiredFieldValidator>

                            <asp:TextBox ID="txtFloraUserID" runat="server" placeholder="flora entry user" Width="90px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                ForeColor="Red" ControlToValidate="txtFloraUserID">*</asp:RequiredFieldValidator>


                            <asp:TextBox ID="txtBatchNo" runat="server" placeholder="flora batch no" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                ForeColor="Red" ControlToValidate="txtBatchNo">*</asp:RequiredFieldValidator>

                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Show" Width="80px" />
                            <asp:Button ID="btnReset" runat="server" OnClick="btnReset_Click" Text="Reset" Width="80px" />


                        </td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_bank_select" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                AllowPaging="True" PagerSettings-Mode="NumericFirstLast" PagerSettings-PageButtonCount="30"
                PagerSettings-Position="TopAndBottom" CssClass="Grid" BorderColor="#DEDFDE" BorderStyle="Solid"
                BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black"
                AllowSorting="True" Font-Size="Small" DataKeyNames="ID" 
                
                >
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" HorizontalAlign="Center" />
                <Columns>
                    <asp:TemplateField HeaderText="#" SortExpression="Batch">
                        <ItemTemplate>
                            <a href='Dispute.aspx?ID=<%# Eval("ID") %>' target="_blank" class="Link">
                                <span style="color: blue">
                                    <%# Eval("ID") %></span></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="A/C Info" SortExpression="AccNo">
                        <ItemTemplate>
                            <%# Eval("AccNo","<b>{0}</b>") %>
                            <%# Eval("CustomerName", "<div>{0}</div>")%>
                            <div style="color: Silver; font-size: 85%">
                                <%# Eval("CardNumber", "Card: {0}")%>
                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dispute Info" SortExpression="TxnDate">
                        <ItemTemplate>
                            <%# Eval("TxnDate","<div>Txn Date:{0:dd/MM/yyyy}</div>") %>
                            <%# Eval("TxnAmount","<div>Txn Amount:{0}</div>")%>
                            <%# Eval("DisputeAmount","<div>Dispute Amount:<b>{0}</b></div>")%>
                            <%# Eval("BranchName","<div>Payment Branch/Dept.:<b>{0}</b></div>")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Flora Info(Before Update)" SortExpression="traceno">
                        <ItemTemplate>
                            <%# Eval("Flora_traceno","<div>Trace No:<b>{0}</b></div>") %>
                            <%# Eval("tdate","<div>Trans Date:<b>{0:dd/MM/yyyy}</b>")%>
                            <span class="time-small" title='<%# Eval("tdate", "{0:dddd, dd MMMM yyyy}")%>'>
                                <time class="timeago" datetime='<%# Eval("tdate","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                            <%# Eval("amount_tk","<div>Amount:<b>{0}</b>")%>
                            <%# Eval("remark","<div>Remark:{0}")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" Wrap="true" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Flora Users" SortExpression="traceno">
                        <ItemTemplate>
                            <%# Eval("branch_code","<div>Trans Branch:<b>{0}</b>")%>
                            <%# Eval("user_code","<div>Entry User:<b>{0}</b>")%>
                            <%# Eval("pass_user_id","<div>Auth User:<b>{0}</b>")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" Wrap="true" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Posting Info(After Update)" SortExpression="PostingBY">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP124234" Username='<%# Eval("PostingBY") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("PostingDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("PostingDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                            <%# Eval("FloraTransactionNumber","<div>Trace no:{0}")%>
                            <%# Eval("FloraTranDT","<div>Trans Date:{0:dd/MM/yyyy}")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <%-- <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:Button ID="cmdUpdate" runat="server" Text="Update" CommandName="Approve" ValidationGroup="UpdateGrb"
                                Visible='<%# (Eval("Authorize").ToString().ToUpper() == "TRUE" && 
                                    Eval("Approve").ToString().ToUpper() == "TRUE" && 
                                   Session["BRANCHID"].ToString()==Eval("ATM_Branch").ToString() && 
                                   Eval("PostingBY").ToString() == "" && Eval("Flora_traceno").ToString() != "" ? true : false) %>'
                                CommandArgument='<%# Eval("ID") + "|" + Eval("AccNo")+ "|" + Eval("Flora_traceno")+ "|" + Eval("tdate") %>' ToolTip="Update" ClientIDMode="AutoID" />
                            <asp:ConfirmButtonExtender ID="conUpdate" runat="server" ConfirmText="Are you checked before update?"
                                TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <%--<asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="headerLevelCheckBox" Text="Select All" AutoPostBack="true" OnCheckedChanged="headerLevelCheckBox_CheckedChanged" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="rowLevelCheckBox" Text='<%# Eval("ID") %>' Visible='<%# (Eval("Approve").ToString().ToUpper() 
                                    == "TRUE"? true : false) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding: 15px 50px">
                        No record found.
                    </div>
                </EmptyDataTemplate>
                <FooterStyle BackColor="#CCCC99" HorizontalAlign="Center" Font-Bold="true" />
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="30" Position="TopAndBottom" />
                <PagerStyle HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Dispute_Posting_Pending" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtFloraUserID" Name="FloraUserID" PropertyName="Text" Type="Int32" Size="20" />
                    <asp:ControlParameter ControlID="txtBatchNo" Name="BatchNO" PropertyName="Text" Type="String" Size="20" />
                    <asp:ControlParameter ControlID="dboReqBranch" Name="BranchID" PropertyName="SelectedValue" DefaultValue="-1" />
                    <asp:ControlParameter ControlID="txtReqBegDate" Name="DateFrom" PropertyName="Text" DefaultValue="01/01/1900" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtReqEndDate" Name="DateTo" PropertyName="Text" Type="DateTime" DefaultValue="01/01/1900" />
                    <asp:ControlParameter ControlID="txtFloraDT" Name="FloraDT" PropertyName="Text" DefaultValue="01/01/1900" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
            <asp:Button ID="btn_UpdateTraceNum" runat="server" Text="Update Trace Number" OnClick="btn_UpdateTraceNum_Click" Visible="false" />
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
</asp:Content>