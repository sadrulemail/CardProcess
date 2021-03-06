<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CreditCardEntry.aspx.cs" Inherits="CreditCardEntry" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Credit Card Entry
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <asp:HiddenField ID="HidID" runat="server" Value="" />
            <%--<asp:Button ID="cmdNew" runat="server" Text="Add New" Width="180px" OnClick="cmdNew_Click" />--%>
            <asp:DetailsView ID="DetailsView1" runat="server" CssClass="Grid" AutoGenerateRows="False"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource2" ForeColor="Black"
                GridLines="Vertical" Style="font-size: small">
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
                    <asp:TemplateField HeaderText="ITCLID" SortExpression="ITCLID">
                        <ItemTemplate>
                            <asp:Label ID="lblITCLID" runat="server" Text='<%# Bind("ITCLID") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtITCLID" runat="server" Text='<%# Bind("ITCLID") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtITCLID"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtITCLID" runat="server" Text='<%# Bind("ITCLID") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtITCLID"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Card Number" SortExpression="CardNo">
                        <ItemTemplate>
                            <asp:Label ID="lblCardNo" runat="server" Text='<%# Bind("CardNumber") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCardNo" runat="server" Text='<%# Bind("CardNumber") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ControlToValidate="txtCardNo"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtCardNo" runat="server" Text='<%# Bind("CardNumber") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" ControlToValidate="txtCardNo"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Customer Name" SortExpression="CustomerName">
                        <ItemTemplate>
                            <asp:Label ID="lblCustomerName" runat="server" Text='<%# Bind("CardHolderName") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCustomerName" runat="server" Text='<%# Bind("CardHolderName") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ControlToValidate="txtCustomerName"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtCustomerName" runat="server" Text='<%# Bind("CardHolderName") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ControlToValidate="txtCustomerName"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MobileNo" SortExpression="MobileNo">
                        <ItemTemplate>
                            <asp:Label ID="lblMobileNo" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMobileNo" runat="server" Text='<%# Bind("MobileNo") %>' Width="400px"
                                MaxLength="15"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorMobileNo" runat="server" ControlToValidate="txtMobileNo"
                                ErrorMessage="RequiredFieldValidator" SetFocusOnError="True" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{6,15}$"
                                ControlToValidate="txtMobileNo" ErrorMessage="RegularExpressionValidator">Invalid</asp:RegularExpressionValidator>
                            Ex: 8801XXXXXXXXX
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtMobileNo" runat="server" Text='<%# Bind("MobileNo") %>' Width="400px"
                                MaxLength="15"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorMobileNo" runat="server" ControlToValidate="txtMobileNo"
                                ForeColor="Red" SetFocusOnError="True" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{6,15}$"
                                ControlToValidate="txtMobileNo" ErrorMessage="RegularExpressionValidator">Invalid</asp:RegularExpressionValidator>
                            Ex: 8801XXXXXXXXX
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Type">
                        <ItemTemplate>
                            <%# Eval("IssueType")%>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="cboIssueType" runat="server" DataSourceID="SqlDataSourceIssueTypes" SelectedValue='<%# Bind("IssueType") %>'
                                DataTextField="IssueType" DataValueField="IssueType"
                                AppendDataBoundItems="true" AutoPostBack="false">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                <%--<asp:ListItem Text="New Card" Value="New Card"></asp:ListItem>
                                <asp:ListItem Text="Card Reissue" Value="Card Reissue"></asp:ListItem>
                                <asp:ListItem Text="PIN Reissue" Value="PIN Reissue"></asp:ListItem>--%>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorServiceTyp2323e1" runat="server"
                                ControlToValidate="cboIssueType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSourceIssueTypes" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="SELECT IssueType FROM dbo.v_CreditCardIssueTypes"></asp:SqlDataSource>
                        </InsertItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="cboIssueType" runat="server" DataSourceID="SqlDataSourceIssueTypes" SelectedValue='<%# Bind("IssueType") %>'
                                DataTextField="IssueType" DataValueField="IssueType"
                                AppendDataBoundItems="true" AutoPostBack="false">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                <%--<asp:ListItem Text="New Card" Value="New Card"></asp:ListItem>
                                <asp:ListItem Text="Card Reissue" Value="Card Reissue"></asp:ListItem>
                                <asp:ListItem Text="PIN Reissue" Value="PIN Reissue"></asp:ListItem>--%>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorServiceTyp2323e1" runat="server"
                                ControlToValidate="cboIssueType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSourceIssueTypes" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="SELECT IssueType FROM dbo.v_CreditCardIssueTypes"></asp:SqlDataSource>
                        </EditItemTemplate>
                        <ItemStyle Font-Bold="true" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Branch">
                        <ItemTemplate>
                            <asp:Label ID="lblIssueBranch" runat="server" Text='<%# Eval("IssueBR") %>'></asp:Label>
                            <%-- <asp:Label ID="lblDeliveryToBranchName" runat="server" Text='<%# Eval("DeliveryToBranchName") %>'></asp:Label>--%>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="cboIssueBranch" runat="server" SelectedValue='<%# Bind("IssueBR") %>'
                                DataSourceID="SqlDataSourceIssueBranch" DataTextField="BranchName" DataValueField="BranchID"
                                AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value="0"></asp:ListItem>
                                <%-- <asp:ListItem Text="My Current Branch" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>--%>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5465546455" runat="server" ControlToValidate="cboIssueBranch"
                                ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSourceIssueBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] order by BranchName"></asp:SqlDataSource>
                        </InsertItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="cboIssueBranch" runat="server" SelectedValue='<%# Bind("IssueBR") %>'
                                DataSourceID="SqlDataSourceIssueBranch" DataTextField="BranchName" DataValueField="BranchID"
                                AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value="0"></asp:ListItem>
                                <%--<asp:ListItem Text="My Current Branch" Value=""></asp:ListItem>
                                <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>--%>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator545678786" runat="server" ControlToValidate="cboIssueBranch"
                                ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSourceIssueBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] order by BranchName"></asp:SqlDataSource>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Date" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblIssueDate" runat="server" Text='<%# Eval("IssueDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtIssueDate" Width="200px" MaxLength="30" Class="Date" runat="server"
                                Text='<%# Bind("IssueDate","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator333432d4245fgdfg7457" runat="server"
                                ControlToValidate="txtIssueDate" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtIssueDate" Width="200px" MaxLength="30" Class="Date" runat="server"
                                Text='<%# Bind("IssueDate","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator334245f234efgdfg7457" runat="server"
                                ControlToValidate="txtIssueDate" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <HeaderStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ReceiveDate" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblReceiveDate" runat="server" Text='<%# Eval("ReceiveDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtReceiveDate" Width="200px" MaxLength="30" Class="Date" runat="server"
                                Text='<%# Bind("ReceiveDate","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldVali22dator334245fgdfg7457" runat="server"
                                ControlToValidate="txtReceiveDate" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtReceiveDate" Width="200px" MaxLength="30" Class="Date" runat="server"
                                Text='<%# Bind("ReceiveDate","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator334245fgdfg447457" runat="server"
                                ControlToValidate="txtReceiveDate" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <HeaderStyle Wrap="False" />
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
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DeliveryDate" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblDeliveryDate" runat="server" Text='<%# (Eval("DeliveryDate").ToString()) %>'></asp:Label>
                            <%--<asp:Label ID="Label1" runat="server" Text='<%# (DateTime.Parse(Eval("DeliveryDate").ToString())).ToString("dd/MM/yyyy") %>'></asp:Label>--%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDeliveryDate" Width="200px" MaxLength="30" Class="Date" runat="server"
                                Text='<%# Bind("DeliveryDate","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtDeliveryDate" Width="200px" MaxLength="30" Class="Date" runat="server"
                                Text='<%# Bind("DeliveryDate","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <HeaderStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delivery Branch">
                        <ItemTemplate>
                            <asp:Label ID="lblDeliveryToBranch" runat="server" Text='<%# Eval("DeliveryBR") %>'></asp:Label>
                            <%-- <asp:Label ID="lblDeliveryToBranchName" runat="server" Text='<%# Eval("DeliveryToBranchName") %>'></asp:Label>--%>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="cboDeliveryToBranch" runat="server" SelectedValue='<%# Bind("DeliveryBR") %>'
                                DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID"
                                AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                <%-- <asp:ListItem Text="My Current Branch" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>--%>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cboDeliveryToBranch"
                                ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] order by BranchName"></asp:SqlDataSource>
                        </InsertItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="cboDeliveryToBranch" runat="server" SelectedValue='<%# Bind("DeliveryBR") %>'
                                DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID"
                                AppendDataBoundItems="true">
                                <%--<asp:ListItem Text="My Current Branch" Value=""></asp:ListItem>
                                <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>--%>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="cboDeliveryToBranch"
                                ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] order by BranchName"></asp:SqlDataSource>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                            <asp:LinkButton ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        </ItemTemplate>
                        <ControlStyle Width="80px" />
                    </asp:TemplateField>
                </Fields>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                InsertCommand="s_CreditCardInfo_Insert_Update" InsertCommandType="StoredProcedure" SelectCommand="s_CreditCardInfo_Select"
                SelectCommandType="StoredProcedure" UpdateCommand="s_CreditCardInfo_Insert_Update" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSource2_Inserted" OnUpdated="SqlDataSource2_Updated">
                <SelectParameters>
                    <%--  <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue"
                        Type="String" />--%>
                    <asp:ControlParameter ControlID="HidID" Name="ID" PropertyName="Value" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ID" Type="Int32" Direction="InputOutput" />
                    <asp:Parameter Name="ITCLID" Type="String" />
                    <asp:Parameter Name="CardNumber" Type="String" />
                    <asp:Parameter Name="CardHolderName" Type="String" />
                    <asp:Parameter Name="MobileNo"  />
                    <asp:Parameter Name="IssueDate" Type="DateTime" />
                    <asp:Parameter Name="ReceiveDate" Type="DateTime" />
                    <asp:Parameter Name="DeliveryDate" Type="DateTime" />
                    <asp:Parameter Name="DeliveryBR" Type="Int32" />
                    <asp:Parameter Name="IssueBR" Type="Int32" />
                    <asp:Parameter Name="IssueType" Type="String" />
                    <asp:Parameter Name="Remarks" Type="String" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Done" DefaultValue="false" Direction="InputOutput" />
                    <asp:Parameter Name="Msg" Direction="InputOutput" Type="String" Size="250" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="ID" Type="Int32" Direction="InputOutput" DefaultValue="0" />
                    <asp:Parameter Name="ITCLID" Type="String" />
                    <asp:Parameter Name="CardNumber" Type="String" />
                    <asp:Parameter Name="CardHolderName" Type="String" />
                    <asp:Parameter Name="MobileNo" />
                    <asp:Parameter Name="IssueDate" Type="DateTime" />
                    <asp:Parameter Name="ReceiveDate" Type="DateTime" />
                    <asp:Parameter Name="DeliveryDate" Type="DateTime" />
                    <asp:Parameter Name="DeliveryBR" Type="Int32" />
                    <asp:Parameter Name="IssueBR" Type="Int32" />
                    <asp:Parameter Name="IssueType" Type="String" />
                    <asp:Parameter Name="Remarks" Type="String" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Done" DefaultValue="false" Direction="InputOutput" />
                    <asp:Parameter Name="Msg" Direction="InputOutput" Type="String" Size="250" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" CssClass="Grid" AutoGenerateColumns="False"
                DataKeyNames="ID" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="2" ForeColor="Black" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True" PageSize="30" AllowSorting="True"
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged" EmptyDataText="Data Not Found">
                <PagerSettings Position="TopAndBottom" PageButtonCount="30" />
                <RowStyle BackColor="#F7F7DE" />

                <%--<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px" PagerSettings-Mode="NumericFirstLast"
                RowStyle-VerticalAlign="Top" Style="font-size: small" AllowPaging="True"
                CellPadding="5" DataKeyNames="ID" DataSourceID="SqlDataSource1" ForeColor="Black"
                GridLines="Vertical"  AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />--%>
                <Columns>
                    <%--<asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"><img src="Images/edit-label.png" width="20" height="20" border="0" /></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Font-Bold="True" ForeColor="Blue" />
                    </asp:TemplateField>--%>
                    <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
                    <asp:BoundField DataField="ITCLID" HeaderText="ITCL ID" ReadOnly="True" SortExpression="ITCLID"
                        ItemStyle-Font-Bold="true">
                        <ItemStyle Font-Bold="True" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Card Number" SortExpression="CardNumber" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("CardNumber")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CardHolderName" SortExpression="Card Holder Name" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("CardHolderName")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MobileNo" SortExpression="MobileNo" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("MobileNo")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Type" SortExpression="IssueType" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <%# Eval("IssueType")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue BR" SortExpression="IssueBR" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <%# Eval("IssueBR")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Date" SortExpression="IssueDate" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("IssueDate","{0:dd/MM/yyyy}") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Receive Date" SortExpression="ReceiveDate" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("ReceiveDate","{0:dd/MM/yyyy}") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delivery BR" SortExpression="DeliveryBR" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <%# Eval("DeliveryBR")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DeliveryDate" SortExpression="DeliveryDate" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("DeliveryDate","{0:dd/MM/yyyy}") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Remarks" SortExpression="Remarks" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("Remarks") %>
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
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM CreditCardInfo_History where ID=@ID ORDER BY SL" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HidID" Name="ID" PropertyName="Value" />
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
