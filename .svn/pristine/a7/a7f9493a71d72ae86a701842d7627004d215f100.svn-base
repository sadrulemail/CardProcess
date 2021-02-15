<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="New_Reissue_Request.aspx.cs" Inherits="New_Reissue_Request" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc3" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="MyControl.ascx" TagName="MyControl" TagPrefix="uc2" %>
<%@ Register Assembly="skmControls2" Namespace="skmControls2" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="Card Service Request"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hidReqID" runat="server" Value="-1" />
            <asp:HiddenField ID="AcTypes" runat="server" Value="" />
            <asp:Panel ID="Panel1" runat="server">
                <table class="Panel1 ui-corner-all">
                    <tr>
                        <td>
                            <b>Account No./Card No.: </b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFilter" runat="server" Width="150px" TabIndex="0"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="cmdOK" runat="server" Text="Search" Width="80px" OnClick="cmdOK_Click"
                                CausesValidation="false" />
                            <asp:Button ID="CmdNew" runat="server" Text="Reset" Width="80px" OnClick="CmdNew_Click"
                                CausesValidation="false" />
                        </td>
                    </tr>
                </table>
                <br />
            </asp:Panel>
            <div runat="server" id="masterdiv">
                <table>
                    <tr>
                        <td valign="top">
                            <div class="group">
                                <h5>Card Reissue Request Entry</h5>
                                <asp:DetailsView ID="DetailsViewMaster" runat="server" BackColor="White" CssClass="Grid" Visible="true"
                                    BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black"
                                    GridLines="Vertical" DataSourceID="SqlDataSourceMaster" AutoGenerateRows="False"
                                    DataKeyNames="ReqID" DefaultMode="Insert" OnItemInserted="DetailsViewMaster_ItemInserted"
                                    OnDataBound="DetailsViewMaster_DataBound">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Fields>
                                        <asp:BoundField DataField="ReqID" HeaderText="Req ID" InsertVisible="False" ReadOnly="True"
                                            SortExpression="ReqID" ItemStyle-Font-Size="150%" ItemStyle-Font-Bold="true" />
                                        <asp:TemplateField HeaderText="Card Number" SortExpression="CardNumber">
                                            <EditItemTemplate>
                                                <asp:Label ID="lblCardNumber" runat="server" Text='<%# Bind("CardNumber") %>'></asp:Label>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:Label ID="lblCardNumber" runat="server" Text='<%# Bind("CardNumber") %>'></asp:Label>
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <%# Eval("CardNumber")%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CardType" HeaderText="Card Type" InsertVisible="false"
                                            ReadOnly="true" />
                                        <asp:TemplateField HeaderText="Account" SortExpression="Account">
                                            <EditItemTemplate>
                                                <asp:Label ID="lblAccount" runat="server" Text='<%# Bind("Account") %>'></asp:Label>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:Label ID="lblAccount" runat="server" Text='<%# Bind("Account") %>'></asp:Label>
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblAccount" runat="server" Text='<%# Bind("Account") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="true" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ITCL ID">
                                            <EditItemTemplate>
                                                <asp:Label ID="lblITCLID" runat="server" Text='<%# Bind("ITCLID") %>'></asp:Label>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:Label ID="lblITCLID" runat="server" Text='<%# Bind("ITCLID") %>'></asp:Label>
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblITCLID" runat="server" Text='<%# Bind("ITCLID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name On Card" SortExpression="NameOnCard">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtNameOnCard" Width="300px" MaxLength="19" runat="server" Text='<%# Bind("NameOnCard") %>'></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNAMEONCARD"
                                                    ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,19}$"
                                                    Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNAMEONCARD"
                                                    ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                                Max 19 Char
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:TextBox ID="txtNameOnCard" MaxLength="19" Width="300px" runat="server" Text='<%# Bind("NameOnCard") %>'></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtNAMEONCARD"
                                                    ValidationGroup="Part1" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,19}$"
                                                    Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNAMEONCARD"
                                                    ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                                Max 19 Char
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblNameOnCard" Width="300px" runat="server" Text='<%# Bind("NameOnCard") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date of Birth" SortExpression="DOB">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtDOB" CssClass="Date" runat="server" Text='<%# Bind("DOB","{0:dd/MM/yyyy}") %>'
                                                    MaxLength="80" Width="85px"></asp:TextBox>
                                                dd/mm/yyyy
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3343" runat="server" ControlToValidate="txtDOB"
                                ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:TextBox ID="txtDOB" CssClass="Date" runat="server" Text='<%# Bind("DOB","{0:dd/MM/yyyy}") %>'
                                                    MaxLength="80" Width="85px"></asp:TextBox>
                                                dd/mm/yyyy
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3s343" runat="server" ControlToValidate="txtDOB"
                                ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <%# Eval("DOB","{0:dd/MM/yyyy}") %>
                                                <span class="time-small" style="margin-left: 20px" title="Age">
                                                    <%# Common.getAge(Eval("DOB")) %></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtAddress" Width="400px" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator334343433" runat="server" ControlToValidate="txtAddress"
                                                    ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:TextBox ID="txtAddress" Width="400px" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator33324523543" runat="server"
                                                    ValidationGroup="Part1" ControlToValidate="txtAddress" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress" Width="400px" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Email" SortExpression="Email">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' MaxLength="40"
                                                    Width="400px"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" runat="server"
                                                    ControlToValidate="txtEmail" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' MaxLength="40"
                                                    Width="400px"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" runat="server"
                                                    ControlToValidate="txtEmail" ErrorMessage="Invalid Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Mobile" SortExpression="Mobile">
                                            <EditItemTemplate>
                                                <asp:TextBox runat="server" ID="txtMobile" Text='<%# Bind("Mobile") %>' MaxLength="20"
                                                    Width="200px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4dsd" runat="server" ControlToValidate="txtMobile"
                                                    ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{6,15}$"
                                                    ValidationGroup="Part1" ControlToValidate="txtMobile" ErrorMessage="RegularExpressionValidator">Invalid</asp:RegularExpressionValidator>
                                                Ex: 8801XXXXXXXXX
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:TextBox runat="server" ID="txtMobile" Text='<%# Bind("Mobile") %>' MaxLength="20"
                                                    Width="200px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4wewq" runat="server" ControlToValidate="txtMobile"
                                                    ValidationGroup="Part1" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{6,15}$"
                                                    ControlToValidate="txtMobile" ErrorMessage="RegularExpressionValidator" ForeColor="Red">Invalid</asp:RegularExpressionValidator>
                                                Ex: 8801XXXXXXXXX
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblMobile" runat="server" Text='<%# Bind("Mobile") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Insert By" InsertVisible="False" SortExpression="InsertBy">
                                            <ItemTemplate>
                                                <uc3:EMP ID="EMP1" Username='<%# Eval("InsertBy") %>' runat="server" />
                                                <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                                    <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Update By" InsertVisible="False" SortExpression="UpdateBy">
                                            <ItemTemplate>
                                                <uc3:EMP ID="EMP2" Username='<%# Eval("UpdateBy") %>' runat="server" />
                                                <span class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                                    <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ShowHeader="False" ControlStyle-Width="80px">
                                            <EditItemTemplate>
                                                <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" ValidationGroup="Part1"
                                                    CommandName="Update" Text="Update" />
                                                <asp:ConfirmButtonExtender ID="conUpdate" runat="server" ConfirmText="Do you want to Update?"
                                                    TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                                &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="False" ValidationGroup="Part1"
                                                    CommandName="Cancel" Text="Cancel" />
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:Button ID="cmdInsert" runat="server" CausesValidation="True" ValidationGroup="Part1"
                                                    CommandName="Insert" Text="Save" />
                                                <asp:ConfirmButtonExtender ID="conInsert" runat="server" ConfirmText="Do you want to Save?"
                                                    TargetControlID="cmdInsert"></asp:ConfirmButtonExtender>
                                            </InsertItemTemplate>
                                            <ItemTemplate>
                                                <asp:Button ID="cmdEdit" runat="server" Enabled='<%# Eval("SendToProcess").ToString().ToUpper() == "TRUE" ? false : true %>'
                                                    CausesValidation="True" ValidationGroup="Part1" CommandName="Edit" Text="Edit" />
                                                <asp:Button ID="cmdDelete" runat="server" Enabled='<%# Eval("SendToProcess").ToString().ToUpper() == "TRUE" ? false : true %>'
                                                    CausesValidation="True" ValidationGroup="Part1" CommandName="Delete" Text="Delete" />
                                                <asp:ConfirmButtonExtender ID="conDelete" runat="server" ConfirmText="Do you want to Delete?"
                                                    TargetControlID="cmdDelete"></asp:ConfirmButtonExtender>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Fields>
                                    <FooterStyle BackColor="#CCCC99" />
                                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                    <RowStyle BackColor="#F7F7DE" />
                                </asp:DetailsView>
                                <asp:SqlDataSource ID="SqlDataSourceMaster" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                    SelectCommand="s_ServiceRequest_browse"
                                    SelectCommandType="StoredProcedure"
                                    InsertCommand="s_CardServiceRequests_Add_Edit"
                                    InsertCommandType="StoredProcedure"
                                    UpdateCommand="s_CardServiceRequests_Add_Edit"
                                    DeleteCommand="s_CardServiceRequests_Delete"
                                    DeleteCommandType="StoredProcedure"
                                    OnDeleted="SqlDataSourceMaster_OnDeleted"
                                    UpdateCommandType="StoredProcedure"
                                    OnInserted="SqlDataSourceMaster_Inserted"
                                    OnUpdated="SqlDataSourceMaster_Updated"
                                    OnSelected="SqlDataSourceMaster_Selected">
                                    <InsertParameters>
                                        <asp:Parameter Name="CardNumber" Type="String" />
                                        <asp:Parameter Name="Account" Type="String" />
                                        <asp:Parameter Name="NameOnCard" Type="String" />
                                        <asp:Parameter DbType="Date" Name="DOB" />
                                        <asp:Parameter Name="Address" Type="String" />
                                        <asp:Parameter Name="Email" Type="String" />
                                        <asp:Parameter Name="Mobile" Type="String" />
                                        <asp:Parameter Name="ITCLID" Type="String" />
                                        <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                                        <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                                        <asp:Parameter Direction="InputOutput" Name="ReqID" Type="Int32" DefaultValue="0" />
                                        <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hidReqID" Name="ReqID" PropertyName="Value" DefaultValue="-1" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                        <asp:ControlParameter ControlID="hidReqID" Name="ReqID" PropertyName="Value" Type="Int32" />
                                        <asp:Parameter Name="CardNumber" Type="String" />
                                        <asp:Parameter Name="Account" Type="String" />
                                        <asp:Parameter Name="NameOnCard" Type="String" />
                                        <asp:Parameter DbType="Date" Name="DOB" />
                                        <asp:Parameter Name="Address" Type="String" />
                                        <asp:Parameter Name="Email" Type="String" />
                                        <asp:Parameter Name="Mobile" Type="String" />
                                        <asp:SessionParameter Name="UpdateBy" SessionField="EMPID" Type="String" />
                                        <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                                        <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                                        <%-- <asp:Parameter Direction="InputOutput" Name="ReqID" Type="Int32"/>--%>
                                    </UpdateParameters>
                                    <DeleteParameters>
                                        <asp:ControlParameter ControlID="hidReqID" Name="ReqID" PropertyName="Value" DefaultValue="-1" />
                                        <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                                    </DeleteParameters>
                                </asp:SqlDataSource>
                            </div>
                        </td>
                        <td valign="top">
                            <div class="group" runat="server" id="divPending">
                                <h5>Card Reissue Pending Information</h5>
                                <asp:GridView ID="GridView2" runat="server" BackColor="White" BorderColor="#DEDFDE"
                                    BorderStyle="Solid" BorderWidth="1px" CellPadding="6" ForeColor="Black" Style="font-size: small"
                                    AutoGenerateColumns="False" DataSourceID="SqlDataSource2" AllowSorting="True"
                                    CssClass="Grid">
                                    <FooterStyle BackColor="#CCCC99" />
                                    <RowStyle BackColor="#F7F7DE" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="#" SortExpression="ServiceRequestID">
                                            <ItemTemplate>
                                                <a href='New_Reissue_Request.aspx?id=<%# Eval("ServiceRequestID") %>' title="View Request" target="_blank" class='<%# int.Parse(Eval("ServiceRequestID").ToString()) >0 ? "" : "hide" %>'>
                                                    <img src="Images/open.png" /></a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="ITCLID" HeaderText="ITCLID" ReadOnly="True" SortExpression="ITCLID"
                                            ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="Account" HeaderText="Account" ReadOnly="True" SortExpression="Account"
                                            ItemStyle-Wrap="false" />
                                        <asp:BoundField DataField="NameOnCard" HeaderText="Name on Card" ReadOnly="True"
                                            SortExpression="NameOnCard" ItemStyle-CssClass="bold" />

                                        <asp:TemplateField HeaderText="Insert By" InsertVisible="False" SortExpression="InsertBy">
                                            <ItemTemplate>
                                                <uc3:EMP ID="EMP111" Username='<%# Eval("InsertBy") %>' runat="server" />
                                                <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                                    <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
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
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                    SelectCommand="s_CardReissue_Pending_Select" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource2_Selected">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="txtFilter" Name="Account" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="6" ForeColor="Black" Style="font-size: small"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True"
                CssClass="Grid" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                OnDataBound="GridView1_DataBound">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                   

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="lnkSelect" Visible='<%# Eval("AllowReissue") %>' CommandName="Select">Select</asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Font-Bold="true" ForeColor="Blue" />
                    </asp:TemplateField>


                    <asp:BoundField DataField="Account" HeaderText="Account" ReadOnly="True" SortExpression="Account"
                        ItemStyle-Wrap="false" />
                    

                    <asp:TemplateField SortExpression="CardNumber" HeaderText="Card Number"> 
                        <ItemTemplate>
                            <div class='bold'>
                            <asp:Label runat="server" ID="lblCardNumber" Text='<%# Bind("CardNumber") %>'></asp:Label> </div>
                            <%# Eval("CardType","<div>{0}</div>") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:BoundField DataField="NAME ON CARD" HeaderText="Name on Card" ReadOnly="True"
                        SortExpression="NAME ON CARD" ItemStyle-CssClass="bold" />
                    <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status"
                        ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bold" />
                    <asp:TemplateField HeaderText="Created" SortExpression="CREATED" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("CREATED")) %>'>
                                <%# TrustControl1.ToRecentDate(Eval("CREATED"))%>
                                <div class='time-small'>
                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("CREATED")) %>'></time>
                                </div>
                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="DeliveryDT" HeaderText="Delivery DT" ReadOnly="True" SortExpression="DeliveryDT" />
                    <asp:BoundField DataField="Date of Birth" HeaderText="Date of Birth" ReadOnly="True"
                        SortExpression="Date of Birth" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Address" HeaderText="Address" ReadOnly="True" SortExpression="Address"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" ReadOnly="True" SortExpression="Mobile"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="ITCLID" HeaderText="ITCLID" ReadOnly="True" SortExpression="ITCLID"
                        ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Balance" HeaderText="Balance" ReadOnly="True" SortExpression="Balance"
                        ItemStyle-HorizontalAlign="Center" />
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_Search_All_Card_For_Reissue" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtFilter" Name="Filter" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="panel3" runat="server">
                <fieldset class="fieldset" style="width: 500px">
                    <legend class="legend">Apply For Service Request</legend>
                    <asp:DetailsView ID="DetailsView_CardReissue" runat="server" BackColor="White" CssClass="Grid"
                        BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black"
                        GridLines="Vertical" DataSourceID="SqlDataSource_CardReissue" AutoGenerateRows="False"
                        DataKeyNames="ServiceRequestID" DefaultMode="ReadOnly" OnDataBound="DetailsView_CardReissue_DataBound">
                        <AlternatingRowStyle BackColor="White" />
                        <Fields>
                            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" SortExpression="ID"
                                ReadOnly="true" ItemStyle-ForeColor="Silver" HeaderStyle-ForeColor="Silver">
                                <HeaderStyle ForeColor="Silver" />
                                <ItemStyle ForeColor="Silver" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Service Type">
                                <ItemTemplate>
                                    <asp:Label ID="lblServiceType" runat="server" Text='<%# Eval("ServiceDesc") %>'></asp:Label>
                                </ItemTemplate>
                                <InsertItemTemplate>
                                    <asp:DropDownList ID="cboServiceType" runat="server" SelectedValue='<%# Bind("ServiceType") %>'
                                        AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="cboServiceType_SelectedIndexChanged">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Card Reissue" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Pin Reissue" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorServiceType" runat="server"
                                        ValidationGroup="Part2" ControlToValidate="cboServiceType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="cboServiceType" runat="server" SelectedValue='<%# Bind("ServiceType") %>'
                                        AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="cboServiceType_SelectedIndexChanged">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Card Reissue" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="PIN Reissue" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorServiceType1" runat="server"
                                        ValidationGroup="Part2" ControlToValidate="cboServiceType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemStyle Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delivery Branch">
                                <ItemTemplate>
                                    <asp:Label ID="lblDeliveryBranch" runat="server" Text='<%# Eval("branchname") %>'></asp:Label>
                                </ItemTemplate>
                                <InsertItemTemplate>
                                    <asp:DropDownList ID="cboDeliveryBranch" runat="server" SelectedValue='<%# Bind("DeliveryBranchID") %>'
                                        AppendDataBoundItems="true" DataSourceID="SqlDataSource_DeliveryBranch" DataTextField="BranchName"
                                        DataValueField="BranchID">
                                        <%-- <asp:ListItem Text="" Value=""></asp:ListItem>--%>
                                        <asp:ListItem Text="My Current Branch" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorDeliveryBranch" runat="server"
                                        ValidationGroup="Part2" ControlToValidate="cboDeliveryBranch" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="SqlDataSource_DeliveryBranch" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                        SelectCommand="SELECT BranchID,BranchName FROM v_BranchOnly" SelectCommandType="Text"></asp:SqlDataSource>
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="cboDeliveryBranch" runat="server" SelectedValue='<%# Bind("DeliveryBranchID") %>'
                                        DataSourceID="SqlDataSource_DeliveryBranch" DataTextField="BranchName" DataValueField="BranchID"
                                        AppendDataBoundItems="true">
                                        <asp:ListItem Text="My Current Branch" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorDeliveryBranch" runat="server"
                                        ValidationGroup="Part2" ControlToValidate="cboDeliveryBranch" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="SqlDataSource_DeliveryBranch" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                        SelectCommand="SELECT BranchID,BranchName FROM v_BranchOnly" SelectCommandType="Text"></asp:SqlDataSource>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Card Type">
                                <ItemTemplate>
                                    <asp:Label ID="lblCardType" runat="server" Text='<%# Eval("CardTypeNewDesc") %>'></asp:Label>
                                </ItemTemplate>
                                <InsertItemTemplate>
                                    <asp:DropDownList ID="cboCardType" runat="server" SelectedValue='<%# Bind("CardTypeNew") %>'
                                        AppendDataBoundItems="true" DataSourceID="SqlDataSourceCardType" DataTextField="CardType"
                                        DataValueField="CardTypeCode" OnDataBound="cboCardType_DataBound1">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                    <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator4asdas" runat="server" ControlToValidate="cboCardType"
                                        ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>--%>
                                    <asp:SqlDataSource ID="SqlDataSourceCardType" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                        SelectCommand="s_getCardTypes" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="AcTypes" Name="AccTypes" PropertyName="Value" />
                                            <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                                            <asp:Parameter Name="ReqType" Type="String" DefaultValue="R" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="cboCardType" runat="server" SelectedValue='<%# Bind("CardTypeNew") %>'
                                        DataSourceID="SqlDataSourceCardType" DataTextField="CardType" DataValueField="CardTypeCode"
                                        OnDataBound="cboCardType_DataBound">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceCardType" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                        SelectCommand="s_getCardTypes" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="AcTypes" Name="AccTypes" PropertyName="Value" />
                                            <asp:SessionParameter Name="BranchID" SessionField="BRANCHID" Type="Int32" />
                                            <asp:Parameter Name="ReqType" Type="String" DefaultValue="R" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Reason">
                                <ItemTemplate>
                                    <asp:Label ID="lblReasonDesc" runat="server" Text='<%# Eval("ReasonDescription") %>'></asp:Label>
                                </ItemTemplate>
                                <InsertItemTemplate>
                                    <asp:DropDownList ID="cboReason" runat="server" SelectedValue='<%# Bind("Reason") %>'
                                        AppendDataBoundItems="true" DataSourceID="SqlDataSource_Reason" DataTextField="ReasonDescription"
                                        DataValueField="Reason">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4qwq" runat="server" ControlToValidate="cboReason"
                                        ValidationGroup="Part2" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="SqlDataSource_Reason" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                        SelectCommand="SELECT [Reason],[ReasonDescription] FROM [v_Reasons_Reissue]" SelectCommandType="Text"></asp:SqlDataSource>
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="cboReason" runat="server" SelectedValue='<%# Bind("Reason") %>'
                                        DataSourceID="SqlDataSource_Reason" DataTextField="ReasonDescription" DataValueField="Reason">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4trytr" runat="server" ControlToValidate="cboReason"
                                        ValidationGroup="Part2" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="SqlDataSource_Reason" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                        SelectCommand="SELECT [Reason],[ReasonDescription] FROM [v_Reasons_Reissue]" SelectCommandType="Text"></asp:SqlDataSource>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Comments" SortExpression="Comments">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtComments" Width="300px" MaxLength="250" runat="server" Text='<%# Bind("Comments") %>'></asp:TextBox>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtComments" ValidationGroup="Part2"
                                        ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>--%>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="txtComments" MaxLength="250" Width="300px" runat="server" Text='<%# Bind("Comments") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblComments" Width="300px" runat="server" Text='<%# Bind("Comments") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Insert By" InsertVisible="False" SortExpression="InsertBy">
                                <ItemTemplate>
                                    <uc3:EMP ID="EMP111" Username='<%# Eval("ReissueInsertBy") %>' runat="server" />
                                    <span class="time-small" title='<%# Eval("ReissueInsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                        <time class="timeago" datetime='<%# Eval("ReissueInsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Deleted" SortExpression="Deleted" InsertVisible="false"
                                ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <%# Eval("Deleted").ToString() == "True" ? "<img src='Images/tick.png' width='20px' height='20px' />" : "" %>
                                </ItemTemplate>
                                <InsertItemTemplate>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Deleted By" InsertVisible="False" SortExpression="DeletedBy">
                                <ItemTemplate>
                                    <uc3:EMP ID="EMP1121" Username='<%# Eval("DeletedBy") %>' runat="server" />
                                    <span class="time-small" title='<%# Eval("DeletedDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                        <time class="timeago" datetime='<%# Eval("DeletedDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Send To Process" SortExpression="SendToProcess" InsertVisible="false"
                                ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <%# (Eval("SendToProcess").ToString() == "True" ? "<img src='Images/tick.png' width='20px' height='20px' />" : "") %>
                                </ItemTemplate>
                                <InsertItemTemplate>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Send Batch ID" SortExpression="SendBatchID" InsertVisible="false"
                                ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <%# Eval("SendBatchID") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Send By" SortExpression="SendBy" InsertVisible="false"
                                ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <uc3:EMP ID="EMP11121" Username='<%# Eval("SendBy") %>' runat="server" />
                                    <span class="time-small" title='<%# Eval("SendDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                        <time class="timeago" datetime='<%# Eval("SendDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Forwarding Batch" SortExpression="ForwardingBatch" InsertVisible="false"
                                ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <%# Eval("ForwardingBatch") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Forwarding By" SortExpression="ForwardingBY" InsertVisible="false"
                                ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <uc3:EMP ID="EMP114418821" Username='<%# Eval("ForwardingBY") %>' runat="server" />
                                    <span class="time-small" title='<%# Eval("ForwardingDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                        <time class="timeago" datetime='<%# Eval("ForwardingDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Forwarding Branch" SortExpression="ForwardingBranchName" InsertVisible="false"
                                ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <%# Eval("ForwardingBranchName")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ControlStyle-Width="80px">
                                <EditItemTemplate>
                                    <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" CommandName="Update"
                                        ValidationGroup="Part2" Text="Update" />
                                    <asp:ConfirmButtonExtender ID="conUpdate" runat="server" ConfirmText="Do you want to Update?"
                                        TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                    &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="True" CommandName="Cancel"
                                        ValidationGroup="Part2" Text="Cancel" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:Button ID="cmdInsert" runat="server" CausesValidation="true" CommandName="Insert"
                                        ValidationGroup="Part2" Text="Save" />
                                    <asp:ConfirmButtonExtender ID="conInsert" runat="server" ConfirmText="Do you want to Save?"
                                        TargetControlID="cmdInsert"></asp:ConfirmButtonExtender>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <%--<asp:Button ID="cmdEdit" runat="server" Enabled='<%# Eval("SendToProcess").ToString() == "True" ? false : true %>'
                                        CausesValidation="True" ValidationGroup="Part2" CommandName="Edit" Text="Edit" />--%>
                                    <asp:Button ID="cmdDelete" runat="server" Enabled='<%# Eval("SendToProcess").ToString() == "True" ? false : true %>'
                                        CausesValidation="True" ValidationGroup="Part2" CommandName="Delete" Text="Delete" />
                                    <asp:ConfirmButtonExtender ID="conDelete" runat="server" ConfirmText="Do you want to Delete?"
                                        TargetControlID="cmdDelete"></asp:ConfirmButtonExtender>
                                </ItemTemplate>
                                <ControlStyle Width="80px" />
                            </asp:TemplateField>
                        </Fields>
                        <FooterStyle BackColor="#CCCC99" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" />
                    </asp:DetailsView>
                </fieldset>
                <br />
                <asp:SqlDataSource ID="SqlDataSource_CardReissue" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="SELECT * FROM v_reissue with (nolock) WHERE ServiceRequestID = @ServiceRequestID"
                    SelectCommandType="Text" InsertCommand="s_CardReissue_insert" InsertCommandType="StoredProcedure"
                    UpdateCommand="s_CardReissue_update" UpdateCommandType="StoredProcedure" DeleteCommand="s_reissue_delete"
                    DeleteCommandType="StoredProcedure" OnInserted="SqlDataSource_CardReissue_Inserted"
                    OnUpdated="SqlDataSource_CardReissue_Updated" OnSelected="SqlDataSource_CardReissue_Selected"
                    OnDeleted="SqlDataSource_CardReissue_Deleted">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hidReqID" Name="ServiceRequestID" PropertyName="Value"
                            DefaultValue="-1" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="hidReqID" Name="ReqID" PropertyName="Value" />
                        <asp:Parameter Name="DeliveryBranchID" Type="Int32" />
                        <asp:Parameter Name="ServiceType" Type="Int32" />
                        <asp:Parameter Name="CardTypeNew" Type="String" DefaultValue="" />
                        <asp:Parameter Name="Reason" Type="Int32" />
                        <asp:Parameter Name="Comments" Type="String" Size="250" />
                        <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                        <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                        <asp:Parameter Direction="InputOutput" Name="Done" Type="Boolean" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="hidReqID" Name="ServiceRequestID" PropertyName="Value" />
                        <asp:Parameter Name="DeliveryBranchID" Type="Int32" />
                        <asp:Parameter Name="ServiceType" Type="Int32" />
                        <asp:Parameter Name="Reason" Type="Int32" />
                        <asp:Parameter Name="CardTypeNew" Type="String" DefaultValue="" />
                        <asp:Parameter Name="Comments" Type="String" Size="250" />
                        <asp:SessionParameter Name="UpdateBy" SessionField="EMPID" Type="String" />
                        <asp:Parameter Name="msg" Type="String" Size="250" Direction="InputOutput" />
                    </UpdateParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="hidReqID" Name="ServiceRequestID" PropertyName="Value"
                            DefaultValue="-1" />
                        <asp:Parameter Name="msg" Type="String" Size="250" Direction="InputOutput" />
                    </DeleteParameters>
                </asp:SqlDataSource>
            </asp:Panel>
            <a href="http://172.22.1.26/blog/3281" target="_blank" style="font-size: large"><b>How to use debit card & PIN reissue</b></a>
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
