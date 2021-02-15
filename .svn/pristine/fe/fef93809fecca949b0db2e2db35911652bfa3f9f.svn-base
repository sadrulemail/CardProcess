<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Banks.aspx.cs" Inherits="Banks" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    All Banks Info
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="4" DataKeyNames="BEFTN_Bank_Code" DataSourceID="SqlDataSource1"
                ForeColor="Black" GridLines="Vertical" Style="font-size: small"
                AllowSorting="True">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <Columns>
                    <asp:BoundField DataField="SL" HeaderText="SL"
                        SortExpression="SL" />
                    <asp:TemplateField HeaderText="" HeaderStyle-Font-Bold="true">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="SELECT" CommandArgument='<%# Eval("SL") %>'
                                Height="20px" ToolTip="Open" CausesValidation="false">
                                <img alt="" height="16px" width="16px" src='Images/new_window.png' border="0" />
                            </asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="BEFTN_Bank_Code" HeaderText="BEFTN Bank Code"
                        ReadOnly="True" SortExpression="BEFTN_Bank_Code" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />
                    <asp:BoundField DataField="Bank_Name" HeaderText="Bank Name"
                        SortExpression="Bank_Name" />
                    <asp:BoundField DataField="WebAddress" HeaderText="Web Address"
                        SortExpression="WebAddress" />
                    <asp:BoundField DataField="HOAddress" HeaderText="Head Office Address"
                        SortExpression="HOAddress" />
                    <asp:TemplateField HeaderText="Contact Details" SortExpression="FIO" ItemStyle-Font-Size="11pt">
                        <ItemTemplate>
                            <%# Eval("CardContactPerson","<div>{0}</div>") %>
                            <%# Eval("CardContactNumber","<div>{0}</div>")%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Insert By" InsertVisible="False" SortExpression="InsertBy">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP1" Username='<%# Eval("InsertBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Update By" InsertVisible="False" SortExpression="UpdateBy">
                        <ItemTemplate>
                            <uc2:EMP ID="EMP221" Username='<%# Eval("UpdateBy") %>' runat="server" />
                            <span class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton runat="server"
                                ID="lnkDelete"
                                CommandArgument='<%# Eval("SL") %>'
                                CommandName="Delete"><img src="Images/cross.png" /></asp:LinkButton>
                            <asp:ConfirmButtonExtender runat="server" ID="con1"
                                TargetControlID="lnkDelete" ConfirmText="Do you want to Delete?" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                </Columns>
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:Label ID="lblMsg" Text="" runat="server" Visible="false"></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM TblUserDB.dbo.Banks" OnSelected="SqlDataSource1_Selected"
                >
                <%--<DeleteParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="SL"
                        PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" Type="String" />
                </DeleteParameters>--%>
            </asp:SqlDataSource>
            <br />
            <br />

            <%--Modal Popup--%>

            <span style="visibility: hidden">
                <asp:Button runat="server" ID="cmdPopup" /></span>
            <asp:ModalPopupExtender ID="modal" runat="server" CancelControlID="ModalClose"
                TargetControlID="cmdPopup"
                PopupControlID="ModalPanel"
                BackgroundCssClass="ModalPopupBG"
                RepositionMode="RepositionOnWindowResizeAndScroll"
                CacheDynamicResults="False"
                Drag="true">
            </asp:ModalPopupExtender>
            <asp:Panel ID="ModalPanel" runat="server"
                CssClass="ModalPanel1">
                <div style="background: green">
                    <asp:Panel runat="server" ID="ModalTitleBar" CssClass="MoveIcon"
                        HorizontalAlign="Center">
                        <table width="100%">
                            <tr>
                                <td align="left" style="color: White; font-size: 14pt; font-weight: bolder">
                                    <asp:Label ID="ModalTitle" runat="server" Text="Delivery Info"></asp:Label>
                                </td>
                                <td align="right">
                                    <a href="#" style="cursor: default">
                                        <asp:Image ID="ModalClose" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close" />
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                        BorderStyle="Solid" BorderWidth="1px" CssClass="Grid modal-table" CellPadding="4" DataSourceID="SqlDataSource2"
                        ForeColor="Black" AutoGenerateRows="False" OnItemInserted="DetailsView1_ItemInserted"
                        OnItemUpdated="DetailsView1_ItemUpdated" DataKeyNames="SL" OnModeChanged="DetailsView1_ModeChanged"
                        OnDataBound="DetailsView1_DataBound">
                        <FooterStyle BackColor="#CCCC99" />
                        <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" />
                        <Fields>
                            <asp:TemplateField HeaderText="SL">
                                <ItemTemplate>
                                    <asp:Label ID="lblSL" runat="server" Text='<%# Bind("SL") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="BEFTN Bank Code">
                                <ItemTemplate>
                                    <asp:Label ID="lblBEFTN_Bank_Code" runat="server" Text='<%# Bind("BEFTN_Bank_Code") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bank Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblBank_Name" runat="server" Text='<%# Bind("Bank_Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Web Address">
                                <ItemTemplate>
                                    <asp:Label ID="lblWebAddress" runat="server" Text='<%# Bind("WebAddress") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="HO Address" SortExpression="HOAddress">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtHOAddress" Width="300px" MaxLength="255" runat="server" Text='<%# Bind("HOAddress") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtHOAddress"
                                        ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="txtHOAddress" MaxLength="255" Width="300px" runat="server" Text='<%# Bind("HOAddress") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtHOAddress"
                                        ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblHOAddress" Width="300px" runat="server" Text='<%# Bind("HOAddress") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Card Contact Person" SortExpression="CardContactPerson">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCardContactPerson" Width="300px" MaxLength="255" runat="server" Text='<%# Bind("CardContactPerson") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNAMEONCARD"
                                        ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="txtCardContactPerson" MaxLength="255" Width="300px" runat="server" Text='<%# Bind("CardContactPerson") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNAMEONCARD"
                                        ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCardContactPerson" Width="300px" runat="server" Text='<%# Bind("CardContactPerson") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Card Contact Number" SortExpression="CardContactNumber">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCardContactNumber" Width="300px" MaxLength="255" runat="server" Text='<%# Bind("CardContactNumber") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCardContactNumber"
                                        ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="txtCardContactNumber" MaxLength="255" Width="300px" runat="server" Text='<%# Bind("CardContactNumber") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCardContactNumber"
                                        ForeColor="Red" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCardContactNumber" Width="300px" runat="server" Text='<%# Bind("CardContactNumber") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False" ControlStyle-Width="100px" Visible="true">
                                <EditItemTemplate>
                                    <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="Update" />
                                    <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Do you want to Update?"
                                        Enabled="True" TargetControlID="cmdUpdate"></asp:ConfirmButtonExtender>
                                    &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="Cancel" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit"
                                        Text="Edit" />
                                </ItemTemplate>
                                <ControlStyle Width="100px" />
                            </asp:TemplateField>
                        </Fields>
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:DetailsView>


                </div>
            </asp:Panel>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Banks_Browse" SelectCommandType="StoredProcedure" UpdateCommand="s_Forwarding_Delivery_Branch_Update"
                UpdateCommandType="StoredProcedure" OnUpdated="SqlDataSource2_Updated">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="SL" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="AccountNo" />
                    <asp:Parameter Name="CardNumber" />
                    <asp:Parameter Name="Batch" />
                    <asp:Parameter Name="DeliveryToBranch" />
                    <asp:SessionParameter Name="EmpID" SessionField="EMPID" />
                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" DefaultValue="" Size="250" />
                </UpdateParameters>
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
