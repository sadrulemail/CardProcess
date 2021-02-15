﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    Inherits="ITCL" CodeFile="ITCL.aspx.cs" ValidateRequest="false" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function AsyncFileUpload1_StartUpload(sender, args) {
            var filename = args.get_fileName();
            var ext = filename.substring(filename.lastIndexOf(".") + 1);

            if (ext.toLowerCase() == 'jpg' || ext.toLowerCase() == 'pdf') {
                $('[tblid=lblUploadStatus]').html("<b>" + args.get_fileName() + "</b> is uploading...");
            }
            else {
                $('[tblid=lblUploadStatus]').html("Only <b>PDF</b> and <b>JPG</b> files can be uploaded.");
                throw {
                    name: "Invalid File Type",
                    level: "Error",
                    message: "",
                    htmlMessage: ""
                }
                return false;
            }
        }

        function UploadError() {
            $('#UploadBtn').hide();
        }

        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var contentType = args.get_contentType();
            var img = '';
            var imgurl = '';
            var text = "Size of " + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += " and content type is '" + contentType + "'.";
            }
            //alert(text);
            if (contentType == "application/pdf") {
                img = "ext/pdf.gif";
            }
            else if (contentType == "image/jpeg") {
                img = "ext/jpg.gif";
            }
            else {
                $('#UploadBtn').hide();
                $('[tblid=lblUploadStatus]').html('Only PDF and JPG files are allowed to upload.');
            }
            if (img != '') imgurl = '<img src="Images/' + img + '"/> ';
            $('#UploadBtn').show('Slow');
            $('[tblid=lblUploadStatus]').html(imgurl + '<b>' + filename + '</b><br>File uploaded successfully. Please click Attach.');
            $('#HidFileName').val(filename);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    ITCL ID #
    <asp:Label ID="lblITCLID" runat="server" Text=""></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="HidPageID" runat="server" Value="" />
            <asp:HiddenField ID="HidITCLID" runat="server" Value="" />
            <asp:HiddenField ID="HidFileName" ClientIDMode="Static" runat="server" Value="" />
            <asp:HiddenField ID="HidUploadTempFile" runat="server" Value="" />
            <table>
                <tr>
                    <td>
                        <asp:Button ID="cmdNew" runat="server" Text="Add Customer Details" Width="180px" OnClick="cmdNew_Click" Visible="false" />

                        <asp:DetailsView ID="DetailsView2" runat="server" CssClass="Grid hide-blank-detailsview" AutoGenerateRows="False"
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                            CellPadding="3" DataKeyNames="ITCLID" DataSourceID="SqlDataSource33" ForeColor="Black"
                            GridLines="Vertical" Style="font-size: small" OnDataBound="DetailsView2_DataBound">
                            <FooterStyle BackColor="#CCCC99" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <Fields>
                                <asp:BoundField DataField="ITCLID" HeaderText="ITCL ID" ReadOnly="True" SortExpression="ITCLID" InsertVisible="false"
                                    ControlStyle-Width="150px" ItemStyle-Font-Bold="true">
                                    <ControlStyle Width="150px" />
                                    <ItemStyle Font-Bold="True" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Customer Name" SortExpression="CustomerName">
                                    <ItemTemplate>
                                        <%# Eval("CustomerName") %><%# (int.Parse(Eval("VIP").ToString())) > 0 ? "<img style='margin-left:10px;float:right' src='Images/vip.gif' title='VIP Customer' />" : "" %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCustomerName" runat="server" Text='<%# Bind("CustomerName") %>' Width="400px"
                                            MaxLength="255"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorCustomerName" runat="server" ControlToValidate="txtCustomerName"
                                            ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemStyle Font-Bold="true" Font-Size="Medium" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Gender" SortExpression="Gender">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="dboGender" runat="server" DataTextField="GenderName" DataValueField="GenderID" SelectedValue='<%# Bind("Gender") %>'>
                                            <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorGender" runat="server"
                                            ControlToValidate="dboGender" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Gender") %>
                                    </ItemTemplate>
                                    <ControlStyle Width="150px" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Date of Birth" SortExpression="DOB">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDOB" runat="server" CssClass="Date" Text='<%# Bind("DOB","{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("DOB","<span title='{0:dd MMMM, yyyy}'>{0:dddd, dd/MM/yyyy}</span>") %>
                                        <span class="time-small" style="margin-left: 20px" title="Age">
                                            <%# Common.getAge(Eval("DOB")) %></span>
                                    </ItemTemplate>
                                    <ControlStyle Width="150px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Father Name" SortExpression="FatherName">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtFatherName" runat="server" Width="400px" Text='<%# Bind("FatherName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("FatherName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mother Name" SortExpression="MotherName">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtMotherName" runat="server" Width="400px" Text='<%# Bind("MotherName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("MotherName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Spouse Name" SortExpression="SpouseName">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtSpouseName" runat="server" Width="400px" Text='<%# Bind("SpouseName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("SpouseName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Present Address" SortExpression="PresentAddress">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPresentAddress" runat="server" Width="400px" TextMode="MultiLine" Rows="3" Text='<%# Bind("PresentAddress") %>'></asp:TextBox>

                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("PresentAddress").ToString().Replace("\n","<br/>") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Permanent Address" SortExpression="PermanentAddress">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPermanentAddress" runat="server" Width="400px" TextMode="MultiLine" Rows="3" Text='<%# Bind("PermanentAddress") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("PermanentAddress").ToString().Replace("\n","<br/>") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mobile1" SortExpression="Mobile">
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" ID="txtMobile1" Text='<%# Bind("Mobile1") %>' MaxLength="20"
                                            Width="200px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^880\d{6,15}$"
                                            ControlToValidate="txtMobile1" ErrorMessage="RegularExpressionValidator">Invalid</asp:RegularExpressionValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Mobile1") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mobile2" SortExpression="Mobile2">
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" ID="txtMobile2" Text='<%# Bind("Mobile2") %>' MaxLength="20"
                                            Width="200px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorMobile2" runat="server" ValidationExpression="^880\d{6,15}$"
                                            ControlToValidate="txtMobile2" ErrorMessage="RegularExpressionValidator">Invalid</asp:RegularExpressionValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Mobile2") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email1" SortExpression="Email1">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmail1" runat="server" Text='<%# Bind("Email1") %>' MaxLength="40"
                                            Width="400px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail1" runat="server"
                                            ControlToValidate="txtEmail1" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Email1") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email2" SortExpression="Email2">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmail2" runat="server" Text='<%# Bind("Email2") %>' MaxLength="40"
                                            Width="400px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail2" runat="server"
                                            ControlToValidate="txtEmail2" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("Email2") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Customer Type" SortExpression="CustomerType">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="dboCustomerType" runat="server" DataSourceID="SqlDataSourceCustomerType" DataTextField="CustomerType" DataValueField="CustomerTypeID" SelectedValue='<%# Bind("CustomerType") %>'>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorCustomerType" runat="server"
                                            ControlToValidate="dboCustomerType" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("CustomerTypeName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="VIP Rating" SortExpression="VIP">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="dboVIP" runat="server" DataSourceID="SqlDataSourceVip" DataTextField="VIP" DataValueField="VIPID" SelectedValue='<%# Bind("VIP") %>'>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorVIP" runat="server"
                                            ControlToValidate="dboVIP" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <div title='<%# Eval("VIP") %>'><%# Eval("VIPName") %></div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Branch" SortExpression="BranchID">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="dboBranch" AppendDataBoundItems="true" runat="server" DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID" SelectedValue='<%# Bind("BranchID") %>'>
                                            <asp:ListItem Text="Not Defined" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <div title='<%# Eval("BranchID") %>'><%# Eval("BranchName") %></div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Marketing Employee ID" SortExpression="EmpID" InsertVisible="true">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmp11" runat="server" Text='<%# Bind("EmpID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("EmpID") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Insert By">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP1" Username='<%# Eval("InsertBy") %>' runat="server" />
                                        <span class="time-small" title='<%# Eval("InsertDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Update By">
                                    <ItemTemplate>
                                        <uc2:EMP ID="EMP2" Username='<%# Eval("UpdateBy") %>' runat="server" />
                                        <span class="time-small" title='<%# Eval("UpdateDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                            <time class="timeago" datetime='<%# Eval("UpdateDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False" ItemStyle-CssClass="donothide">
                                    <EditItemTemplate>
                                        <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                        <asp:ConfirmButtonExtender ID="con1" runat="server" TargetControlID="cmdUpdate" ConfirmText="Do you want to Update?" />
                                        <asp:LinkButton ID="cmdCancel" runat="server" CausesValidation="False"
                                            CommandName="Cancel" Text="Cancel" OnClick="cmdCancel_Click" />
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="cmdEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                    </ItemTemplate>
                                    <ControlStyle Width="80px" Font-Bold="true" />
                                </asp:TemplateField>
                            </Fields>
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="SqlDataSourceCustomerType" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="select * from v_CustomerType" SelectCommandType="Text"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="SELECT  BranchID, BranchName FROM dbo.v_BranchAll" SelectCommandType="Text"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceVip" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="select * from v_VIP" SelectCommandType="Text"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource33" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_ITCL_CustomerInfo_Browse"
                            SelectCommandType="StoredProcedure" UpdateCommand="s_ITCL_CustomerInfo_Insert_Update" UpdateCommandType="StoredProcedure"
                            OnSelected="SqlDataSource33_Selected" OnUpdated="SqlDataSource33_Updated">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="ITCLID" QueryStringField="ITCLID" DefaultValue="" Type="String" />
                                <asp:Parameter Name="ManuallySaved" Direction="InputOutput" DefaultValue="false" Type="Boolean" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ITCLID" />
                                <asp:Parameter Name="CustomerName" />
                                <asp:Parameter Name="Gender" />
                                <asp:Parameter Name="DOB" DbType="Date" />
                                <asp:Parameter Name="FatherName" />
                                <asp:Parameter Name="MotherName" />
                                <asp:Parameter Name="SpouseName" />
                                <asp:Parameter Name="PresentAddress" />
                                <asp:Parameter Name="PermanentAddress" />
                                <asp:Parameter Name="Mobile1" />
                                <asp:Parameter Name="Mobile2" />
                                <asp:Parameter Name="Email1" />
                                <asp:Parameter Name="Email2" />
                                <asp:Parameter Name="CustomerType" />
                                <asp:Parameter Name="VIP" />
                                <asp:Parameter Name="BranchID" />
                                <asp:Parameter Name="EmpID" />
                                <asp:SessionParameter Name="InsertBy" SessionField="EMPID" />
                                <asp:Parameter Name="Msg" Type="String" Size="255" Direction="InputOutput" DefaultValue="*" />

                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td valign="top">
                        <asp:HyperLink ID="hypTravelDetails" runat="server" Target="_blank" CssClass="Button">Travel Details</asp:HyperLink>

                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="Grid"
                            BackColor="White" BorderColor="#DEDFDE" BorderStyle="Solid" BorderWidth="1px"
                            CellPadding="2" DataKeyNames="ID" DataSourceID="SqlDataSource3" ForeColor="Black"
                            GridLines="Vertical" Style="font-size: small" AllowSorting="True"
                            AllowPaging="true" PageSize="10" PagerSettings-Position="TopAndBottom"
                            OnRowDataBound="GridView2_RowDataBound">
                            <FooterStyle BackColor="#CCCC99" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <Columns>
                                <asp:TemplateField HeaderText="On Travel" SortExpression="OnTravel">
                                    <ItemTemplate>
                                        <%# Eval("OnTravel").ToString() == "1" ? "<img src='Images/Travel.png' width='36' height='36' title='On Travel'>" : "" %>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
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
                                <asp:TemplateField HeaderText="Days" SortExpression="Days">
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
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                            <SelectedRowStyle BackColor="#FFA200" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_VIP_Tours_Browse" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="ITCLID" QueryStringField="ITCLID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="Black" Style="font-size: small"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource2" AllowPaging="True" EnableViewState="false"
                AllowSorting="True" CssClass="Grid" EnableSortingAndPagingCallbacks="True">
                <FooterStyle BackColor="#CCCC99" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                <Columns>
                    <%--<asp:BoundField DataField="ITCLID" HeaderText="ITCL ID" ReadOnly="True" SortExpression="ITCLID"
                        HtmlEncode="false" />--%>
                    <asp:TemplateField HeaderText="Card Number" SortExpression="CardNumber">
                        <ItemTemplate>
                            <%# Eval("CardNumber","<div class='bold'>{0}</div>") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Card Type" SortExpression="CardTypeName">
                        <ItemTemplate>
                            <%# Eval("CardTypeName","<div>{0}</div>") %>
                            <%# Eval("CardType","<div>{0}</div>") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Account" HeaderText="Account Number"
                        ReadOnly="True" SortExpression="Account"
                        HtmlEncode="false" ItemStyle-Wrap="false">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Customer NAME" HeaderText="Customer Name" ReadOnly="True"
                        SortExpression="Customer NAME" HtmlEncode="false" />
                    <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status"
                        HtmlEncode="false">
                        <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Created" SortExpression="CREATED" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("CREATED")) %>'>
                                <%# TrustControl1.ToRecentDate(Eval("CREATED"))%>
                                <div class='time-small'>
                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("CREATED")) %>'></time>
                                </div>
                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" ReadOnly="True" SortExpression="ExpiryDate"
                        HtmlEncode="false" DataFormatString="{0:dd MMM, yyyy}" />
                    <asp:BoundField DataField="Location" HeaderText="Location" ReadOnly="True" SortExpression="Location"
                        HtmlEncode="false" Visible="false" />
                    <asp:TemplateField HeaderText="Delivery Info" SortExpression="DeliveryDT" ItemStyle-Wrap="false"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <div title='<%# TrustControl1.ToDateTimeTitle(Eval("DeliveryDT")) %>'>
                                <%# TrustControl1.ToRecentDateTime(Eval("DeliveryDT"))%>
                                <div class='time-small'>
                                    <time class='timeago' datetime='<%# TrustControl1.ToTimeAgo(Eval("DeliveryDT")) %>'></time>
                                </div>
                            </div>
                            <%# Eval("Reference","<div title='Reference'>{0}</div>")%>
                            <%# Eval("DeliveredBranchID", "To Branch:")%>
                            <uc3:Branch ID="Branch1" runat="server" BranchID='<%# Eval("DeliveredBranchID") %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:TemplateField>
                </Columns>
                <PagerSettings Position="TopAndBottom" Mode="NumericFirstLast" PageButtonCount="30" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="false" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                    Record not found.
                </EmptyDataTemplate>
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>

            <asp:Label Font-Names="Arial" runat="server" ID="lblStatus" Text="" Font-Size="Small"></asp:Label>
            <br />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_Search_All_Cards" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource2_Selected">
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="ITCLID" Name="ITCL" Type="String" DefaultValue="" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel runat="server" ID="panelVisible" Visible="false">
                <div class="row group" style="display: table; margin: 15px 0; min-width: 200px">
                    <h5>Attachments</h5>
                    <div class="group-body">
                        <div class="pointer attachmentAdd bold">
                            <asp:LinkButton runat="server" ID="cmdAddAttach"
                                CausesValidation="false" OnClick="cmdAddAttach_Click">
                            <img src="Images/add-files.png" width="20px" />Add Files</asp:LinkButton>
                        </div>
                        <div style="padding: 5px">
                            <asp:DataList ID="DataList1" runat="server" CellPadding="0" DataKeyField="AID" DataSourceID="SqlDataSourceAttachments"
                                RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="attachment-list" BorderWidth="0px"
                                Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" ShowFooter="False" ShowHeader="False">
                                <ItemTemplate>
                                    <div class='Thumb <%# Eval("IsActive").ToString() == "True" ? "" : "Thumb-inactive" %>'>
                                        <%# Eval("DocType","<div class='doc-type'>{0}:</div>") %>
                                        <asp:Image runat="server" CssClass="AttachmentThumb" LoadImg='<%# getLinkImage(Eval("AID"),Eval("FileID"),Eval("Extension")) %>'
                                            ImageUrl="~/Images/Loading.gif" ID="Image1" border="0" BorderColor="Silver" BorderStyle="Solid" />
                                        <%# Eval("Remarks","<div class='doc-remarks'>{0}</div>") %>
                                    </div>
                                    <asp:HoverMenuExtender ID="ImgPanel1_HoverMenuExtender" runat="server" DynamicServicePath=""
                                        Enabled="True" PopupControlID="AttachmentMenu" TargetControlID="Image1" CacheDynamicResults="True"
                                        OffsetX="30" OffsetY="7" PopDelay="50" HoverDelay="300">
                                    </asp:HoverMenuExtender>
                                    <asp:Panel ID="AttachmentMenu" runat="server" BorderColor="Gray" BorderWidth="1px"
                                        Width="120px" Style="padding: 5px; text-align: left;" CssClass="ui-corner-all Shadow Panel1">
                                        <div>
                                            <asp:LinkButton ID="LinkOpen" CssClass="link Button" CommandName="Open" Font-Bold="true"
                                                CommandArgument='<%# Eval("AID") %>' runat="server" CausesValidation="False"
                                                Text="Open Item" OnClick="LinkOpen_Click" Enabled="true" Visible="true"
                                                Style="color: blue"></asp:LinkButton>
                                        </div>
                                        <div>
                                            <asp:HyperLink ID="HyperLink3" CssClass="link" runat="server" Font-Size="10pt" ToolTip="View in PDF Viewer"
                                                NavigateUrl='<%# "Attachment.ashx?aid=" + Eval("AID") + "&key=" + Eval("FileID") + "&view=yes&type=itcl" %>'
                                                Style="color: blue" Target="_blank"><b>View File</b></asp:HyperLink><br />
                                        </div>
                                        <div style="margin-top: 5px" class='<%# (Eval("Extension").ToString().ToLower() =="pdf" ? "" : "hidden") %>'>
                                            <asp:HyperLink ID="HyperLink2" CssClass="link" runat="server" Font-Size="10pt" ToolTip="View as HTML"
                                                NavigateUrl='<%# "pdf.aspx?aid=" + Eval("AID") + "&key=" + Eval("FileID") + "&type=itcl" %>'
                                                Style="color: blue" Target="_blank"><b>View as HTML</b></asp:HyperLink><br />
                                        </div>
                                        <div style="margin-top: 5px">
                                            <asp:HyperLink ID="HyperLink1" CssClass="link" runat="server" NavigateUrl='<%# "Attachment.ashx?aid=" + Eval("AID") + "&key=" + Eval("FileID") + "&type=itcl" %>'
                                                Font-Size="10pt" Style="color: blue" ToolTip='<%# Eval("FileName") %>'><b>Download</b></asp:HyperLink>
                                        </div>
                                        <div style="font-size: 7pt">
                                            <%# "<b>" + FileSize(Eval("FileSize")) + "</b><br /><span style=\"color:Gray\"><b>Upload On:</b><br>" + Common.ToRecentDateTime(Eval("InsertDT")) + "<br>" + "<time class='timeago' datetime='" + Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") + "'></time>" + "</span>"%>
                                        </div>

                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:DataList>
                            <asp:SqlDataSource ID="SqlDataSourceAttachments" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                SelectCommand="SELECT * FROM v_Attachments_ITCL_Browse WHERE (CID = @ITCLID) ORDER BY IsActive DESC, InsertDT">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HidITCLID" Name="ITCLID" PropertyName="Value"
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
                <asp:TabContainer runat="server" ID="tabContainer" CssClass="NewsTab" OnDemand="true"
                    ActiveTabIndex="0" Width="600px">
                    <asp:TabPanel runat="server" ID="tab1">
                        <HeaderTemplate>
                            Comments/Notes
                        </HeaderTemplate>
                        <ContentTemplate>
                            <div class="row">
                                <div style="float: left">
                                    <asp:TextBox ID="txtCommentDtl" MaxLength="1000" TextMode="MultiLine" Rows="4" runat="server" ValidationGroup="grpticketStatus"
                                        Style="width: 550px;" ClientIDMode="Static"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="sdfasdfas" runat="server" ControlToValidate="txtCommentDtl" ValidationGroup="grpticketStatus" ForeColor="Red">*</asp:RequiredFieldValidator>
                                </div>
                                <div style="padding: 10px 0 0 0">
                                </div>
                            </div>
                            <div class="row">
                            </div>
                            <div style="clear: left">
                            </div>
                            <div class="row">
                                <asp:Button ID="btnPostReply" runat="server" Text="Post" Width="100px" ValidationGroup="grpticketStatus"
                                    OnClick="btnPostReply_Click" />
                            </div>
                            <div class="row" style="margin: 20px 0px 0px 0px">
                                <asp:GridView ID="grdvComment" runat="server" DataKeyNames="SL" AutoGenerateColumns="False"
                                    DataSourceID="SqlDataSourceComments" CssClass="Grid nomargin" BorderStyle="None" BackColor="White"
                                    ShowHeader="true" AllowPaging="false" AllowSorting="true" EnableViewState="false"
                                    BorderColor="#DEDFDE" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                                    OnRowDataBound="grdvComment_RowDataBound">
                                    <AlternatingRowStyle BackColor="White" />
                                    <Columns>
                                        <asp:BoundField HeaderText="SL" DataField="SL" />
                                        <asp:TemplateField HeaderText="Remarks/Notes" SortExpression="Remarks">
                                            <ItemTemplate>
                                                <div class='bold' title='<%# Eval("CID") %>'>
                                                    <%# Eval("Remarks").ToString().Replace("\n", "<br />")%>
                                                </div>
                                                <asp:Literal ID="litAttach" runat="server" EnableViewState="true"></asp:Literal>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Posted on" SortExpression="DT">
                                            <ItemTemplate>
                                                <div title='<%# Eval("DT","{0:dddd \ndd, MMMM, yyyy \nh:mm:ss tt}") %>'>
                                                    <%# TrustControl1.ToRecentDateTime( Eval("DT")) %><br />
                                                    <time class="timeago" datetime='<%# Eval("DT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                                </div>
                                                <div>
                                                    By:
                                                    <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("InsertBY") %>' />
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                    <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                                    <SelectedRowStyle CssClass="GridSelected" BackColor="#FFA200" />
                                    <FooterStyle BackColor="#CCCC99" />
                                    <SortedAscendingCellStyle BackColor="#FBFBF2" />
                                    <SortedAscendingHeaderStyle BackColor="#848384" />
                                    <SortedDescendingCellStyle BackColor="#EAEAD3" />
                                    <SortedDescendingHeaderStyle BackColor="#575357" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSourceComments" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                    SelectCommand="s_ITCL_Comments_Select" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceComments_Selected">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HidITCLID" Name="ITCLID" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                        </ContentTemplate>
                    </asp:TabPanel>

                </asp:TabContainer>
                <asp:HiddenField ID="hidSlNo" runat="server" Value="" />
                <div style="height: 400px">
                </div>
            </asp:Panel>
            <span style="visibility: hidden">
                <asp:Button ID="cmdShow" runat="server" CausesValidation="False" />
                <asp:Button ID="cmdShowUpload" runat="server" CausesValidation="False" />
                <asp:Button ID="cmdShowModal2" runat="server" CausesValidation="False" />
            </span>
            <asp:ModalPopupExtender PopupControlID="ModalPanel1" CancelControlID="ModalClose1"
                ID="modalUpload" runat="server" Enabled="True" TargetControlID="cmdShowUpload"
                PopupDragHandleControlID="ModalTitle1" BackgroundCssClass="ModalPopupBG" RepositionMode="RepositionOnWindowResizeAndScroll">
            </asp:ModalPopupExtender>
            <asp:Panel runat="server" ID="ModalPanel1" Width="610px" CssClass="ModalPanel">
                <div style="background-color: Green; border: 4px solid green">
                    <asp:Panel runat="server" ID="ModalTitle1" CssClass="MoveIcon" HorizontalAlign="Center"
                        Width="100%">
                        <table width="100%">
                            <tr>
                                <td align="left" style="color: white; font-size: 16pt; font-weight: bolder">
                                    <asp:Literal ID="Label12" runat="server" Text="Add New Attachment"></asp:Literal>
                                </td>
                                <td align="right">
                                    <a href="#" style="cursor: default">
                                        <asp:Image ID="ModalClose1" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close" />
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="Panel3" runat="server" BackColor="#fefdc3" Height="240px">
                        <div style="padding: 20px 20px 20px 20px">
                            <asp:AsyncFileUpload UploaderStyle="Traditional" ID="FileUpload1" runat="server"
                                ThrobberID="myThrobber" Width="500" OnUploadedComplete="FileUpload1_UploadedComplete"
                                OnClientUploadComplete="UploadComplete" OnClientUploadError="UploadError" OnUploadedFileError="FileUpload1_UploadedFileError"
                                OnClientUploadStarted="AsyncFileUpload1_StartUpload" />

                            <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" />
                            <div style="margin-top: 10px">
                                <asp:Label ID="lblUploadStatus" tblid="lblUploadStatus" runat="server" Text="" Style="font-size: small;">                
                                </asp:Label>
                            </div>
                            <div style="display: none; margin-top: 15px" id="UploadBtn">
                                <asp:Label runat="server">File Type :</asp:Label>
                                <asp:DropDownList ID="ddlDocTypes" runat="server" AppendDataBoundItems="True" DataTextField="DocType"
                                    DataValueField="DocTypeID" DataSourceID="SqlDataSourceDocTypes">
                                    <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2sdsads" ControlToValidate="ddlDocTypes"
                                    SetFocusOnError="True" runat="server" ForeColor="Red"
                                    ErrorMessage="*" ValidationGroup="AttachFile"></asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="SqlDataSourceDocTypes" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                    SelectCommand="SELECT * FROM dbo.DocTypes_ITCL Order by DocType" SelectCommandType="Text"></asp:SqlDataSource>
                                <asp:Button ID="cmdUpload" runat="server" Height="33px" UseSubmitBehavior="true"
                                    Style="font-weight: 700" Text="Attach" Width="100px"
                                    OnClick="cmdUpload_Click" ValidationGroup="AttachFile" />
                                <br />
                                <asp:Label runat="server">Remarks :</asp:Label>
                                <asp:TextBox runat="server" ID="txtremarks" Width="500px" TextMode="MultiLine" Rows="3" MaxLength="255" Text=""></asp:TextBox>
                                <br />
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </asp:Panel>
            <asp:HiddenField runat="server" ID="hidAttachmentID" Value="" />
            <asp:ModalPopupExtender PopupControlID="ModalPanel2" CancelControlID="ModalClose2"
                ID="Modal2" runat="server" Enabled="True"
                TargetControlID="cmdShowModal2"
                PopupDragHandleControlID="ModalTitle2"
                BackgroundCssClass="ModalPopupBG"
                RepositionMode="RepositionOnWindowResizeAndScroll">
            </asp:ModalPopupExtender>
            <asp:Panel runat="server" ID="ModalPanel2" Width="800px" CssClass="ModalPanel">
                <div style="background-color: Green; border: 4px solid green">
                    <asp:Panel runat="server" ID="ModalTitle2" CssClass="MoveIcon" HorizontalAlign="Center"
                        Width="100%">
                        <table width="100%">
                            <tr>
                                <td align="left" style="color: white; font-size: 16pt; font-weight: bolder">
                                    <asp:Literal ID="Literal1" runat="server" Text="Attachment Details"></asp:Literal>
                                </td>
                                <td align="right">
                                    <a href="#" style="cursor: default">
                                        <asp:Image ID="ModalClose2" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close" />
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="Panel4" runat="server" BackColor="#fefdc3" Height="400px">
                        <div style="padding: 5px 5px 5px 5px">
                            <table>
                                <tr>
                                    <td valign="top">
                                        <asp:DetailsView ID="DetailsView1" runat="server" BackColor="White" BorderColor="#DEDFDE"
                                            BorderStyle="Solid" BorderWidth="1px" CssClass="Grid modal-table" CellPadding="4" DataSourceID="SqlDataSource1"
                                            ForeColor="Black" AutoGenerateRows="False"
                                            OnItemUpdated="DetailsView1_ItemUpdated" DataKeyNames="AID" OnModeChanged="DetailsView1_ModeChanged">
                                            <FooterStyle BackColor="#CCCC99" />
                                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" />
                                            <Fields>
                                                <asp:TemplateField HeaderText="ITCL ID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblITCLID" runat="server" Text='<%# Bind("CID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="File ID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAID" runat="server" Text='<%# Bind("AID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="File Name" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFileName" runat="server" Text='<%# Bind("FileName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Type">
                                                    <ItemTemplate>
                                                        <%# Eval("DocType") %>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="cboDocumentType" runat="server" SelectedValue='<%# Bind("FileTypeID") %>'
                                                            DataSourceID="SqlDataSource_DocumentType" DataTextField="DocType" DataValueField="DocTypeID"
                                                            AppendDataBoundItems="true">
                                                            <%--<asp:ListItem Text="My Current Branch" Value="0"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorDocumentType" runat="server"
                                                            ControlToValidate="cboDocumentType" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                                        <asp:SqlDataSource ID="SqlDataSource_DocumentType" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                                                            SelectCommand="SELECT  [DocTypeID],[DocType] FROM [DocTypes_ITCL]" SelectCommandType="Text"></asp:SqlDataSource>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <%# Eval("IsActive") %>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="cboStatus" runat="server" SelectedValue='<%# Bind("IsActive") %>'
                                                            DataTextField="StatusID" DataValueField="StatusName"
                                                            AppendDataBoundItems="true">
                                                            <asp:ListItem Text="Active" Value="True"></asp:ListItem>
                                                            <asp:ListItem Text="Not Active" Value="False"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorStatus" runat="server"
                                                            ControlToValidate="cboStatus" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>

                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Remarks">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRemarks" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox runat="server" ID="txtRemarks" Text='<%# Bind("Remarks") %>'
                                                            Width="350px" MaxLength="255" Rows="4" TextMode="MultiLine"></asp:TextBox>
                                                    </EditItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Modify" InsertVisible="False" SortExpression="ModifyBY">
                                                    <ItemTemplate>
                                                        <uc2:EMP ID="EMP2" Username='<%# Eval("ModifyBY") %>' runat="server" />
                                                        <span class="time-small" title='<%# Eval("ModifyDT", "{0:dddd, dd MMMM yyyy, hh:mm:ss tt}")%>'>
                                                            <time class="timeago" datetime='<%# Eval("ModifyDT","{0:yyyy-MM-dd HH:mm:ss}") %>'></time>
                                                        </span>
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
                                                    <ControlStyle Width="80px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="HyperLink3" CssClass="link" runat="server" Font-Size="10pt" ToolTip="View in PDF Viewer"
                                                            NavigateUrl='<%# "Attachment.ashx?aid=" + Eval("AID") + "&key=" + Eval("FileID") + "&view=yes&type=itcl" %>'
                                                            Style="color: blue; margin-right: 10px" Target="_blank"><b>View File</b></asp:HyperLink>

                                                        <asp:HyperLink ID="HyperLink1" CssClass="link" runat="server" NavigateUrl='<%# "Attachment.ashx?aid=" + Eval("AID") + "&key=" + Eval("FileID") + "&type=itcl" %>'
                                                            Font-Size="10pt" Style="color: blue; margin-right: 10px" ToolTip='<%# Eval("FileName") %>'><b>Download</b></asp:HyperLink>

                                                        <span style="margin-top: 5px" class='<%# (Eval("Extension").ToString().ToLower() =="pdf" ? "" : "hidden") %>'>
                                                            <asp:HyperLink ID="HyperLink2" CssClass="link" runat="server" Font-Size="10pt" ToolTip="View as HTML"
                                                                NavigateUrl='<%# "pdf.aspx?aid=" + Eval("AID") + "&key=" + Eval("FileID") + "&type=itcl" %>'
                                                                Style="color: blue; margin-right: 10px" Target="_blank"><b>View as HTML</b></asp:HyperLink>
                                                        </span>

                                                        <asp:LinkButton ID="cmdDeleteAttachment" CssClass="link" Font-Bold="true"
                                                            CommandArgument='<%# Eval("AID") %>' runat="server" CausesValidation="False"
                                                            Text="Delete" OnClick="cmdDeleteAttachment_Click" Enabled="true" Visible="true"
                                                            Style="color: #CC0000"></asp:LinkButton>
                                                        <asp:ConfirmButtonExtender ID="cmdDeleteAttachment_ConfirmButtonExtender" runat="server"
                                                            ConfirmText="Are you sure you want to Delete?" Enabled="True"
                                                            TargetControlID="cmdDeleteAttachment"></asp:ConfirmButtonExtender>
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                            </Fields>
                                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" Wrap="false" />
                                            <AlternatingRowStyle BackColor="White" />
                                        </asp:DetailsView>
                                        <br />


                                    </td>
                                    <td valign="top" style="padding-left: 10px">
                                        <asp:DataList ID="DataList2" runat="server" CellPadding="0" DataKeyField="AID" DataSourceID="SqlDataSource1"
                                            RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="attachment-list" BorderWidth="0px"
                                            Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" HorizontalAlign="Center" ShowFooter="False" ShowHeader="False">
                                            <ItemTemplate>
                                                <div style="margin-bottom: 3px">
                                                    <asp:Image runat="server" CssClass="AttachmentThumb" LoadImg='<%# getLinkImage1(Eval("AID"),Eval("FileID"),Eval("Extension")) %>'
                                                        ImageUrl="~/Images/Loading.gif" ID="Image1" border="0" BorderColor="Silver" BorderStyle="Solid" Style="max-height: 250px; max-width: 350px" />
                                                </div>
                                                <%# Eval("FileName","<div class='doc-remarks bold'>{0}</div>") %>
                                                <%# "<div class='bold' style='font-size:85%;color:gray'>" + FileSize(Eval("FileSize")) + "</div>" %>
                                                <div style="font-size: 9pt; margin-top: 5px">
                                                    Added by:
                                                    <uc2:EMP ID="EMP222" Username='<%# Eval("InsertBy") %>' runat="server" />
                                                </div>
                                                <div style="font-size: 7pt">
                                                    <%# "<div style=\"color:Gray\"><b>Upload On:</b><div title='"+ Eval("InsertDT", "{0:dddd\ndd MMMM, yyyy\nh:mm:ss tt}") +"'>" + Common.ToRecentDateTime(Eval("InsertDT")) + "<br>" + "<time class='timeago' datetime='" + Eval("InsertDT","{0:yyyy-MM-dd HH:mm:ss}") + "'></time>" + "</div></div>"%>
                                                </div>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="s_ITCL_Attachment_Single_View" SelectCommandType="StoredProcedure" UpdateCommand="s_ITCL_Attachment_Update"
                        UpdateCommandType="StoredProcedure" OnUpdated="SqlDataSource1_Updated" OnSelected="SqlDataSource1_Selected">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hidAttachmentID" Name="AID" PropertyName="Value" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="hidAttachmentID" Name="AID" PropertyName="Value" Type="Int32" />
                            <asp:Parameter Name="FileTypeID" />
                            <asp:Parameter Name="IsActive" />
                            <asp:Parameter Name="Remarks" />
                            <asp:SessionParameter Name="EmpID" SessionField="EMPID" />
                            <asp:Parameter Name="Msg" Type="String" Direction="InputOutput" DefaultValue="" Size="250" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="cmdAddAttach" />
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