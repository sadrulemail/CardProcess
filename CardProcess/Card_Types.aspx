<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Card_Types.aspx.cs" Inherits="Card_Types" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Card Types
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <asp:Button ID="cmdNew" runat="server" Text="Add New Card Type" Width="180px" OnClick="cmdNew_Click" />
            <asp:DetailsView ID="DetailsView1" runat="server" CssClass="Grid" AutoGenerateRows="False"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="4" DataKeyNames="CardTypeCode" DataSourceID="SqlDataSource2" ForeColor="Black"
                GridLines="Vertical" Style="font-size: small">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <Fields>
                    <asp:BoundField DataField="CardTypeCode" HeaderText="Type Code" ReadOnly="True" SortExpression="CardTypeCode"
                        ControlStyle-Width="150px" ItemStyle-Font-Bold="true">
                        <ControlStyle Width="150px" />
                    </asp:BoundField>
                    <%--<asp:BoundField DataField="CardType" HeaderText="Card Type" 
                        ReadOnly="True" SortExpression="CardType" ControlStyle-Width="400px" />--%>
                    <asp:TemplateField HeaderText="Type Name" SortExpression="CardType">
                        <ItemTemplate>
                            <asp:Label ID="lblCardType" runat="server" Text='<%# Bind("CardType") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCardType" runat="server" Text='<%# Bind("CardType") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCardType"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtCardType" runat="server" Text='<%# Bind("CardType") %>' Width="400px"
                                MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCardType"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Fee" SortExpression="Card_IssueFee">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Card_IssueFee", "{0:N2}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Card_IssueFee", "{0:N2}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Card_IssueFee", "{0:N2}") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Re-issue Fee" SortExpression="Card_ReissueFee">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Card_ReissueFee", "{0:N2}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Card_ReissueFee", "{0:N2}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Card_ReissueFee", "{0:N2}") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PIN Re-issue Fee" SortExpression="PIN_IssueFee">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PIN_IssueFee", "{0:N2}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PIN_IssueFee", "{0:N2}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("PIN_IssueFee", "{0:N2}") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="HO" HeaderText="HO" SortExpression="HO" />
                    <asp:CheckBoxField DataField="BR" HeaderText="BR" SortExpression="BR" />
                    <asp:TemplateField HeaderText="Annual Fees" SortExpression="AnnualFees">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtAnnualFees" runat="server" Text='<%# Bind("AnnualFees", "{0:N2}") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtAnnualFees" runat="server" Text='<%# Bind("AnnualFees", "{0:N2}") %>'></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label33333333" runat="server" Text='<%# Bind("AnnualFees", "{0:N2}") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Type" SortExpression="Type">
                        <EditItemTemplate>
                            <asp:DropDownList ID="dboType" runat="server" DataTextField="Name" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="dboType_SelectedIndexChanged">
                                <asp:ListItem Text="Primary" Value="P"></asp:ListItem>
                                <asp:ListItem Text="Supplimentary" Value="S"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator22223453222" runat="server"
                                ControlToValidate="dboType" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="dboType" runat="server" DataTextField="Name" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="dboType_SelectedIndexChanged">
                                <asp:ListItem Text="Primary" Value="P"></asp:ListItem>
                                <asp:ListItem Text="Supplimentary" Value="S"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator222sdf2222" runat="server"
                                ControlToValidate="dboType" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label333" runat="server" Text='<%# Bind("Type") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="SupplimentoryAllow" HeaderText="SupplimentoryAllow"
                        SortExpression="SupplimentoryAllow" />
                    <asp:TemplateField HeaderText="Validity Month" SortExpression="ValidityMonth">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtValidityMonth" runat="server" Text='<%# Bind("ValidityMonth", "{0:N0}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2222222" runat="server" ControlToValidate="txtValidityMonth"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtValidityMonth" runat="server" Text='<%# Bind("ValidityMonth", "{0:N0}") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator222233222" runat="server" ControlToValidate="txtValidityMonth"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label33" runat="server" Text='<%# Bind("ValidityMonth", "{0:N0}") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="PictureRequired" HeaderText="Picture Required"
                        SortExpression="PictureRequired" />
                    <asp:CommandField ShowInsertButton="true" ButtonType="Button" ShowEditButton="True"
                        ControlStyle-Width="80px">
                        <ControlStyle Width="80px" />
                    </asp:CommandField>
                </Fields>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                InsertCommand="s_CardTypes_Insert" InsertCommandType="StoredProcedure" SelectCommand="SELECT * FROM [CardTypes] WHERE ([CardTypeCode] = @CardTypeCode)"
                SelectCommandType="Text" UpdateCommand="s_CardTypes_Update" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSource2_Inserted" OnUpdated="SqlDataSource2_Updated">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="CardTypeCode" PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CardTypeCode" />
                    <asp:Parameter Name="CardType" />
                    <asp:Parameter Name="HO" />
                    <asp:Parameter Name="BR" />
                    <asp:Parameter Name="Card_IssueFee" DefaultValue="0" />
                    <asp:Parameter Name="Card_ReissueFee" DefaultValue="0" />
                    <asp:Parameter Name="PIN_IssueFee" DefaultValue="0" />
                    <asp:Parameter Name="AnnualFees" DefaultValue="0" />
                    <asp:Parameter Name="SupplimentoryAllow" />
                    <asp:Parameter Name="PictureRequired" />
                    <asp:Parameter Name="ValidityMonth" DefaultValue="0" />
                    <asp:ControlParameter Name="Type" ControlID="ctl00$ContentPlaceHolder2$DetailsView1$dboType"
                        PropertyName="SelectedValue" Type="String" />
                    <%-- <asp:Parameter Name="Type" />--%>
                    <asp:SessionParameter Name="UpdateBy" SessionField="EMPID" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="CardTypeCode" />
                    <asp:Parameter Name="CardType" />
                    <asp:Parameter Name="HO" />
                    <asp:Parameter Name="BR" />
                    <asp:Parameter Name="Card_IssueFee" DefaultValue="0" />
                    <asp:Parameter Name="Card_ReissueFee" DefaultValue="0" />
                    <asp:Parameter Name="PIN_IssueFee" DefaultValue="0" />
                    <asp:Parameter Name="AnnualFees" DefaultValue="0" />
                    <asp:Parameter Name="SupplimentoryAllow" />
                    <asp:Parameter Name="PictureRequired" />
                    <asp:Parameter Name="ValidityMonth" DefaultValue="0" />
                    <asp:ControlParameter Name="Type" ControlID="ctl00$ContentPlaceHolder2$DetailsView1$dboType"
                        PropertyName="SelectedValue" Type="String" />
                    <asp:SessionParameter Name="InsertBy" SessionField="EMPID" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="5" DataKeyNames="CardTypeCode" DataSourceID="SqlDataSource1" ForeColor="Black"
                GridLines="Vertical" Style="font-size: small" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"><img src="Images/edit-label.png" width="20" height="20" border="0" /></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Font-Bold="True" ForeColor="Blue" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="CardTypeCode" HeaderText="Type Code" ReadOnly="True" SortExpression="CardTypeCode"
                        ItemStyle-Font-Bold="true">
                        <ItemStyle Font-Bold="True" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Card Type" SortExpression="CardType" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("CardType")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="HO" HeaderText="HO" ItemStyle-HorizontalAlign="Center"
                        SortExpression="HO">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:CheckBoxField DataField="BR" HeaderText="BR" ItemStyle-HorizontalAlign="Center"
                        SortExpression="BR">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:TemplateField HeaderText="Issue Fee" SortExpression="Card_IssueFee" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <%# Eval("Card_IssueFee", "{0:N2}")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Re-issue Fee" SortExpression="Card_ReissueFee" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <%# Eval("Card_ReissueFee", "{0:N2}")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PIN Re-issue Fee" SortExpression="PIN_IssueFee" ItemStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <%# Eval("PIN_IssueFee", "{0:N2}")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="AnnualFees" HeaderText="Annual Fees" SortExpression="AnnualFees"
                        DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="SupplimentoryAllow" HeaderText="Supplimentory<br>Allow"
                        ItemStyle-HorizontalAlign="Center" SortExpression="SupplimentoryAllow">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:TemplateField HeaderText="Validity" SortExpression="ValidityMonth">
                        <ItemTemplate>
                            <%# Eval("ValidityMonth", "{0:N0} M") %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" ItemStyle-HorizontalAlign="Left">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="PictureRequired" HeaderText="Picture Required" ItemStyle-HorizontalAlign="Center"
                        SortExpression="PictureRequired">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
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
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#FFA200" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM [CardTypes] ORDER BY [CardType]"></asp:SqlDataSource>
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
