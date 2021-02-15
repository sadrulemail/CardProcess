<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MerchantSetup.aspx.cs" Inherits="MerchantSetup" %>

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
            <asp:HiddenField ID="hidMerchantID" runat="server" />
            <asp:DetailsView ID="DetailsMerchantSetup" runat="server" BackColor="White" CssClass="Grid"
                BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black"
                GridLines="Vertical" DataSourceID="SqlDataSourceMerchantSetup" AutoGenerateRows="False"
                DataKeyNames="MerchantID" DefaultMode="Insert" OnItemInserted="DetailsMerchantSetup_ItemInserted" OnItemUpdated="DetailsMerchantSetup_ItemUpdated">
                <AlternatingRowStyle BackColor="White" />
                <Fields>
                    <asp:BoundField DataField="MerchantID" HeaderText="MerchantID" InsertVisible="False"
                        ReadOnly="True" SortExpression="MerchantID" />
                    <asp:TemplateField HeaderText="Merchant Name" SortExpression="MerchantName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMerchantName" Width="300px" MaxLength="50" runat="server" Text='<%# Bind("MerchantName") %>'></asp:TextBox>
                            <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator123134634" runat="server"
                                ControlToValidate="txtMerchantName" ErrorMessage="RegularExpressionValidator"
                                ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$" Display="Dynamic">Invalid</asp:RegularExpressionValidator>--%>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3078905345" runat="server"
                                ControlToValidate="txtMerchantName" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtMerchantName" Width="300px" MaxLength="50" runat="server" Text='<%# Bind("MerchantName") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator189875765" runat="server"
                                ControlToValidate="txtMerchantName" ErrorMessage="RegularExpressionValidator"
                                ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$" Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator356765645" runat="server" ControlToValidate="txtMerchantName"
                                ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblMerchantName" runat="server" Text='<%# Bind("MerchantName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Address" SortExpression="Address">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtAddress" Width="300px" TextMode="MultiLine" MaxLength="255" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtAddress" Width="300px" TextMode="MultiLine" MaxLength="255" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblAddress" Width="300px" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mobile" SortExpression="Address">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMobileNo" Width="300px" MaxLength="50" runat="server" Text='<%# Bind("MobileNo") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtMobileNo" Width="300px" MaxLength="50" runat="server" Text='<%# Bind("MobileNo") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblMobileNo" Width="300px" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Merchant Shadow Acc No" SortExpression="MerchantShadowAccNo">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMerchantShadowAccNo" Width="200px" MaxLength="19" runat="server"
                                Text='<%# Bind("MerchantShadowAccNo") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo333"
                                ValidChars="0123456789-" TargetControlID="txtMerchantShadowAccNo"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3342457457" runat="server"
                                ControlToValidate="txtMerchantShadowAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Button runat="server" ID="cmdValidateShadowAccount" Text="Valid Account" Width="100px"
                                CausesValidation="false" OnClick="cmdValidateShadowAccount_Click" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtMerchantShadowAccNo" Width="200px" MaxLength="19" runat="server"
                                Text='<%# Bind("MerchantShadowAccNo") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNoerewr"
                                ValidChars="0123456789-" TargetControlID="txtMerchantShadowAccNo"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3867523456788" runat="server"
                                ControlToValidate="txtMerchantShadowAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Button runat="server" ID="cmdValidateShadowAccount" Text="Valid Account" Width="100px"
                                CausesValidation="false" OnClick="cmdValidateShadowAccount_Click" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblMerchantShadowAccNo" Width="300px" runat="server" Text='<%# Bind("MerchantShadowAccNo") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Merchant Orginal Acc No" SortExpression="MerchantOrginalAccNo">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMerchantOrginalAccNo" Width="200px" MaxLength="19" runat="server"
                                Text='<%# Bind("MerchantOrginalAccNo") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo324535"
                                ValidChars="0123456789-" TargetControlID="txtMerchantOrginalAccNo"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33543789789" runat="server"
                                ControlToValidate="txtMerchantOrginalAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Button runat="server" ID="cmdValidateOrginalAccount" Text="Valid Account" Width="100px"
                                CausesValidation="false" OnClick="cmdValidateOrginalAccount_Click" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtMerchantOrginalAccNo" Width="200px" MaxLength="19" runat="server"
                                Text='<%# Bind("MerchantOrginalAccNo") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo2344"
                                ValidChars="0123456789-" TargetControlID="txtMerchantOrginalAccNo"></asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6633245235" runat="server"
                                ControlToValidate="txtMerchantOrginalAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Button runat="server" ID="cmdValidateOrginalAccount" Text="Valid Account" Width="100px"
                                CausesValidation="false" OnClick="cmdValidateOrginalAccount_Click" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblMerchantOrginalAccNo" Width="300px" runat="server" Text='<%# Bind("MerchantOrginalAccNo") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="On-Us Commission Percent(%)" SortExpression="OnUsCommissionPercent">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtOnUsCommissionPercent" Width="300px" MaxLength="5" runat="server"
                                Text='<%# Bind("OnUsCommissionPercent") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator14543457" runat="server"
                                ControlToValidate="txtOnUsCommissionPercent" ErrorMessage="RegularExpressionValidator"
                                ValidationExpression="^(100(?:\.0{1,2})?|0*?\.\d{1,2}|\d{1,2}(?:\.\d{1,2})?)$"
                                Display="Dynamic" ForeColor="Red">Invalid</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3342895645" runat="server"
                                ControlToValidate="txtOnUsCommissionPercent" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtOnUsCommissionPercent" Width="300px" MaxLength="5" runat="server"
                                Text='<%# Bind("OnUsCommissionPercent") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1565343412312" runat="server"
                                ControlToValidate="txtOnUsCommissionPercent" ErrorMessage="RegularExpressionValidator"
                                ValidationExpression="^(100(?:\.0{1,2})?|0*?\.\d{1,2}|\d{1,2}(?:\.\d{1,2})?)$"
                                Display="Dynamic" ForeColor="Red">Invalid</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator386735343245456" runat="server"
                                ControlToValidate="txtOnUsCommissionPercent" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblOnUsCommissionPercent" Width="300px" runat="server" Text='<%# Bind("OnUsCommissionPercent") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Of-Us Commission Percent(%)" SortExpression="OfUsCommissionPercent">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtOfUsCommissionPercent" Width="300px" MaxLength="5" runat="server"
                                Text='<%# Bind("OfUsCommissionPercent") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1454123123" runat="server"
                                ControlToValidate="txtOfUsCommissionPercent" ErrorMessage="RegularExpressionValidator"
                                ValidationExpression="^(100(?:\.0{1,2})?|0*?\.\d{1,2}|\d{1,2}(?:\.\d{1,2})?)$"
                                Display="Dynamic" ForeColor="Red">Invalid</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator334223445646" runat="server"
                                ControlToValidate="txtOfUsCommissionPercent" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtOfUsCommissionPercent" Width="300px" MaxLength="5" runat="server"
                                Text='<%# Bind("OfUsCommissionPercent") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator15653556456" runat="server"
                                ControlToValidate="txtOfUsCommissionPercent" ErrorMessage="RegularExpressionValidator"
                                ValidationExpression="^(100(?:\.0{1,2})?|0*?\.\d{1,2}|\d{1,2}(?:\.\d{1,2})?)$"
                                Display="Dynamic" ForeColor="Red">Invalid</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator386723452354" runat="server"
                                ControlToValidate="txtOfUsCommissionPercent" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblOfUsCommissionPercent" Width="300px" runat="server" Text='<%# Bind("OfUsCommissionPercent") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" SortExpression="Status">
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Bind("Status") %>'>
                                <asp:ListItem Value="True">Active</asp:ListItem>
                                <asp:ListItem Value="False">InActive</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqStatus" runat="server" ControlToValidate="ddlStatus"
                                ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Bind("Status") %>'>
                                <asp:ListItem Value="True">Active</asp:ListItem>
                                <asp:ListItem Value="False">InActive</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="reqsss" runat="server" ControlToValidate="ddlStatus"
                                ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" Width="300px" runat="server" Text='<%# Eval("Status").ToString() == "True" ? "Active" : "InActive"  %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="No Of POS" SortExpression="NoOfPOS">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNoOfPOS" Width="300px" MaxLength="2" runat="server" Text='<%# Bind("NoOfPOS") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33422344564sdfsa6" runat="server"
                                ControlToValidate="txtNoOfPOS" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtNoOfPOS" Width="300px" MaxLength="2" runat="server" Text='<%# Bind("NoOfPOS") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator386723452sdsd354" runat="server"
                                ControlToValidate="txtNoOfPOS" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblNoOfPOS" Width="300px" runat="server" Text='<%# Bind("NoOfPOS") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SIMInfo" SortExpression="SIMInfo">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtSIMInfo" Width="300px" TextMode="MultiLine" MaxLength="255" runat="server" Text='<%# Bind("SIMInfo") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtSIMInfo" Width="300px" TextMode="MultiLine" MaxLength="255" runat="server" Text='<%# Bind("SIMInfo") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblSIMInfo" Width="300px" runat="server" Text='<%# Bind("SIMInfo") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="POS Serial No" SortExpression="POSSerialNo">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPOSSerialNo" Width="300px"  MaxLength="50" runat="server" Text='<%# Bind("POSSerialNo") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtPOSSerialNo" Width="300px"  MaxLength="50" runat="server" Text='<%# Bind("POSSerialNo") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPOSSerialNo" Width="300px" runat="server" Text='<%# Bind("POSSerialNo") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Insert By" InsertVisible="False" SortExpression="InsertBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP" Username='<%# Eval("InsertBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Update By" InsertVisible="False" SortExpression="UpdateBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP1" Username='<%# Eval("UpdateBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False" ControlStyle-Width="80px">
                        <EditItemTemplate>
                            <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" Enabled="false"
                                CommandName="Update" Text="Update" />
                            <asp:ConfirmButtonExtender ID="conUpdate" runat="server" ConfirmText="Do you want to Update?"
                                TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                            &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="Cancel" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:Button ID="cmdInsert" runat="server" CausesValidation="True" Enabled="false"
                                CommandName="Insert" Text="Save" />
                            <asp:ConfirmButtonExtender ID="conInsert" runat="server" ConfirmText="Do you want to Save?"
                                TargetControlID="cmdInsert"></asp:ConfirmButtonExtender>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="cmdEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                Text="Edit" />
                            <asp:Button ID="cmdNew" runat="server" CausesValidation="False" CommandName="New"
                                Text="New" />
                        </ItemTemplate>
                        <ControlStyle Width="80px" />
                    </asp:TemplateField>
                </Fields>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#F7F7DE" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSourceMerchantSetup" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM MerchantSetup WHERE MerchantID = @MerchantID " InsertCommand="s_MerchantSetup_Insert_Update"
                InsertCommandType="StoredProcedure" UpdateCommand="s_MerchantSetup_Insert_Update" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSourceMerchantSetup_Inserted" OnUpdated="SqlDataSourceMerchantSetup_Updated">
                <InsertParameters>
                    <asp:Parameter Name="MerchantID" Type="Int32" Direction="InputOutput" DefaultValue="0" />
                    <asp:Parameter Name="MerchantName" Type="String" />
                    <asp:Parameter Name="MerchantShadowAccNo" Type="String" />
                    <asp:Parameter Name="MerchantOrginalAccNo" Type="String" />
                    <asp:Parameter Name="OnUsCommissionPercent" Type="Decimal" />
                    <asp:Parameter Name="OfUsCommissionPercent" Type="Decimal" />
                    <asp:Parameter Name="Status" DefaultValue="1" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Address" Type="String" />
                    <asp:Parameter Name="MobileNo" Type="String" />
                    <asp:Parameter Name="SIMInfo" Type="String" />
                    <asp:Parameter Name="POSSerialNo" Type="String" />
                    <asp:Parameter Name="Done" Type="Boolean" DefaultValue="false" Direction="InputOutput" />
                    <asp:Parameter Direction="InputOutput" Name="Msg" Type="String" Size="250" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidMerchantID" Name="MerchantID" PropertyName="Value"
                        DefaultValue="-1" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="MerchantID" Type="Int32" Direction="InputOutput" />
                    <asp:Parameter Name="MerchantName" Type="String" />
                    <asp:Parameter Name="MerchantShadowAccNo" Type="String" />
                    <asp:Parameter Name="MerchantOrginalAccNo" Type="String" />
                    <asp:Parameter Name="OnUsCommissionPercent" Type="Decimal" />
                    <asp:Parameter Name="OfUsCommissionPercent" Type="Decimal" />
                    <asp:Parameter Name="Status" DefaultValue="1" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                    <asp:Parameter Name="Address" Type="String" />
                    <asp:Parameter Name="MobileNo" Type="String" />
                    <asp:Parameter Name="SIMInfo" Type="String" />
                    <asp:Parameter Name="POSSerialNo" Type="String" />
                    <asp:Parameter Name="Done" Type="Boolean" DefaultValue="false" Direction="InputOutput" />
                    <asp:Parameter Direction="InputOutput" Name="Msg" Type="String" Size="250" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <div>
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                    AllowPaging="false" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" AutoGenerateColumns="False"
                    CssClass="Grid" EnableSortingAndPagingCallbacks="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"><img src="Images/edit-label.png" width="20" height="20" border="0" /></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="True" ForeColor="Blue" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="MerchantID" HeaderText="Merchant ID" SortExpression="MerchantID"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="MerchantName" HeaderText="Merchant Name" SortExpression="MerchantName"
                            ItemStyle-HorizontalAlign="left" />
                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address"
                            ItemStyle-HorizontalAlign="left" />
                        <asp:BoundField DataField="MobileNo" HeaderText="Mobile" SortExpression="MobileNo"
                            ItemStyle-HorizontalAlign="left" />
                        <asp:BoundField DataField="MerchantShadowAccNo" HeaderText="Merchant <br \> Shadow Acc No"
                            HtmlEncode="false" SortExpression="MerchantShadowAccNo" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="MerchantOrginalAccNo" HeaderText="Merchant <br \> Orginal Acc No"
                            HtmlEncode="false" SortExpression="MerchantOrginalAccNo" ItemStyle-HorizontalAlign="Center" />
                        <asp:TemplateField HeaderText="On-Us <br \> Commission Percent" SortExpression="OnUsCommissionPercent">
                            <ItemTemplate>
                                <%# Eval("OnUsCommissionPercent", "{0:N2} %")%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Of-Us <br \>Commission Percent" SortExpression="OfUsCommissionPercent">
                            <ItemTemplate>
                                <%# Eval("OfUsCommissionPercent", "{0:N2} %")%>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status" SortExpression="Status">
                            <ItemTemplate>
                                <%# Eval("Status").ToString() == "True" ? "Active" : "InActive" %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="NoOfPOS" HeaderText="No Of POS" SortExpression="NoOfPOS"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="SIMInfo" HeaderText="SIM Info" SortExpression="SIMInfo"
                            ItemStyle-HorizontalAlign="left" />
                        <asp:BoundField DataField="POSSerialNo" HeaderText="POS Serial No" SortExpression="POSSerialNo"
                            ItemStyle-HorizontalAlign="left" />
                        <asp:TemplateField HeaderText="Inserted on" SortExpression="InsertDT">
                            <ItemTemplate>
                                <div class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                    <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                </div>
                                <uc3:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Updated on" SortExpression="UpdateDT">
                            <ItemTemplate>
                                <div class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                    <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                </div>
                                <uc3:EMP ID="EMP2" runat="server" Username='<%# Eval("UpdateBY") %>' />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle BackColor="#F7F7DE" />
                    <FooterStyle BackColor="#CCCC99" />
                    <EmptyDataTemplate>
                        No Record Found.
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <PagerSettings Position="TopAndBottom" />
                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                </asp:GridView>
                <br />
                <asp:Label Font-Names="Arial" runat="server" ID="lblStatus" Text="" Font-Size="Small"></asp:Label>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="SELECT * FROM MerchantSetup order by MerchantID"></asp:SqlDataSource>
            </div>
            <asp:Button ID="cmdExport" runat="server" Text="Download" Width="150px" Height="30px" CausesValidation="false"
                Visible="true" Font-Bold="true" OnClick="cmdExport_Click" />
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
