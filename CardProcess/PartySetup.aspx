<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PartySetup.aspx.cs" Inherits="PartySetup" %>

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
            <asp:HiddenField ID="hidPartyID" runat="server" />
            <asp:DetailsView ID="DetailsPartySetup" runat="server" BackColor="White" CssClass="Grid"
                BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black"
                GridLines="Vertical" DataSourceID="SqlDataSourcePartySetup" AutoGenerateRows="False"
                DataKeyNames="PartyID" DefaultMode="Insert">
                <AlternatingRowStyle BackColor="White" />
                <Fields>
                    <asp:BoundField DataField="PartyID" HeaderText="PartyID" InsertVisible="False" ReadOnly="True"
                        SortExpression="PartyID" />
                    <asp:TemplateField HeaderText="Trans Category" SortExpression="TransCategory">
                        <EditItemTemplate>
                            <%--<asp:Label ID="lblTransType" runat="server" Text='<%# Bind("TransType") %>'></asp:Label>--%>
                            <asp:DropDownList ID="ddlTransCategory" runat="server" AppendDataBoundItems="true"
                                SelectedValue='<%# Bind("TransCategory") %>'>
                                <asp:ListItem Text="On-Us" Value="On-Us"></asp:ListItem>
                                <asp:ListItem Text="Off-Us" Value="Off-Us"></asp:ListItem>
                                <asp:ListItem Text="Visa Remote On-Us" Value="Visa Remote On-Us"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorddlTransCategory" runat="server"
                                ControlToValidate="ddlTransCategory" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <%--<asp:Label ID="lblTransType" runat="server" Text='<%# Bind("TransType") %>'></asp:Label>--%>
                            <asp:DropDownList ID="ddlTransCategory" runat="server" AppendDataBoundItems="true"
                                SelectedValue='<%# Bind("TransCategory") %>'>
                                <asp:ListItem Text="On-Us" Value="On-Us"></asp:ListItem>
                                <asp:ListItem Text="Off-Us" Value="Off-Us"></asp:ListItem>
                                <asp:ListItem Text="Visa Remote On-Us" Value="Visa Remote On-Us"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorddlTransCategory" runat="server"
                                ControlToValidate="ddlTransCategory" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblTransCategory" runat="server" Text='<%# Bind("TransCategory") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Party Name" SortExpression="PartyName">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPartyName" Width="300px" MaxLength="50" runat="server" Text='<%# Bind("PartyName") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1231" runat="server"
                                ControlToValidate="txtPartyName" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,40}$"
                                Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator307890" runat="server" ControlToValidate="txtPartyName"
                                ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtPartyName" Width="300px" MaxLength="50" runat="server" Text='<%# Bind("PartyName") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator18987" runat="server"
                                ControlToValidate="txtPartyName" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[a-zA-Z''-'\s.-]{1,19}$"
                                Display="Dynamic">Invalid</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator356765" runat="server" ControlToValidate="txtPartyName"
                                ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPartyName" runat="server" Text='<%# Bind("PartyName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Commission Percent(%)" SortExpression="CommissionPercent">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCommissionPercent" Width="300px" MaxLength="5" runat="server"
                                Text='<%# Bind("CommissionPercent") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1454" runat="server"
                                ControlToValidate="txtCommissionPercent" ErrorMessage="RegularExpressionValidator"
                                ValidationExpression="^(100(?:\.0{1,2})?|0*?\.\d{1,2}|\d{1,2}(?:\.\d{1,2})?)$"
                                Display="Dynamic" ForeColor="Red">Invalid</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3342" runat="server" ControlToValidate="txtCommissionPercent"
                                ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtCommissionPercent" Width="300px" MaxLength="5" runat="server"
                                Text='<%# Bind("CommissionPercent") %>'></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1565" runat="server"
                                ControlToValidate="txtCommissionPercent" ErrorMessage="RegularExpressionValidator"
                                ValidationExpression="^(100(?:\.0{1,2})?|0*?\.\d{1,2}|\d{1,2}(?:\.\d{1,2})?)$"
                                Display="Dynamic" ForeColor="Red">Invalid</asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3867" runat="server" ControlToValidate="txtCommissionPercent"
                                ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblCommissionPercent" Width="300px" runat="server" Text='<%# Bind("CommissionPercent") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Account No" SortExpression="AccountNo">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtAccountNo" Width="200px" MaxLength="20" runat="server" Text='<%# Bind("AccountNo") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo"
                                ValidChars="0123456789-" TargetControlID="txtAccountNo">
                            </asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator33543" runat="server" ControlToValidate="txtAccountNo"
                                ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Button runat="server" ID="cmdValidateAccount" Text="Valid Account" Width="100px"
                                CausesValidation="false" onclick="cmdValidateAccount_Click" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtAccountNo" Width="200px" MaxLength="20" runat="server" Text='<%# Bind("AccountNo") %>'></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtAccNo"
                                ValidChars="0123456789-" TargetControlID="txtAccountNo">
                            </asp:FilteredTextBoxExtender>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator663" runat="server" ControlToValidate="txtAccountNo"
                                ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            <asp:Button runat="server" ID="cmdValidateAccount" Text="Valid Account" Width="100px"
                                CausesValidation="false" onclick="cmdValidateAccount_Click" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblAccountNo" Width="200px" runat="server" Text='<%# Bind("AccountNo") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Trans Type" SortExpression="TransType">
                        <EditItemTemplate>
                            <%--<asp:Label ID="lblTransType" runat="server" Text='<%# Bind("TransType") %>'></asp:Label>--%>
                            <asp:DropDownList ID="ddlTransType" runat="server" AppendDataBoundItems="true" SelectedValue='<%# Bind("TransType") %>'>
                                <asp:ListItem Text="Cr" Value="Cr"></asp:ListItem>
                                <asp:ListItem Text="Dr" Value="Dr"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorddlFileType" runat="server"
                                ControlToValidate="ddlTransType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <%--<asp:Label ID="lblTransType" runat="server" Text='<%# Bind("TransType") %>'></asp:Label>--%>
                            <asp:DropDownList ID="ddlTransType" runat="server" AppendDataBoundItems="true" SelectedValue='<%# Bind("TransType") %>'>
                                <asp:ListItem Text="Cr" Value="Cr"></asp:ListItem>
                                <asp:ListItem Text="Dr" Value="Dr"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorddlFileType" runat="server"
                                ControlToValidate="ddlTransType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblTransType" runat="server" Text='<%# Bind("TransType") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Insert By" InsertVisible="false" SortExpression="InsertBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP" Username='<%# Eval("InsertBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Update By" InsertVisible="false" SortExpression="UpdateBy">
                        <ItemTemplate>
                            <uc3:EMP ID="EMP1" Username='<%# Eval("UpdateBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False" ControlStyle-Width="80px">
                        <EditItemTemplate>
                            <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" Enabled="false" CommandName="Update"
                                Text="Update" />
                            <asp:ConfirmButtonExtender ID="conUpdate" runat="server" ConfirmText="Do you want to Update?"
                                TargetControlID="cmdUpdate">
                            </asp:ConfirmButtonExtender>
                            &nbsp;<asp:Button ID="cmdCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="Cancel" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:Button ID="cmdInsert" runat="server" CausesValidation="True" Enabled="false" CommandName="Insert"
                                Text="Save" />
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
            <asp:SqlDataSource ID="SqlDataSourcePartySetup" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM PartySetup WHERE PartyID = @PartyID" InsertCommand="s_PartySetup_insert"
                InsertCommandType="StoredProcedure" UpdateCommand="s_PartySetup_insert" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSourcePartySetup_Inserted" 
                OnUpdated="SqlDataSourcePartySetup_Updated" 
                onselected="SqlDataSourcePartySetup_Selected">
                <InsertParameters>
                    <asp:Parameter Name="TransCategory" Type="String" />
                    <asp:Parameter Name="PartyName" Type="String" />
                    <asp:Parameter Name="CommissionPercent" Type="Decimal" />
                    <asp:Parameter Name="AccountNo" Type="String" />
                    <asp:Parameter Name="TransType" Type="String" />
                    <asp:SessionParameter Name="InsertBy" SessionField="EMPID" Type="String" />
                    <asp:Parameter Direction="InputOutput" Name="PartyID" Type="Int32" DefaultValue="0" />
                    <asp:Parameter Direction="InputOutput" Name="msg" Type="String" Size="250" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidPartyID" Name="PartyID" PropertyName="Value"
                        DefaultValue="-1" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:ControlParameter ControlID="hidPartyID" Name="PartyID" PropertyName="Value"
                        Type="Int32" />
                    <asp:Parameter Name="TransCategory" Type="String" />
                    <asp:Parameter Name="PartyName" Type="String" />
                    <asp:Parameter Name="CommissionPercent" Type="Decimal" />
                    <asp:Parameter Name="AccountNo" Type="String" />
                    <asp:Parameter Name="TransType" Type="String" />
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
                        <asp:BoundField DataField="TransCategory" HeaderText="Trans Category" SortExpression="TransCategory"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="PartyID" HeaderText="Party ID" SortExpression="PartyID"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="PartyName" HeaderText="Party Name" SortExpression="PartyName"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="CommissionPercent" HeaderText="Commission Percent" SortExpression="CommissionPercent"
                            ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="AccountNo" HeaderText="Account No" SortExpression="AccountNo"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="TransType" HeaderText="Trans Type" SortExpression="TransType"
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:TemplateField HeaderText="Insert By" SortExpression="InsertBy" InsertVisible="false">
                            <ItemTemplate>
                                <uc3:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBy") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="InsertDT" HeaderText="Upload Date" SortExpression="InsertDT"
                            InsertVisible="false" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-HorizontalAlign="Center" />
                        <asp:TemplateField HeaderText="Update By" SortExpression="UpdateBy" InsertVisible="false">
                            <ItemTemplate>
                                <uc3:EMP ID="EMP12" runat="server" Username='<%# Eval("UpdateBy") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="UpdateDT" HeaderText="Update Date" SortExpression="UpdateDT"
                            InsertVisible="false" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd-MMM-yyyy}" />
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
                    SelectCommand="SELECT * FROM PartySetup order by PartyID"></asp:SqlDataSource>
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
