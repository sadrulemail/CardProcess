<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="VIP_Tours.aspx.cs" Inherits="VIP_Tours" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <asp:Literal ID="lblTitle" runat="server" Text="Travel Details"></asp:Literal>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <asp:Button ID="cmdNew" runat="server" Text="Add New Travel Info" Width="180px" OnClick="cmdNew_Click" />
            <asp:HiddenField ID="hidITCLID" Value="" runat="server" />
            <asp:DetailsView ID="DetailsView1" runat="server" CssClass="Grid" AutoGenerateRows="False"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource2" ForeColor="Black"
                GridLines="Vertical" Style="font-size: small">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <Fields>
                    <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" InsertVisible="false"
                        ControlStyle-Width="150px" ItemStyle-Font-Bold="true">
                        <ControlStyle Width="150px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="ITCLID" SortExpression="ITCLID" InsertVisible="false">
                        <ItemTemplate>
                            <%# Eval("ITCLID") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="From Date" SortExpression="FromDate">
                        <ItemTemplate>
                            <asp:Label ID="lblFromDate" runat="server" Text='<%# Bind("FromDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="Date" Text='<%# Bind("FromDate","{0:dd/MM/yyyy}") %>'
                                MaxLength="20"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFromDate"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="Date" Text='<%# Bind("FromDate","{0:dd/MM/yyyy}") %>'
                                MaxLength="20"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFromDate"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="To Date" SortExpression="ToDate">
                        <ItemTemplate>
                            <asp:Label ID="lblToDate" runat="server" Text='<%# Bind("ToDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="Date" Text='<%# Bind("ToDate","{0:dd/MM/yyyy}") %>'
                                MaxLength="20"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorToDate" runat="server" ControlToValidate="txtToDate"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="Date" Text='<%# Bind("ToDate","{0:dd/MM/yyyy}") %>'
                                MaxLength="20"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorToDate" runat="server" ControlToValidate="txtToDate"
                                ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Country" SortExpression="Countrycode">
                        <EditItemTemplate>
                            <asp:DropDownList ID="dboContrycode" runat="server" DataSourceID="SqlDataSourceCountrycode" DataTextField="CountryName" DataValueField="CountryID" SelectedValue='<%# Bind("Countrycode") %>' AppendDataBoundItems="true">
                                <asp:ListItem Value="0" Text=""></asp:ListItem>
                            </asp:DropDownList>        
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("CountryName") %>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="dboContrycode" runat="server" DataSourceID="SqlDataSourceCountrycode" DataTextField="CountryName" DataValueField="CountryID" SelectedValue='<%# Bind("Countrycode") %>' AppendDataBoundItems="true">
                                <asp:ListItem Value="0" Text=""></asp:ListItem>
                            </asp:DropDownList>  
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remarks" SortExpression="Remarks">
                        <ItemTemplate>
                            <%# Eval("Remarks") %>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Bind("Remarks") %>' Width="400px"></asp:TextBox>
                        </InsertItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Bind("Remarks") %>' Width="400px"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowInsertButton="true" ButtonType="Button" ShowEditButton="True"
                        ControlStyle-Width="80px">
                        <ControlStyle Width="80px" />
                    </asp:CommandField>
                </Fields>
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSourceCountrycode" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="select * from v_country order by CountryName" SelectCommandType="Text"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                InsertCommand="s_VIP_Tours_Insert" InsertCommandType="StoredProcedure" SelectCommand="s_VIP_Single_Select"
                SelectCommandType="StoredProcedure" UpdateCommand="s_VIP_Tours_Insert" UpdateCommandType="StoredProcedure"
                OnInserted="SqlDataSource2_Inserted" OnUpdated="SqlDataSource2_Updated">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ID" />
                    <asp:ControlParameter Name="ITCLID" ControlID="hidITCLID" PropertyName="Value" />
                    <asp:Parameter Name="FromDate" Type="DateTime" />
                    <asp:Parameter Name="ToDate" Type="DateTime" />
                    <asp:Parameter Name="Countrycode" />
                    <asp:Parameter Name="Remarks" Type="String" Size="250" />
                    <asp:SessionParameter Name="InsertBY" SessionField="EMPID" />
                    <asp:Parameter Name="Msg" DefaultValue="" Direction="InputOutput" Type="String" Size="250" />
                    <asp:Parameter Name="Done" DefaultValue="false" Direction="InputOutput" Type="Boolean" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="ID" />
                    <asp:ControlParameter Name="ITCLID" ControlID="hidITCLID" PropertyName="Value" />
                    <asp:Parameter Name="FromDate" Type="DateTime" />
                    <asp:Parameter Name="ToDate" Type="DateTime" />
                    <asp:Parameter Name="Countrycode" />
                    <asp:Parameter Name="Remarks" Type="String" Size="250" />
                    <asp:SessionParameter Name="InsertBY" SessionField="EMPID" />
                    <asp:Parameter Name="Msg" DefaultValue="" Direction="InputOutput" Type="String" Size="250" />
                    <asp:Parameter Name="Done" DefaultValue="false" Direction="InputOutput" Type="Boolean" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                CellPadding="5" DataKeyNames="ID" DataSourceID="SqlDataSource1" ForeColor="Black"
                GridLines="Vertical" Style="font-size: small" AllowSorting="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDataBound="GridView1_RowDataBound">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"><img src="Images/edit-label.png" width="20" height="20" border="0" /></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Font-Bold="True" ForeColor="Blue" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="ITCLID" SortExpression="ITCLID" >
                        <ItemTemplate>
                            <a target="_blank" href='ITCL.aspx?ITCLID=<%# Eval("ITCLID") %>'><%# Eval("ITCLID")%></a>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Font-Bold="True" />
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="On Travel" SortExpression="OnTravel" >
                        <ItemTemplate>
                            <%# Eval("OnTravel").ToString() == "1" ? "<img src='Images/Travel.png' width='48' height='48' title='On Travel'>" : getTravelText(Eval("FromDate"), Eval("ToDate")) %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Customer Name" SortExpression="CustomerName" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <%# Eval("CustomerName")%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="From Date" SortExpression="FromDate">
                        <ItemTemplate>
                            <%# Eval("FromDate","{0:dd-MMM-yyyy}")%>
                            <div class="time-small"><%# TrustControl1.ToRelativeDay(Eval("FromDate"))%></div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="To Date" SortExpression="ToDate">
                        <ItemTemplate>
                            <%# Eval("ToDate","{0:dd-MMM-yyyy}")%>
                            <div class="time-small"><%# TrustControl1.ToRelativeDay(Eval("ToDate"))%></div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>                    
                    <asp:TemplateField HeaderText="Days" SortExpression="Days" >
                        <ItemTemplate>
                            <%# Eval("Days") %> Day<%# (int)Eval("Days") > 1 ? "s" : "" %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                     <asp:BoundField DataField="CountryName" HeaderText="Country Name" SortExpression="CountryName" />
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" ItemStyle-Font-Bold="true" />

                    <asp:TemplateField HeaderText="Inserted on" SortExpression="DT">
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_VIP_Tours_Browse" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ITCLID" QueryStringField="ITCLID" />
                     <asp:Parameter DbType="Date" Name="FromDate" DefaultValue="01/01/1900" />
                    <asp:Parameter DbType="Date" Name="ToDate" DefaultValue="01/01/1900" />
                    <asp:Parameter Name="CustomerName" Type="String" DefaultValue="*" />
                    <asp:Parameter Name="CountryCode" Type="String" DefaultValue="0" />
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