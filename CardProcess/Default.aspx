<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style2 {
            font-size: x-large;
            font-weight: bold;
            color: silver;
        }

        .style3 {
            font-size: small;
        }

        .style5 {
            color: #666666;
        }

        .ROW2 {
            background-image: url('Images/bg7.gif');
            background-position: top;
            background-repeat: repeat-x;
            background-color: White;
            cursor: default;
        }

        .style6 {
            width: 526px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:Panel ID="Panel1" runat="server" Style="text-align: left">
        <table style="font-weight: bold;" cellpadding="10px">
            <tr>
                <td align="center" valign="top">
                    <a href="Search.aspx" class="Link" title="Search Cards">
                        <img src="Images/search-icon.png" class="imagebutton" /><br />
                        Search</a>
                </td>
                <td align="center" valign="top">
                    <a href="Search_Adv.aspx" class="Link" title="Advanced Search">
                        <img src="Images/search-icon.png" class="imagebutton" /><br />
                        Advanced Search</a>
                </td>
                <td align="center" valign="top">
                    <a href="Card_AddEdit.aspx" class="Link" title="Add New Card Request">
                        <img src="Images/new-card-icon.png" class="imagebutton" /><br />
                        New Card</a>
                </td>
                <td align="center" valign="top">
                    <a href="New_Reissue_Request.aspx" class="Link" title="Add Reissue Card Request">
                        <img src="Images/Card-reissue-icon.png" class="imagebutton" /><br />
                        Reissue Card</a>
                </td>
                <td align="center" valign="top">
                    <a href="ForwardingPending.aspx" class="Link" title="Card Forwarding Receive at Branch">
                        <img src="Images/receive-icon.png" class="imagebutton" /><br />
                        Receive Card</a>
                </td>
                <td align="center" valign="top">
                    <a href="Card_Activation_Request.aspx" class="Link" title="Add Card Activation Request">
                        <img src="Images/Activate-icon.png" class="imagebutton" /><br />
                        Activate Card</a>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td style="padding: 80px 50px 0px 0px" valign="bottom" class="style6">
                    <div class="style2">
                        you logged in as
                    </div>
                    <table cellspacing="0" cellpadding="5px" class="Panel1 ui-corner-all">
                        <tr>
                            <td>
                                <b><span class="style3"><span class="style5">Branch:<br />
                                </span>
                                    <asp:DropDownList ID="cboBranch" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSourceBranch"
                                        BackColor="Yellow" Font-Size="Large" Font-Bold="true" ForeColor="Navy" DataTextField="BranchName"
                                        DataValueField="BranchID" Enabled="False" OnDataBound="cboBranch_DataBound">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="SELECT [BranchID], [BranchName] FROM [ViewBranch] where branchid = @branchid">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="branchid" SessionField="BRANCHID" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </span></b>
                            </td>
                            <td>
                                <b><span class="style3"><span class="style5">Department:<br />
                                </span>
                                    <asp:DropDownList ID="cboDept" runat="server" DataSourceID="SqlDataSourceDepartment"
                                        BackColor="Yellow" Font-Size="Large" Font-Bold="true" ForeColor="Navy" DataTextField="Department"
                                        DataValueField="DeptID" Enabled="False" OnDataBound="cboDept_DataBound">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:TblUserDBConnectionString %>"
                                        SelectCommand="SELECT [DeptID], [Department] FROM [Department] WHERE ([RevID] = @RevID and deptid=@deptid) ORDER BY [Department]">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="9999" Name="RevID" Type="Int32" />
                                            <asp:SessionParameter Name="deptid" SessionField="DEPTID" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </span></b>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>    
</asp:Content>
