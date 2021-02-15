<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PriorityPassTrans.aspx.cs" Inherits="PriorityPassTrans" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Priority Pass Card Trans
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <div>
                <table class="Panel1 ui-corner-all">
                    <tr>
                        <td>YMID:
                        </td>
                        <td>
                            <asp:TextBox ID="txtYMID" runat="server" Width="80px" placeholder="yyyymm"></asp:TextBox>
                        </td>                        
                        <td>
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Show" Width="80px" />
                        </td>
                    </tr>
                </table>
            </div>
            <asp:Button ID="cmdNew" runat="server" Text="Add New" Width="180px" OnClick="cmdNew_Click" />
            <asp:DetailsView ID="DetailsView1" runat="server" CssClass="Grid" AutoGenerateRows="False"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource2" ForeColor="Black"
                GridLines="Vertical" Style="font-size: small" OnItemInserted="DetailsView1_ItemInserted" OnItemUpdated="DetailsView1_ItemUpdated">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <Fields>
                    <asp:TemplateField HeaderText="ID" ShowHeader="true" InsertVisible="false">
                        <ItemTemplate>
                            <%# Eval("ID")%>
                        </ItemTemplate>
                        <ItemStyle Font-Bold="true" Font-Size="Larger" ForeColor="Silver" />
                    </asp:TemplateField>
                    <%--<asp:TemplateField HeaderText="Type">
                        <ItemTemplate>
                            <%# Eval("Type")%>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="cboType" runat="server" SelectedValue='<%# Bind("Type") %>'
                                AppendDataBoundItems="true" AutoPostBack="true">
                                <asp:ListItem Text="Member" Value="Member"></asp:ListItem>
                                <asp:ListItem Text="Guest" Value="Guest"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorServiceType" runat="server"
                                ControlToValidate="cboType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="cboType" runat="server" SelectedValue='<%# Bind("Type") %>'
                                AppendDataBoundItems="true" AutoPostBack="true">
                                <asp:ListItem Text="Member" Value="Member"></asp:ListItem>
                                <asp:ListItem Text="Guest" Value="Guest"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorServiceType1" runat="server"
                                ControlToValidate="cboType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemStyle Font-Bold="true" />
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Card Number" ShowHeader="true">
                        <ItemTemplate>
                            <%# Eval("CardNo")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCardNo" Width="120px" MaxLength="20" OnTextChanged="txtCardNo_TextChanged"
                                AutoPostBack="true" runat="server" Text='<%# Bind("CardNo") %>'></asp:TextBox>
                            <asp:Label runat="server" ID="lblCardNo" Text=""></asp:Label>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtCardNo333"
                                ValidChars="0123456789-" TargetControlID="txtCardNo"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33424fgdgj57457" runat="server"
                                ControlToValidate="txtCardNo" ForeColor="Red" ErrorMdeptID="7" essage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Label ID="lblCard" runat="server" Text=""></asp:Label>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtCardNo" Width="120px" MaxLength="19" OnTextChanged="txtCardNo_TextChanged"
                                AutoPostBack="true" runat="server" Text='<%# Bind("CardNo") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtCardNo123412"
                                ValidChars="0123456789-" TargetControlID="txtCardNo"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3867523sdsad456788" runat="server"
                                ControlToValidate="txtCardNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Label ID="lblCardNo" runat="server" Text=""></asp:Label>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Billing Month" SortExpression="BillingMonth">
                        <ItemTemplate>
                            <asp:Label ID="lblBillingMonth" runat="server" Text='<%# Bind("BillingMonth") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtBillingMonth" runat="server" Text='<%# Bind("BillingMonth") %>' placeholder="YYYYMM" Width="80px"
                                MaxLength="6"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFi3232sddeldValidator2" runat="server" ControlToValidate="txtBillingMonth"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <p>Billing Month Format for January 2017:<b>201701</b></p>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtBillingMonth" runat="server" Text='<%# Bind("BillingMonth") %>' placeholder="YYYYMM" Width="80px"
                                MaxLength="6"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidaasd23tor2" runat="server" ControlToValidate="txtBillingMonth"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <span>Billing Month Format for January 2018: <b>201801</b></span>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Lounge Name" SortExpression="LoungeName">
                        <ItemTemplate>
                            <asp:Label ID="lblLoungeName" runat="server" Text='<%# Bind("LoungeName") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLoungeName" runat="server" Text='<%# Bind("LoungeName") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLoungeName"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtLoungeName" runat="server" Text='<%# Bind("LoungeName") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLoungeName"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Country" SortExpression="Country">
                        <ItemTemplate>
                            <asp:Label ID="lblCountry" runat="server" Text='<%# Bind("Country") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCountry" runat="server" Text='<%# Bind("Country") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidaadsa343tor2" runat="server" ControlToValidate="txtCountry"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtCountry" runat="server" Text='<%# Bind("Country") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidaadsa343tor2" runat="server" ControlToValidate="txtCountry"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Terminal" SortExpression="Terminal">
                        <ItemTemplate>
                            <asp:Label ID="lblTerminal" runat="server" Text='<%# Bind("Terminal") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTerminal" runat="server" Text='<%# Bind("Terminal") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidaadsa343tor2Terminal" runat="server" ControlToValidate="txtTerminal"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtTerminal" runat="server" Text='<%# Bind("Terminal") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidaadsa343tor2Terminal" runat="server" ControlToValidate="txtTerminal"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="City" SortExpression="City">
                        <ItemTemplate>
                            <asp:Label ID="lblCity" runat="server" Text='<%# Bind("City") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidaadsa343tor2City" runat="server" ControlToValidate="txtCity"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtCity" runat="server" Text='<%# Bind("City") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidaadsa343tor2City" runat="server" ControlToValidate="txtCity"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Visit Date" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblTransactionDate" runat="server" Text='<%# (DateTime.Parse(Eval("VisitDate").ToString())).ToString("dd/MM/yyyy") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtVisitDate" Width="90px" MaxLength="30" Class="Date" runat="server"
                                Text='<%# Bind("VisitDate","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator334245fgdfg7457" runat="server"
                                ControlToValidate="txtVisitDate" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtVisitDate" Width="90px" MaxLength="30" Class="Date" runat="server"
                                Text='<%# Bind("VisitDate","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator334245fgdfg7457" runat="server"
                                ControlToValidate="txtVisitDate" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <HeaderStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="No. Of Visit (Member)" ShowHeader="true">
                        <ItemTemplate>
                            <%# Eval("NoOfVisitMember")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNoOfVisitMember" Width="50px" MaxLength="15" runat="server" Text='<%# Bind("NoOfVisitMember") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo33qwe3NoOfVisitMember"
                                ValidChars="0123456789" TargetControlID="txtNoOfVisitMember"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33424wewew57457NoOfVisitMember" runat="server"
                                ControlToValidate="txtNoOfVisitMember" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtNoOfVisit" Width="50px" MaxLength="15" runat="server" Text='<%# Bind("NoOfVisitMember") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo33qwe3NoOfVisit"
                                ValidChars="0123456789" TargetControlID="txtNoOfVisit"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33424wewew57457NoOfVisit" runat="server"
                                ControlToValidate="txtNoOfVisit" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="No. Of Visit (Guest)" ShowHeader="true">
                        <ItemTemplate>
                            <%# Eval("NoOfVisitGuest")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNoOfVisitGuest" Width="50px" MaxLength="15" runat="server" Text='<%# Bind("NoOfVisitGuest") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo33qwe3NoOfVisitGuest"
                                ValidChars="0123456789" TargetControlID="txtNoOfVisitGuest"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33424wewew57457NoOfVisitGuest" runat="server"
                                ControlToValidate="txtNoOfVisitGuest" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtNoOfVisitGuest" Width="50px" MaxLength="15" runat="server" Text='<%# Bind("NoOfVisitGuest") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo33qwe3NoOfVisitGuest"
                                ValidChars="0123456789" TargetControlID="txtNoOfVisitGuest"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33424wewew57457NoOfVisitGuest" runat="server"
                                ControlToValidate="txtNoOfVisitGuest" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bill Amount" ShowHeader="true">
                        <ItemTemplate>
                            <%# Eval("BillAmount")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtBillAmount" Width="200px" MaxLength="15" runat="server" Text='<%# Bind("BillAmount") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo33qwe3"
                                ValidChars="0123456789." TargetControlID="txtBillAmount"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33424wewew57457" runat="server"
                                ControlToValidate="txtBillAmount" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtBillAmount" Width="200px" MaxLength="19" runat="server" Text='<%# Bind("BillAmount") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendsdasertxtAccNoerewr"
                                ValidChars="0123456789." TargetControlID="txtBillAmount"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator38675234asdass56788" runat="server"
                                ControlToValidate="txtBillAmount" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remarks" SortExpression="Remarks">
                        <ItemTemplate>
                            <asp:Label ID="lblRemarks" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Bind("Remarks") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Bind("Remarks") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            </EditItemTemplate>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowInsertButton="true" ButtonType="Button" ShowEditButton="True"
                        ControlStyle-Width="80px">
                        <ControlStyle Width="80px" />
                    </asp:CommandField>
                </Fields>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                InsertCommand="s_PriorityPassTransaction_Insert_Update" InsertCommandType="StoredProcedure" SelectCommand="s_PriorityPassTransaction_Select"
                SelectCommandType="StoredProcedure" UpdateCommand="s_PriorityPassTransaction_Insert_Update" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSource2_Inserted" OnUpdated="SqlDataSource2_Updated">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ID" Type="Int32" Direction="InputOutput" />
                    <%--<asp:Parameter Name="Type" Type="String" />--%>
                    <asp:Parameter Name="CardNo" Type="String" />
                    <asp:Parameter Name="BillingMonth" Type="String" />
                    <asp:Parameter Name="LoungeName" Type="String" />
                    <asp:Parameter Name="Country" Type="String" />
                    <asp:Parameter Name="Terminal" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                    <asp:Parameter Name="NoOfVisitMember" Type="Int32" />
                    <asp:Parameter Name="NoOfVisitGuest" Type="Int32" />
                    <asp:Parameter Name="BillAmount" Type="Decimal" />
                    <asp:Parameter Name="VisitDate" Type="DateTime" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Done" DefaultValue="false" Direction="InputOutput" Type="Boolean" />
                    <asp:Parameter Name="Msg" Direction="InputOutput" Type="String" Size="250" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="ID" Type="Int32" Direction="InputOutput" DefaultValue="0" />
                    <%--<asp:Parameter Name="Type" Type="String" />--%>
                    <asp:Parameter Name="CardNo" Type="String" />
                    <asp:Parameter Name="BillingMonth" Type="String" />
                    <asp:Parameter Name="LoungeName" Type="String" />
                    <asp:Parameter Name="Country" Type="String" />
                    <asp:Parameter Name="Terminal" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                    <asp:Parameter Name="NoOfVisitMember" Type="Int32" />
                    <asp:Parameter Name="NoOfVisitGuest" Type="Int32" />
                    <asp:Parameter Name="BillAmount" Type="Decimal" />
                    <asp:Parameter Name="VisitDate" Type="DateTime" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Done" DefaultValue="false" Direction="InputOutput" Type="Boolean" />
                    <asp:Parameter Name="Msg" Direction="InputOutput" Type="String" Size="250" />
                </InsertParameters>
            </asp:SqlDataSource>
            <%--<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="5" DataKeyNames="ID" DataSourceID="SqlDataSource1" ForeColor="Black"
                GridLines="Vertical" Style="font-size: small" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />--%>
            <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="ID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" AllowSorting="True"
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged" EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"><img src="Images/edit-label.png" width="20" height="20" border="0" /></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Font-Bold="True" ForeColor="Blue" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                    <%--<asp:BoundField DataField="Type" HeaderText="Type" ReadOnly="True" SortExpression="Type"
                        ItemStyle-Font-Bold="true">
                        <ItemStyle Font-Bold="True" />
                    </asp:BoundField>--%>
                    <asp:TemplateField HeaderText="Card No" SortExpression="CardNo" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <a href='PriorityPassBillDownload.aspx?type=view&card=<%# Eval("CardNo") %>' target="_blank"><%# Eval("CardNo") %></a>
                        
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Billing Month" SortExpression="BillingMonth" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("BillingMonth")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Lounge Name" SortExpression="LoungeName" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("LoungeName")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Country" SortExpression="Country" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("Country")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Terminal" SortExpression="Terminal" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("Terminal")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="City" SortExpression="City" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("City")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Visit Date" SortExpression="VisitDate" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("VisitDate","{0:dd/MM/yyyy}") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="No. Of Visit Member" SortExpression="NoOfVisitMember" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("NoOfVisitMember")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="No. Of Visit Guest" SortExpression="NoOfVisitGuest" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("NoOfVisitGuest")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="BillAmount" SortExpression="Bill Amount" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("BillAmount")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remarks" SortExpression="Remarks" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("Remarks")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Inserted on" SortExpression="InsertDT">
                        <ItemTemplate>
                            <div class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                            <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Updated on" SortExpression="UpdateDT">
                        <ItemTemplate>
                            <div class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </div>
                            <uc2:EMP ID="EMP2" runat="server" Username='<%# Eval("UpdateBY") %>' />
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
            <asp:Label runat="server" ID="lblstatus" Text=""></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM [PriorityPassTransaction] where BillingMonth=@YMID ORDER BY ID Desc" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtYMID" Name="YMID" />
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
