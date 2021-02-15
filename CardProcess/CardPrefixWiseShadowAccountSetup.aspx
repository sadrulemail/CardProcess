<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CardPrefixWiseShadowAccountSetup.aspx.cs" Inherits="CardPrefixWiseShadowAccountSetup" %>

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
                DataKeyNames="MerchantID" DefaultMode="Insert">
                <AlternatingRowStyle BackColor="White" />
                <Fields>
                    <asp:BoundField DataField="MerchantID" HeaderText="MerchantID" InsertVisible="False"
                        ReadOnly="True" SortExpression="MerchantID" />
                    <asp:TemplateField HeaderText="Merchant Name" SortExpression="MerchantName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMerchantName" Width="300px" MaxLength="50" runat="server" Text='<%# Bind("MerchantName") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator123134634" runat="server"
                                ControlToValidate="txtMerchantName" ErrorMessage="RegularExpressionValidator"
                                ValidationExpression="^[a-zA-Z''-'\s.-]{1,50}$" Display="Dynamic">Invalid</asp:RegularExpressionValidator>
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
                    <asp:TemplateField HeaderText="Merchant Shadow Acc No" SortExpression="MerchantShadowAccNo">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMerchantShadowAccNo" Width="200px" MaxLength="19" runat="server"
                                Text='<%# Bind("MerchantShadowAccNo") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo333"
                                ValidChars="0123456789-" TargetControlID="txtMerchantShadowAccNo">
                            </asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3342457457" runat="server"
                                ControlToValidate="txtMerchantShadowAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Button runat="server" ID="cmdValidateShadowAccount" Text="Valid Account" Width="100px"
                                CausesValidation="false" onclick="cmdValidateShadowAccount_Click" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtMerchantShadowAccNo" Width="200px" MaxLength="19" runat="server"
                                Text='<%# Bind("MerchantShadowAccNo") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNoerewr"
                                ValidChars="0123456789-" TargetControlID="txtMerchantShadowAccNo">
                            </asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3867523456788" runat="server"
                                ControlToValidate="txtMerchantShadowAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Button runat="server" ID="cmdValidateShadowAccount" Text="Valid Account" Width="100px"
                                CausesValidation="false" onclick="cmdValidateShadowAccount_Click"/>
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
                                ValidChars="0123456789-" TargetControlID="txtMerchantOrginalAccNo">
                            </asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33543789789" runat="server"
                                ControlToValidate="txtMerchantOrginalAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Button runat="server" ID="cmdValidateOrginalAccount" Text="Valid Account" Width="100px"
                                CausesValidation="false" onclick="cmdValidateOrginalAccount_Click" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtMerchantOrginalAccNo" Width="200px" MaxLength="19" runat="server"
                                Text='<%# Bind("MerchantOrginalAccNo") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo2344"
                                ValidChars="0123456789-" TargetControlID="txtMerchantOrginalAccNo">
                            </asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6633245235" runat="server"
                                ControlToValidate="txtMerchantOrginalAccNo" ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Button runat="server" ID="cmdValidateOrginalAccount" Text="Valid Account" Width="100px"
                                CausesValidation="false" onclick="cmdValidateOrginalAccount_Click" />
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
                                TargetControlID="cmdUpdate">
                            </asp:ConfirmButtonExtender>
                            &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="Cancel" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:Button ID="cmdInsert" runat="server" CausesValidation="True" Enabled="false"
                                CommandName="Insert" Text="Save" />
                            <asp:ConfirmButtonExtender ID="conInsert" runat="server" ConfirmText="Do you want to Save?"
                                TargetControlID="cmdInsert">
                            </asp:ConfirmButtonExtender>
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
                SelectCommand="SELECT * FROM MerchantSetup WHERE MerchantID = @MerchantID " InsertCommand="s_MerchantSetup_insert"
                InsertCommandType="StoredProcedure" UpdateCommand="s_MerchantSetup_insert" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSourceMerchantSetup_Inserted" OnUpdated="SqlDataSourceMerchantSetup_Updated">
                <InsertParameters>
                    <%--<asp:Parameter Name="TransType" Type="String" />--%>
                    <asp:Parameter Name="MerchantName" Type="String" />
                    <asp:Parameter Name="MerchantShadowAccNo" Type="String" />
                    <asp:Parameter Name="MerchantOrginalAccNo" Type="String" />
                    <asp:Parameter Name="OnUsCommissionPercent" Type="Decimal" />
                    <asp:Parameter Name="OfUsCommissionPercent" Type="Decimal" />
                    <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                    <asp:Parameter Direction="InputOutput" Name="MerchantID" Type="Int32" DefaultValue="0" />
                    <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidMerchantID" Name="MerchantID" PropertyName="Value"
                        DefaultValue="-1" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:ControlParameter ControlID="hidMerchantID" Name="MerchantID" PropertyName="Value"
                        Type="Int32" />
                    <%--<asp:Parameter Name="TransType" Type="String" />--%>
                    <asp:Parameter Name="MerchantName" Type="String" />
                    <asp:Parameter Name="MerchantShadowAccNo" Type="String" />
                    <asp:Parameter Name="MerchantOrginalAccNo" Type="String" />
                    <asp:Parameter Name="OnUsCommissionPercent" Type="Decimal" />
                    <asp:Parameter Name="OfUsCommissionPercent" Type="Decimal" />
                    <asp:SessionParameter Name="UpdateBy" SessionField="EMPID" Type="String" />
                    <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                    <%-- <asp:Parameter Direction="InputOutput" Name="ReqID" Type="Int32"/>--%>
                </UpdateParameters>
            </asp:SqlDataSource>
            <div>
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" BackColor="White"
                    AllowPaging="True" PageSize="20" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                    CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="Black" AutoGenerateColumns="False"
                    CssClass="Grid" EnableSortingAndPagingCallbacks="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <Columns>
                        <%--<asp:BoundField DataField="Batch" HeaderText="Batch" SortExpression="Batch" InsertVisible="False"
                            ReadOnly="True" />--%>
                        <asp:CommandField ShowSelectButton="True" ButtonType="Link" ItemStyle-Font-Bold="true"
                            ItemStyle-ForeColor="Blue" />
                        <asp:BoundField DataField="MerchantID" HeaderText="Merchant ID" SortExpression="MerchantID"
                            ItemStyle-HorizontalAlign="Center" />
                        <%--<asp:BoundField DataField="TransType" HeaderText="Trans Type"
                            SortExpression="TransType" ItemStyle-HorizontalAlign="Center" />--%>
                        <asp:BoundField DataField="MerchantName" HeaderText="Merchant Name" SortExpression="MerchantName"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="MerchantShadowAccNo" HeaderText="Merchant <br \> Shadow Acc No"
                            HtmlEncode="false" SortExpression="MerchantShadowAccNo" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="MerchantOrginalAccNo" HeaderText="Merchant <br \> Orginal Acc No"
                            HtmlEncode="false" SortExpression="MerchantOrginalAccNo" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="OnUsCommissionPercent" HeaderText="On-Us <br \> Commission Percent"
                            SortExpression="OnUsCommissionPercent" HtmlEncode="false" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="OfUsCommissionPercent" HeaderText="Of-Us <br \>Commission Percent"
                            SortExpression="OfUsCommissionPercent" HtmlEncode="false" ItemStyle-HorizontalAlign="Right" />
                        <asp:TemplateField HeaderText="Insert By" SortExpression="InsertBy">
                            <ItemTemplate>
                                <uc3:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="InsertDT" HeaderText="Upload Date" SortExpression="InsertDT"
                            DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-HorizontalAlign="Center" />
                        <asp:TemplateField HeaderText="Update By" SortExpression="UpdateBy">
                            <ItemTemplate>
                                <uc3:EMP ID="EMP12" runat="server" Username='<%# Eval("UpdateBy") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="UpdateDT" HeaderText="Update Date" SortExpression="UpdateDT"
                            ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yyyy}" />
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
                <br />
                <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                    SelectCommand="SELECT * FROM MerchantSetup order by MerchantID"></asp:SqlDataSource>
            </div>
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
