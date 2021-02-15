<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Branch_Mark.aspx.cs" Inherits="Branch_Mark" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Branch Location Mark
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <asp:HiddenField runat="server" ID="hidBranchID" Value="" />
            <asp:Button ID="cmdNew" runat="server" Text="Mark New Branch" Width="180px" OnClick="cmdNew_Click" />
            <asp:DetailsView ID="DetailsView1" runat="server" CssClass="Grid" AutoGenerateRows="False"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="4" DataKeyNames="BranchID" DataSourceID="SqlDataSource2" ForeColor="Black"
                GridLines="Vertical" Style="font-size: small">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <Fields>
                    <asp:TemplateField HeaderText="Branch" SortExpression="BranchName">
                        <ItemTemplate>
                            <%# Eval("BranchName")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="dboBranchName" runat="server" DataSourceID="SqlDataSource3" SelectedValue='<%# Bind("BranchID") %>'
                                DataTextField="BranchName" DataValueField="BranchID" AppendDataBoundItems="true" Enabled="false">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2222345223222" runat="server"
                                ControlToValidate="dboBranchName" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="dboBranchName" runat="server" DataSourceID="SqlDataSource6" SelectedValue='<%# Bind("BranchID") %>'
                                DataTextField="BranchName" DataValueField="BranchID" AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2222345223222" runat="server"
                                ControlToValidate="dboBranchName" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Location Name" SortExpression="LocationName">
                        <ItemTemplate>
                            <%# Eval("LocationName")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="dboLocationType" runat="server" DataSourceID="SqlDataSource1" SelectedValue='<%# Bind("LocationType") %>'
                                DataTextField="LocationName" DataValueField="LocationID" AppendDataBoundItems="true">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator22223453222" runat="server"
                                ControlToValidate="dboLocationType" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="dboLocationType" runat="server" DataSourceID="SqlDataSource1" SelectedValue='<%# Bind("LocationType") %>'
                                DataTextField="LocationName" DataValueField="LocationID" AppendDataBoundItems="true">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator22223453222" runat="server"
                                ControlToValidate="dboLocationType" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
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
                InsertCommand="s_Branch_Location_Mark_Insert_Update" InsertCommandType="StoredProcedure" SelectCommand="SELECT * FROM v_Branch_Location_Mark where BranchID=@BranchID"
                SelectCommandType="Text" UpdateCommand="s_Branch_Location_Mark_Insert_Update" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSource2_Inserted" OnUpdated="SqlDataSource2_Updated">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidBranchID" Name="BranchID" PropertyName="Value"
                        Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="BranchID" Type="Int32" Direction="InputOutput" DefaultValue="0" />
                    <asp:Parameter Name="LocationType" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" />
                    <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="BranchID" Type="Int32" Direction="InputOutput" DefaultValue="0" />
                    <asp:Parameter Name="LocationType" />
                    <asp:SessionParameter Name="Emp" SessionField="EMPID" />
                    <asp:Parameter Name="Done" Type="Boolean" Direction="InputOutput" DefaultValue="false" />
                    <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" Size="250" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:TabContainer runat="server" ID="tabContainer" CssClass="NewsTab" OnDemand="true"
                ActiveTabIndex="0" Width="100%" OnActiveTabChanged="tabContainer_ActiveTabChanged">
                <asp:TabPanel runat="server" ID="tab1">
                    <HeaderTemplate>
                        Details
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                            CellPadding="5" DataKeyNames="BranchID" DataSourceID="SqlDataSource4" ForeColor="Black"
                            GridLines="Vertical" Style="font-size: small" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                            <FooterStyle BackColor="#CCCC99" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lblSelect" runat="server"
                                            CausesValidation="false" CommandName="Select" ToolTip="edit the record">
                                <img src="Images/edit-label.png" width="20" height="20" border="0" />
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="BranchID" HeaderText="BranchID" SortExpression="BranchID" />
                                <asp:TemplateField HeaderText="Branch Name" SortExpression="BranchName" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%# Eval("BranchName")%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location Type" SortExpression="LocationName" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%# Eval("LocationName")%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Branch Address" SortExpression="BranchAddress" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%# Eval("BranchAddress")%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Inserted on" SortExpression="InsertDT">
                                    <ItemTemplate>
                                        <div class="time-small" title='<%# Eval("DT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
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
                        <asp:Label ID="lblRecord" runat="server" Text="" Visible="false"></asp:Label>
                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="SELECT * FROM v_Branch_Location_Mark order by branchid" SelectCommandType="Text" OnSelected="SqlDataSource4_Selected"></asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tab2">
                    <HeaderTemplate>
                        Summary
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                            CellPadding="5" DataSourceID="SqlDataSource5" ForeColor="Black"
                            GridLines="Vertical" Style="font-size: small" AllowSorting="True">
                            <FooterStyle BackColor="#CCCC99" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <Columns>
                                <asp:BoundField DataField="LocationName" HeaderText="Location Type" SortExpression="LocationName" />
                                <asp:BoundField DataField="total" HeaderText="Total" SortExpression="total" />
                            </Columns>
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#FFA200" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>

                        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="SELECT  LocationName ,COUNT(*) total FROM    dbo.v_Branch_Location_Mark GROUP BY LocationName" SelectCommandType="Text"></asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
                <asp:TabPanel runat="server" ID="tab3">
                    <HeaderTemplate>
                        Pending Branch
                    </HeaderTemplate>
                    <ContentTemplate>
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                            CellPadding="5" DataSourceID="SqlDataSource7" ForeColor="Black"
                            GridLines="Vertical" Style="font-size: small" AllowSorting="True">
                            <FooterStyle BackColor="#CCCC99" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <Columns>
                                <asp:BoundField DataField="BranchID" HeaderText="Branch ID" SortExpression="BranchID" />
                                <asp:BoundField DataField="BranchName" HeaderText="Branch Name" SortExpression="BranchName" />
                                <asp:BoundField DataField="BranchAddress" HeaderText="Branch Address" SortExpression="BranchAddress" />
                            </Columns>
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#FFA200" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:Label ID="Label1" runat="server" Text="" Visible="false"></asp:Label>
                        <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="SELECT  BranchID ,BranchName,BranchAddress FROM dbo.v_BranchOnly WHERE   BranchID NOT IN ( SELECT BranchID FROM dbo.v_Branch_Location_Mark )" OnSelected="SqlDataSource7_Selected"></asp:SqlDataSource>
                    </ContentTemplate>
                </asp:TabPanel>
            </asp:TabContainer>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT * FROM Branch_Location_Type"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT BranchID ,BranchName  FROM v_BranchOnly"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="SELECT  BranchID ,BranchName FROM dbo.v_BranchOnly WHERE   BranchID NOT IN ( SELECT BranchID FROM dbo.v_Branch_Location_Mark )"></asp:SqlDataSource>


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
