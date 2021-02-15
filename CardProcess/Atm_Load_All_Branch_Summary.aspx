<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Atm_Load_All_Branch_Summary.aspx.cs" Inherits="Atm_Load_All_Branch_Summary" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Atm_Load_All_Branch_Summary.aspx.cs" Inherits="Atm_Load_All_Branch_Summary" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text="Branch Load Summary"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <table>
                <tr>
                    <td>
                        <table class="Panel1 ui-corner-all">
                            <tr>                                                               
                                
                                <td>
                                    Start Date:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="Date" Width="75px" AutoPostBack="true"></asp:TextBox>
                                </td>

                                <td>
                                    End Date:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="Date" Width="75px" AutoPostBack="true"></asp:TextBox>
                                </td>
                                
                                <td style="padding-left: 10px; white-space: nowrap">
                                    Loaded From:
                                </td>
                                <td>
                                    <asp:DropDownList ID="dboBranch" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                        CausesValidation="false" DataSourceID="SqlDataSourceBranchName" DataTextField="BranchName"
                                        DataValueField="BranchID" OnDataBound="dboBranch_DataBound">
                                        <asp:ListItem Text="All Branch" Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="Head Office" Value="1"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceBranchName" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="SELECT
        BranchID ,
        BranchName
FROM    dbo.viewBranchOnly         
ORDER BY BranchName" EnableCaching="true" CacheDuration="600"></asp:SqlDataSource>
                                </td>
                                <td style="padding-left: 10px; white-space: nowrap">
                                    Status:
                                </td>
                                <td>
                                    <asp:DropDownList ID="dboStatus" runat="server" AutoPostBack="true">
                                        <asp:ListItem Text="Confirmed" Value="L"></asp:ListItem>
                                        <asp:ListItem Text="Ready to Confirm" Value="O"></asp:ListItem>
                                        <asp:ListItem Text="Show All" Value="*"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                
                                <td>
                                    <asp:Button ID="cmdSearch" runat="server" Text="Generate" Width="80px" Style="font-weight: 700" />
                                </td>
                            </tr>
                        </table>
                    </td> 
                    
                    <td>
                            <asp:LinkButton ID="cmdPreviousDay" runat="server" OnClick="cmdPreviousDay_Click"
                                ToolTip="Previous Day" CssClass="button-round"><img src="Images/Previous.gif" width="32px" height="32px" border="0" /></asp:LinkButton>
                            <asp:LinkButton ID="cmdNextDay" runat="server" OnClick="cmdNextDay_Click" ToolTip="Next Day"
                                CssClass="button-round"><img src="Images/Next.gif" width="32px" height="32px" border="0" /></asp:LinkButton>
                        </td>
                                      
                </tr>
            </table>

            <table style="margin-left: 20px">
                <tr>
                    <td class="bold">
                        Summary:
                    </td>
                    <td>
                        <div class="group" style="display: inline-block; padding: 5px; margin-bottom: 0">
                            Before Load:
                            <asp:Label ID="lblBeforeLoadAmount" runat="server" Text="0.00" Font-Size="Large"></asp:Label></div>
                    </td>
                    <td class="bold">
                        +
                    </td>
                    <td>
                        <div class="group" style="display: inline-block; padding: 5px; margin-bottom: 0">
                            Load:
                            <asp:Label ID="lblLoadAmount" runat="server" Text="0.00" Font-Size="Large"></asp:Label></div>
                    </td>
                    <td class="bold">
                        =
                    </td>
                    <td>
                        <div class="group" style="display: inline-block; padding: 5px; margin-bottom: 0">
                            After Load:
                            <asp:Label ID="lblAfterLoadAmount" runat="server" Text="0.00" Font-Size="Large"></asp:Label></div>
                    </td>
                </tr>
            </table>


            <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" CssClass="Grid"
                AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                AllowPaging="True" AllowSorting="True" PageSize="7" PagerSettings-Mode="NumericFirstLast"
                PagerSettings-PageButtonCount="30" PagerSettings-Position="TopAndBottom" OnRowUpdated="GridView1_RowUpdated"
                OnRowCommand="GridView1_RowCommand" OnPageIndexChanged="GridView1_PageIndexChanged"
                OnSorted="GridView1_Sorted">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <%--<asp:BoundField DataField="FeedingBranch" HeaderText="Feeding Branch" 
                        SortExpression="FeedingBranch" />      --%>                  
                    <asp:BoundField DataField="FeedingBranchName" HeaderText="Load Branch" 
                        SortExpression="FeedingBranchName" />
                    <asp:TemplateField HeaderText="Before Load Amount" SortExpression="BeforeLoadAmount">
                        <ItemTemplate>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("BeforeLoadAmount"))%>
                        </ItemTemplate>
                        <ItemStyle CssClass="right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Load Amount" SortExpression="LoadAmount">
                        <ItemTemplate>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("LoadAmount"))%>
                        </ItemTemplate>
                        <ItemStyle CssClass="right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="After Load Amount" SortExpression="AfterLoadAmount">
                        <ItemTemplate>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("AfterLoadAmount"))%>
                        </ItemTemplate>
                        <ItemStyle CssClass="right" />
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="30" Position="TopAndBottom" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_ATM_Single_Branch_Load_Summary" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="dboBranch" Name="FeedingBranch" PropertyName="SelectedValue"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="dboStatus" Name="Status" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:ControlParameter ControlID="txtStartDate" Name="StartDate" PropertyName="Text"
                        Type="DateTime" />
                    <asp:ControlParameter ControlID="txtEndDate" Name="EndDate" PropertyName="Text"
                        Type="DateTime" />
                    <asp:Parameter Name="BeforeLoadAmount" Type="Double" Direction="InputOutput" DefaultValue="0" />
                    <asp:Parameter Name="LoadAmount" Type="Double" Direction="InputOutput" DefaultValue="0" />
                    <asp:Parameter Name="AfterLoadAmount" Type="Double" Direction="InputOutput" DefaultValue="0" />                    
                    <%--<asp:ControlParameter ControlID="dboIsLatest" Name="isLatest" PropertyName="SelectedValue"
                        Type="String" />--%>
                    <%--<asp:ControlParameter ControlID="txtSearch" Name="Filter" PropertyName="Text" Type="String"
                        DefaultValue="*" />--%>
                    <asp:SessionParameter Name="EmpBranch" SessionField="BRANCHID" Type="Int32" />
                </SelectParameters>                
            </asp:SqlDataSource>
            <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
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


