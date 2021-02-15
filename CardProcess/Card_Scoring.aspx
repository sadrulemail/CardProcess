﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Card_Scoring.aspx.cs" Inherits="Card_Scoring" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        hr {
            margin: 0 20px;
            border: none;
            border-bottom: 1px dashed gray;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:Literal ID="litTitle" runat="server"></asp:Literal>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <uc1:TrustControl ID="TrustControl1" runat="server" />



    <asp:SqlDataSource ID="sql_B1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_B1]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_B2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_B2]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_B3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_B3]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_B4" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_B4]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_B5" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_B5]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_B6" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_B6]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_B7" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_B7]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_B8" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_B8]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C1]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C2]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C3" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C3]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C4" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C4]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C5" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C5]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C6" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C6]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C7" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C7]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C8" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C8]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C9" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C9]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C10" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C10]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C11" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C11]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_C12" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_C12]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_D1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [vd_Credit_D1]" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sql_Card_Type" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" SelectCommand="SELECT * FROM [CardType] ORDER BY Cards" EnableCaching="true" CacheDuration="60"></asp:SqlDataSource>



    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False"
                BorderStyle="None" DataSourceID="SqlDataSource1" GridLines="None">

                <EditRowStyle CssClass="hidden-print" />
                <Fields>
                    
                    <asp:TemplateField ShowHeader="false">
                        <EditItemTemplate>
                            <table class="Grid" style="width: 100%; border-collapse: collapse">
                                <tr>
                                    <td>
                                        <table class="noborder" width="100%">
                                            <tr>
                                                <td>
                                                    <img src="Images/logo.jpg" height="25" />
                                                </td>
                                                <td style="text-align: center; font-weight: bold; font-size: 150%">Credit Card Scoring & Approval Sheet</td>
                                                <td style="text-align: right; font-weight: bold">App ID: <%# Eval("SL") %></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="noborder" width="100%">
                                            <tr>
                                                <td>Name:</td>
                                                <td style="font-size: 120%; font-weight: bold">
                                                    <asp:TextBox ID="txtApplicant" required runat="server"  placeholder="applicant name" Text='<%# Bind("Applicant") %>' MaxLength="100" Width="300px"></asp:TextBox>

                                                </td>
                                                <td>Company:</td>
                                                <td>
                                                    <asp:TextBox ID="txtCompany" runat="server" placeholder="company" MaxLength="100" Width="250px" Text='<%# Bind("Company") %>'></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td rowspan="2" valign="top">Address:</td>
                                                <td rowspan="2" valign="top">
                                                    <asp:TextBox ID="txtAddress" required placeholder="address" MaxLength="255" TextMode="MultiLine" Rows="4" Width="300px" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox></td>
                                                <td>Designation:</td>
                                                <td>
                                                    <asp:TextBox ID="txtDesignation" runat="server" placeholder="designation" MaxLength="100" Width="250px" Text='<%# Bind("Designation") %>'></asp:TextBox></td>
                                            </tr>
                                            <tr>

                                                <td>TIN No.:</td>
                                                <td>
                                                    <asp:TextBox ID="txtTIN" Text='<%# Bind("TIN_No") %>' placeholder="tin number" runat="server" MaxLength="20" Width="120px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>Contact No.:</td>
                                                <td>
                                                    <asp:TextBox ID="txtContact_No" runat="server" required placeholder="+8801xxxxxxxxx" MaxLength="50" Text='<%# Bind("Contact_No") %>'
                                                        pattern="^[\+]880(1[156789])\d{8}$" ToolTip="Bangladesh Mobile No. (+8801xxxxxxxxx)"></asp:TextBox></td>
                                                <td colspan="2">Name on Card:
                                                    <asp:TextBox ID="txtNameOncard" runat="server" placeholder="name on card" Text='<%# Bind("NameOncard") %>' MaxLength="19" Width="200px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>Email:</td>
                                                <td>
                                                    <asp:TextBox ID="txtEmail" runat="server" placeholder="email" MaxLength="100" Width="300px" Text='<%# Bind("Email") %>'></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" runat="server" Display="Dynamic" ForeColor="Red"
                                                        ControlToValidate="txtEmail" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>

                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">

                                <tr>
                                    <td>Gross Income per Month:</td>
                                    <td>
                                        <asp:TextBox ID="txtIncome" Text='<%# Bind("Income","{0:N2}") %>' runat="server" MaxLength="20" Width="100px"></asp:TextBox>
                                        BDT

                                    </td>

                                </tr>
                                <tr class="td-header">
                                    <td colspan="2">Points for Other Consideration</td>
                                </tr>
                                <tr>
                                    <td>Income Validated:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB1" runat="server" SelectedValue='<%# Bind("B1") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B1" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB1" runat="server" ControlToValidate="ddlB1" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Sufficient Documents:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB2" runat="server" SelectedValue='<%# Bind("B2") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B2" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB2" runat="server" ControlToValidate="ddlB2" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Existing Account Holder:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB3" runat="server" SelectedValue='<%# Bind("B3") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B3" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB3" runat="server" ControlToValidate="ddlB3" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>CPV Result:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB4" runat="server" SelectedValue='<%# Bind("B4") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B4" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB4" runat="server" ControlToValidate="ddlB4" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>TBL Account Holder:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB5" runat="server" SelectedValue='<%# Bind("B5") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B5" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB5" runat="server" ControlToValidate="ddlB5" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>A/C Auto Debit Instruction:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB6" runat="server" SelectedValue='<%# Bind("B6") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B6" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB6" runat="server" ControlToValidate="ddlB6" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Salary A/C with TBL:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB7" runat="server" SelectedValue='<%# Bind("B7") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B7" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB7" runat="server" ControlToValidate="ddlB7" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Type of Organization:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlB8" runat="server" SelectedValue='<%# Bind("B8") %>'
                                            DataSourceID="sql_B8" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqB8" runat="server" ControlToValidate="ddlB8" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr class="td-header">
                                    <td colspan="2">Employment Details</td>
                                </tr>
                                <tr>
                                    <td>Person Type:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlC1" runat="server" SelectedValue='<%# Bind("C1") %>' RepeatLayout="Flow" RepeatDirection="Horizontal" Width="400px"
                                            DataSourceID="sql_C1" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqC1" runat="server" ControlToValidate="ddlC1" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>

                                    </td>

                                </tr>
                                <tr>
                                    <td>Length of Service/Business:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlC2" runat="server" SelectedValue='<%# Bind("C2") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C2" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqC2" runat="server" ControlToValidate="ddlC2" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>6 Months Avg. A/C Balance:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC3" runat="server" SelectedValue='<%# Bind("C3") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C3" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC3" runat="server" ControlToValidate="ddlC3" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Residential Status (Local):</td>
                                    <td>
                                        <asp:DropDownList ID="ddlC4" runat="server" SelectedValue='<%# Bind("C4") %>'
                                            DataSourceID="sql_C4" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqC4" runat="server" ControlToValidate="ddlC4" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Phone in own name at:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlC5" runat="server" SelectedValue='<%# Bind("C5") %>'
                                            DataSourceID="sql_C5" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqC5" runat="server" ControlToValidate="ddlC5" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Holding Valid Passport:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC6" runat="server" SelectedValue='<%# Bind("C6") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C6" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC6" runat="server" ControlToValidate="ddlC6" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Regd. Club Membership:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC7" runat="server" SelectedValue='<%# Bind("C7") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C7" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC7" runat="server" ControlToValidate="ddlC7" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Credit Reference from Source:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC8" runat="server" SelectedValue='<%# Bind("C8") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C8" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC8" runat="server" ControlToValidate="ddlC8" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Marital Status:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC9" runat="server" SelectedValue='<%# Bind("C9") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C9" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC9" runat="server" ControlToValidate="ddlC9" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Spouse is Employeed:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC10" runat="server" SelectedValue='<%# Bind("C10") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C10" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC10" runat="server" ControlToValidate="ddlC10" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ownership of Vehicle:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC11" runat="server" SelectedValue='<%# Bind("C11") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C11" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC11" runat="server" ControlToValidate="ddlC11" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Age (years):</td>
                                    <td>
                                        <asp:DropDownList ID="ddlC12" runat="server" SelectedValue='<%# Bind("C12") %>'
                                            DataSourceID="sql_C12" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqC12" runat="server" ControlToValidate="ddlC12" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr class="td-header">
                                    <td colspan="2">Points for Professionals & Businessman</td>
                                </tr>
                                <tr>
                                    <td>Professions/Businessman:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlD1" runat="server" SelectedValue='<%# Bind("D1") %>' Width="400px"
                                            DataSourceID="sql_D1" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqD1" runat="server" ControlToValidate="ddlD1" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr class="td-header">
                                    <td colspan="2">Multiple Factor on Total: <%# Eval("Factor") %></td>

                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr>
                                    <td colspan="2">CIB Status: <%# Eval("CIB") %></td>
                                </tr>
                                <tr>
                                    <td colspan="2">Calculated Limit: <%# Eval("Income","{0:N2}") %> x <%# Eval("Factor") %> = <b><%# Eval("CalculatedLimited","{0:N2}") %> BDT</b></td>
                                </tr>
                                <tr>
                                    <td>Previous Limit (BDT):
                                        <asp:TextBox runat="server" ID="txtPrevLimit" MaxLength="20" Text='<%# Bind("Prev_Limit") %>' Width="100px" placeholder="0.00"></asp:TextBox></td>
                                    <td>Previous Limit (USD):
                                        <asp:TextBox runat="server" ID="txtPrevLimitUSD" MaxLength="20" Text='<%# Bind("Prev_Limit_USD") %>' Width="100px" placeholder="0.00"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Prepared By: <%# Eval("Updated_By") %>, <%# Eval("UpdateByName") %><%# Eval("UpdateByDegisnation",", {0}") %></td>
                                    <td><%# Eval("Verified_By","Verified By: {0}") %><%# Eval("VerifiedByName",", {0}") %><%# Eval("VerifiedByDegisnation",", {0}") %></td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr class="td-header">
                                    <td colspan="2">Reviewed By</td>
                                </tr>
                                <tr>
                                    <td colspan='2'>Remarks:<br />
                                        <asp:TextBox runat="server" ID="txtComments" MaxLength="4000" Text='<%# Bind("Comments") %>' Rows="5" TextMode="MultiLine" Width="700px" placeholder="review remarks"></asp:TextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <asp:TextBox runat="server" ID="txtAC1" MaxLength="100" Width="250px" CssClass="center" Text='<%# Bind("AC1") %>'
                                            placeholder="sign authority"></asp:TextBox>


                                    </td>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <asp:TextBox runat="server" ID="txtAC2" MaxLength="100" Width="250px" CssClass="center" Text='<%# Bind("AC2") %>'
                                            placeholder="sign authority"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr class="td-header">
                                    <td colspan="2">Approval Commitee</td>
                                </tr>
                                <tr>
                                    <td>Remarks:<br />
                                        <asp:TextBox runat="server" ID="txtComments_Dep_Head" MaxLength="4000" Text='<%# Bind("Comments_Dep_Head") %>' Rows="3" TextMode="MultiLine" Width="450px" placeholder="approval commitee remarks"></asp:TextBox>

                                    </td>
                                    <td rowspan="2" valign="bottom" style="min-width: 80px" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <asp:TextBox runat="server" ID="txtAC3" MaxLength="100" Width="200px" CssClass="center" Text='<%# Bind("AC3") %>'
                                            placeholder="sign authority"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Proposed/Approved Limit: BDT:
                                        <asp:TextBox runat="server" ID="txtProposed_Limit" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Proposed_Limit") %>'
                                            placeholder="0.00"></asp:TextBox>

                                        and USD:
                                        <asp:TextBox runat="server" ID="txtProposed_Limit_USD" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Proposed_Limit_USD") %>'
                                            placeholder="0.00"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Remarks:<br />
                                        <asp:TextBox runat="server" ID="txtComments_App_Commitee" MaxLength="4000" Text='<%# Bind("Comments_App_Commitee") %>' Rows="3" TextMode="MultiLine" Width="450px" placeholder="remarks"></asp:TextBox>

                                    </td>
                                    <td rowspan="2" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <asp:TextBox runat="server" ID="txtAC4" MaxLength="100" Width="200px" CssClass="center" Text='<%# Bind("AC4") %>'
                                            placeholder="sign authority"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Approved Limit: BDT:
                                        <asp:TextBox runat="server" ID="txtApproved_Limit" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Approved_Limit") %>'
                                            placeholder="0.00"></asp:TextBox>

                                        and USD:
                                        <asp:TextBox runat="server" ID="txtApproved_Limit_usd" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Approved_Limit_usd") %>'
                                            placeholder="0.00"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>

                                        <asp:TextBox runat="server" ID="txtComments_App_Commitee1" MaxLength="4000" Text='<%# Bind("Comments_App_Commitee1") %>' Rows="3" TextMode="MultiLine" Width="450px" placeholder="remarks"></asp:TextBox>

                                    </td>
                                    <td rowspan="2" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <asp:TextBox runat="server" ID="txtAC5" MaxLength="100" Width="200px" CssClass="center" Text='<%# Bind("AC5") %>'
                                            placeholder="sign authority"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Approved Limit: BDT:
                                      
                                        <asp:TextBox runat="server" ID="txtApproved_Limit1" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Approved_Limit1") %>'
                                            placeholder="0.00"></asp:TextBox>

                                        and USD:
                                        <asp:TextBox runat="server" ID="txtApproved_Limit_usd1" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Approved_Limit_usd1") %>'
                                            placeholder="0.00"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr class="td-header">
                                    <td colspan="2">Card Division Official Use Only</td>
                                </tr>
                                <tr>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        Authorized Signature</td>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        Authorized Signature</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table style="border-collapse: collapse" class="noborder" width="100%">
                                            <tr>
                                                <td>Card Type: <%# Eval("Card_Type","<b>{0}</b>") %>
                                                    <asp:DropDownList ID="dblCard_Type" runat="server" SelectedValue='<%# Bind("Card_Type") %>'
                                                        DataSourceID="sql_Card_Type" DataTextField="Cards" DataValueField="ID" AppendDataBoundItems="true">
                                                        <asp:ListItem></asp:ListItem>
                                                    </asp:DropDownList>

                                                </td>
                                                <td>Card No: 
                                                    <asp:TextBox runat="server" ID="txtCardNo" MaxLength="20" Width="150px"
                                                        CssClass="center" Text='<%# Bind("Card_No") %>'
                                                        placeholder="card number"></asp:TextBox>
                                                </td>
                                                <td>Approval Date: 
                                                    <asp:TextBox runat="server" ID="txtApproval_Date" MaxLength="10" Width="80px"
                                                        CssClass="Date" Text='<%# Bind("Approval_Date","{0:dd/MM/yyyy}") %>'
                                                        placeholder=""></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <div style="text-align: right"><%# Eval("Update_Date_Time","Updated on: {0:MMM dd, yyyy h:mm:ss tt}") %></div>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <table class="Grid" style="width: 100%; border-collapse: collapse">
                                <tr>
                                    <td>
                                        <table class="noborder" width="100%">
                                            <tr>
                                                <td>
                                                    <img src="Images/logo.jpg" height="25" />
                                                </td>
                                                <td style="text-align: center; font-weight: bold; font-size: 150%">Credit Card Scoring & Approval Sheet</td>
                                                
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="noborder" width="100%">
                                            <tr>
                                                <td>Name:</td>
                                                <td style="font-size: 120%; font-weight: bold">
                                                    <asp:TextBox ID="txtApplicant" required runat="server"  placeholder="applicant name" Text='<%# Bind("Applicant") %>' MaxLength="100" Width="300px"></asp:TextBox>

                                                </td>
                                                <td>Company:</td>
                                                <td>
                                                    <asp:TextBox ID="txtCompany" runat="server" placeholder="company" MaxLength="100" Width="250px" Text='<%# Bind("Company") %>'></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td rowspan="2" valign="top">Address:</td>
                                                <td rowspan="2" valign="top">
                                                    <asp:TextBox ID="txtAddress" required placeholder="address" MaxLength="255" TextMode="MultiLine" Rows="4" Width="300px" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox></td>
                                                <td>Designation:</td>
                                                <td>
                                                    <asp:TextBox ID="txtDesignation" runat="server" placeholder="designation" MaxLength="100" Width="250px" Text='<%# Bind("Designation") %>'></asp:TextBox></td>
                                            </tr>
                                            <tr>

                                                <td>TIN No.:</td>
                                                <td>
                                                    <asp:TextBox ID="txtTIN" Text='<%# Bind("TIN_No") %>' placeholder="tin number" runat="server" MaxLength="20" Width="120px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>Contact No.:</td>
                                                <td>
                                                    <asp:TextBox ID="txtContact_No" runat="server" required placeholder="+8801xxxxxxxxx" MaxLength="50" Text='<%# Bind("Contact_No") %>'
                                                        pattern="^[\+]880(1[156789])\d{8}$" ToolTip="Bangladesh Mobile No. (+8801xxxxxxxxx)"></asp:TextBox></td>
                                                <td colspan="2">Name on Card:
                                                    <asp:TextBox ID="txtNameOncard" runat="server" placeholder="name on card" Text='<%# Bind("NameOncard") %>' MaxLength="19" Width="200px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>Email:</td>
                                                <td>
                                                    <asp:TextBox ID="txtEmail" runat="server" placeholder="email" MaxLength="100" Width="300px" Text='<%# Bind("Email") %>'></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" runat="server" Display="Dynamic" ForeColor="Red"
                                                        ControlToValidate="txtEmail" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>

                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">

                                <tr>
                                    <td>Gross Income per Month:</td>
                                    <td>
                                        <asp:TextBox ID="txtIncome" Text='<%# Bind("Income","{0:N2}") %>' placeholder="0.00" runat="server" MaxLength="20" Width="100px"></asp:TextBox>
                                        BDT

                                    </td>

                                </tr>
                                <tr class="td-header">
                                    <td colspan="2">Points for Other Consideration</td>
                                </tr>
                                <tr>
                                    <td>Income Validated:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB1" runat="server" SelectedValue='<%# Bind("B1") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B1" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB1" runat="server" ControlToValidate="ddlB1" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Sufficient Documents:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB2" runat="server" SelectedValue='<%# Bind("B2") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B2" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB2" runat="server" ControlToValidate="ddlB2" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Existing Account Holder:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB3" runat="server" SelectedValue='<%# Bind("B3") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B3" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB3" runat="server" ControlToValidate="ddlB3" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>CPV Result:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB4" runat="server" SelectedValue='<%# Bind("B4") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B4" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB4" runat="server" ControlToValidate="ddlB4" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>TBL Account Holder:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB5" runat="server" SelectedValue='<%# Bind("B5") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B5" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB5" runat="server" ControlToValidate="ddlB5" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>A/C Auto Debit Instruction:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB6" runat="server" SelectedValue='<%# Bind("B6") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B6" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB6" runat="server" ControlToValidate="ddlB6" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Salary A/C with TBL:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlB7" runat="server" SelectedValue='<%# Bind("B7") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_B7" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqB7" runat="server" ControlToValidate="ddlB7" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Type of Organization:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlB8" runat="server" SelectedValue='<%# Bind("B8") %>'
                                            DataSourceID="sql_B8" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqB8" runat="server" ControlToValidate="ddlB8" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr class="td-header">
                                    <td colspan="2">Employment Details</td>
                                </tr>
                                <tr>
                                    <td>Person Type:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlC1" runat="server" SelectedValue='<%# Bind("C1") %>' RepeatLayout="Flow" RepeatDirection="Horizontal" Width="400px"
                                            DataSourceID="sql_C1" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqC1" runat="server" ControlToValidate="ddlC1" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>

                                    </td>

                                </tr>
                                <tr>
                                    <td>Length of Service/Business:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlC2" runat="server" SelectedValue='<%# Bind("C2") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C2" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqC2" runat="server" ControlToValidate="ddlC2" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>6 Months Avg. A/C Balance:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC3" runat="server" SelectedValue='<%# Bind("C3") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C3" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC3" runat="server" ControlToValidate="ddlC3" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Residential Status (Local):</td>
                                    <td>
                                        <asp:DropDownList ID="ddlC4" runat="server" SelectedValue='<%# Bind("C4") %>'
                                            DataSourceID="sql_C4" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqC4" runat="server" ControlToValidate="ddlC4" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Phone in own name at:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlC5" runat="server" SelectedValue='<%# Bind("C5") %>'
                                            DataSourceID="sql_C5" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqC5" runat="server" ControlToValidate="ddlC5" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Holding Valid Passport:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC6" runat="server" SelectedValue='<%# Bind("C6") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C6" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC6" runat="server" ControlToValidate="ddlC6" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Regd. Club Membership:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC7" runat="server" SelectedValue='<%# Bind("C7") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C7" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC7" runat="server" ControlToValidate="ddlC7" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Credit Reference from Source:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC8" runat="server" SelectedValue='<%# Bind("C8") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C8" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC8" runat="server" ControlToValidate="ddlC8" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Marital Status:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC9" runat="server" SelectedValue='<%# Bind("C9") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C9" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC9" runat="server" ControlToValidate="ddlC9" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Spouse is Employeed:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC10" runat="server" SelectedValue='<%# Bind("C10") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C10" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC10" runat="server" ControlToValidate="ddlC10" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Ownership of Vehicle:</td>
                                    <td>
                                        <asp:RadioButtonList ID="ddlC11" runat="server" SelectedValue='<%# Bind("C11") %>' RepeatLayout="Flow" RepeatDirection="Horizontal"
                                            DataSourceID="sql_C11" DataTextField="Name" DataValueField="SL">
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="reqC11" runat="server" ControlToValidate="ddlC11" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Age (years):</td>
                                    <td>
                                        <asp:DropDownList ID="ddlC12" runat="server" SelectedValue='<%# Bind("C12") %>'
                                            DataSourceID="sql_C12" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqC12" runat="server" ControlToValidate="ddlC12" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr class="td-header">
                                    <td colspan="2">Points for Professionals & Businessman</td>
                                </tr>
                                <tr>
                                    <td>Professions/Businessman:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlD1" runat="server" SelectedValue='<%# Bind("D1") %>' Width="400px"
                                            DataSourceID="sql_D1" DataTextField="Name" DataValueField="SL">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqD1" runat="server" ControlToValidate="ddlD1" ForeColor="Red" Font-Bold="true" SetFocusOnError="true">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr class="td-header">
                                    <td colspan="2">Multiple Factor on Total: <%# Eval("Factor") %></td>

                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr>
                                    <td colspan="2">CIB Status: <%# Eval("CIB") %></td>
                                </tr>
                                <tr>
                                    <td colspan="2">Calculated Limit: <%# Eval("Income","{0:N2}") %> x <%# Eval("Factor") %> = <b><%# Eval("CalculatedLimited","{0:N2}") %> BDT</b></td>
                                </tr>
                                <tr>
                                    <td>Previous Limit (BDT):
                                        <asp:TextBox runat="server" ID="txtPrevLimit" MaxLength="20" Text='<%# Bind("Prev_Limit") %>' Width="100px" placeholder="0.00"></asp:TextBox></td>
                                    <td>Previous Limit (USD):
                                        <asp:TextBox runat="server" ID="txtPrevLimitUSD" MaxLength="20" Text='<%# Bind("Prev_Limit_USD") %>' Width="100px" placeholder="0.00"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Prepared By: <%# Eval("Updated_By") %>, <%# Eval("UpdateByName") %><%# Eval("UpdateByDegisnation",", {0}") %></td>
                                    <td><%# Eval("Verified_By","Verified By: {0}") %><%# Eval("VerifiedByName",", {0}") %><%# Eval("VerifiedByDegisnation",", {0}") %></td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr class="td-header">
                                    <td colspan="2">Reviewed By</td>
                                </tr>
                                <tr>
                                    <td colspan='2'>Remarks:<br />
                                        <asp:TextBox runat="server" ID="txtComments" MaxLength="4000" Text='<%# Bind("Comments") %>' Rows="5" TextMode="MultiLine" Width="700px" placeholder="review remarks"></asp:TextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <asp:TextBox runat="server" ID="txtAC1" MaxLength="100" Width="250px" CssClass="center" Text='<%# Bind("AC1") %>'
                                            placeholder="sign authority"></asp:TextBox>


                                    </td>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <asp:TextBox runat="server" ID="txtAC2" MaxLength="100" Width="250px" CssClass="center" Text='<%# Bind("AC2") %>'
                                            placeholder="sign authority"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr class="td-header">
                                    <td colspan="2">Approval Commitee</td>
                                </tr>
                                <tr>
                                    <td>Remarks:<br />
                                        <asp:TextBox runat="server" ID="txtComments_Dep_Head" MaxLength="4000" Text='<%# Bind("Comments_Dep_Head") %>' Rows="3" TextMode="MultiLine" Width="450px" placeholder="approval commitee remarks"></asp:TextBox>

                                    </td>
                                    <td rowspan="2" valign="bottom" style="min-width: 80px" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <asp:TextBox runat="server" ID="txtAC3" MaxLength="100" Width="200px" CssClass="center" Text='<%# Bind("AC3") %>'
                                            placeholder="sign authority"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Proposed/Approved Limit: BDT:
                                        <asp:TextBox runat="server" ID="txtProposed_Limit" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Proposed_Limit") %>'
                                            placeholder="0.00"></asp:TextBox>

                                        and USD:
                                        <asp:TextBox runat="server" ID="txtProposed_Limit_USD" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Proposed_Limit_USD") %>'
                                            placeholder="0.00"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Remarks:<br />
                                        <asp:TextBox runat="server" ID="txtComments_App_Commitee" MaxLength="4000" Text='<%# Bind("Comments_App_Commitee") %>' Rows="3" TextMode="MultiLine" Width="450px" placeholder="remarks"></asp:TextBox>

                                    </td>
                                    <td rowspan="2" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <asp:TextBox runat="server" ID="txtAC4" MaxLength="100" Width="200px" CssClass="center" Text='<%# Bind("AC4") %>'
                                            placeholder="sign authority"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Approved Limit: BDT:
                                        <asp:TextBox runat="server" ID="txtApproved_Limit" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Approved_Limit") %>'
                                            placeholder="0.00"></asp:TextBox>

                                        and USD:
                                        <asp:TextBox runat="server" ID="txtApproved_Limit_usd" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Approved_Limit_usd") %>'
                                            placeholder="0.00"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>

                                        <asp:TextBox runat="server" ID="txtComments_App_Commitee1" MaxLength="4000" Text='<%# Bind("Comments_App_Commitee1") %>' Rows="3" TextMode="MultiLine" Width="450px" placeholder="remarks"></asp:TextBox>

                                    </td>
                                    <td rowspan="2" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <asp:TextBox runat="server" ID="txtAC5" MaxLength="100" Width="200px" CssClass="center" Text='<%# Bind("AC5") %>'
                                            placeholder="sign authority"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Approved Limit: BDT:
                                      
                                        <asp:TextBox runat="server" ID="txtApproved_Limit1" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Approved_Limit1") %>'
                                            placeholder="0.00"></asp:TextBox>

                                        and USD:
                                        <asp:TextBox runat="server" ID="txtApproved_Limit_usd1" MaxLength="20" Width="100px"
                                            CssClass="center" Text='<%# Bind("Approved_Limit_usd1") %>'
                                            placeholder="0.00"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr class="td-header">
                                    <td colspan="2">Card Division Official Use Only</td>
                                </tr>
                                <tr>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        Authorized Signature</td>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        Authorized Signature</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table style="border-collapse: collapse" class="noborder" width="100%">
                                            <tr>
                                                <td>Card Type: <%# Eval("Card_Type","<b>{0}</b>") %>
                                                    <asp:DropDownList ID="dblCard_Type" runat="server" SelectedValue='<%# Bind("Card_Type") %>'
                                                        DataSourceID="sql_Card_Type" DataTextField="Cards" DataValueField="ID" AppendDataBoundItems="true">
                                                        <asp:ListItem></asp:ListItem>
                                                    </asp:DropDownList>

                                                </td>
                                                <td>Card No: 
                                                    <asp:TextBox runat="server" ID="txtCardNo" MaxLength="20" Width="150px"
                                                        CssClass="center" Text='<%# Bind("Card_No") %>'
                                                        placeholder="card number"></asp:TextBox>
                                                </td>
                                                <td>Approval Date: 
                                                    <asp:TextBox runat="server" ID="txtApproval_Date" MaxLength="10" Width="80px"
                                                        CssClass="Date" Text='<%# Bind("Approval_Date","{0:dd/MM/yyyy}") %>'
                                                        placeholder=""></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table class="Grid" style="width: 100%; border-collapse: collapse">
                                <tr>
                                    <td colspan="2">
                                        <table class="noborder" width="100%">
                                            <tr>
                                                <td>
                                                    <img src="Images/logo.jpg" height="25" />
                                                </td>
                                                <td style="text-align: center; font-weight: bold; font-size: 150%">Credit Card Scoring & Approval Sheet</td>
                                                <td style="text-align: right; font-weight: bold">App ID: <%# Eval("SL") %></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <table class="noborder" >
                                            <tr>
                                                <td valign="top">Name:</td>
                                                <td valign="top" style="font-size: 120%; font-weight: bold"><%# Eval("Applicant") %></td>
                                            </tr>
                                            <tr>
                                                <td  valign="top">Address:</td>
                                                <td valign="top" ><%# Eval("Address").ToString().Replace("\n","<br>") %></td>
                                            </tr>
                                           
                                            <tr>
                                                <td valign="top">Contact No.:</td>
                                                <td valign="top"><%# Eval("Contact_No") %></td>
                                            </tr>
                                            <%# Eval("Email","<tr><td valign='top'>Email:</td><td>{0}</td></tr>") %>                                            
                                        </table>
                                    </td>
                                    <td valign="top">
                                        <table class="noborder">
                                            <tr>
                                                <td valign="top">Company:</td>
                                                <td valign="top"><%# Eval("Company") %></td>
                                            </tr>
                                            <tr>                                               
                                                <td valign="top">Designation:</td>
                                                <td valign="top"><%# Eval("Designation") %></td>
                                            </tr>
                                            <tr>

                                                <td valign="top">TIN No.:</td>
                                                <td valign="top"><%# Eval("TIN_No") %></td>
                                            </tr>
                                            
                                            <tr>
                                                <td valign="top">Name on Card:</td>
                                                <td valign="top"><%# Eval("NameOncard") %></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr style="font-weight: bold" class="center">
                                    <td colspan="2"></td>
                                    <td>Max</td>
                                    <td>Score</td>
                                </tr>
                                <tr>
                                    <td>Gross Income per Month:</td>
                                    <td><b><%# Eval("Income","{0:N2}") %> BDT</b>

                                        <%# Eval("Income_Name","({0})") %>

                                    </td>
                                    <td class="center">40</td>
                                    <td class="center"><%# Eval("Income_Val") %></td>
                                </tr>
                                <tr class="td-header">
                                    <td colspan="4">Points for Other Consideration</td>
                                </tr>
                                <tr>
                                    <td>Income Validated:</td>
                                    <td><%# Eval("B1_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("B1_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Sufficient Documents:</td>
                                    <td><%# Eval("B2_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("B2_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Existing Account Holder:</td>
                                    <td><%# Eval("B3_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("B3_Val") %></td>
                                </tr>
                                <tr>
                                    <td>CPV Result:</td>
                                    <td><%# Eval("B4_Name") %></td>
                                    <td class="center">3</td>
                                    <td class="center"><%# Eval("B4_Val") %></td>
                                </tr>
                                <tr>
                                    <td>TBL Account Holder:</td>
                                    <td><%# Eval("B5_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("B5_Val") %></td>
                                </tr>
                                <tr>
                                    <td>A/C Auto Debit Instruction:</td>
                                    <td><%# Eval("B6_Name") %></td>
                                    <td class="center">1</td>
                                    <td class="center"><%# Eval("B6_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Salary A/C with TBL:</td>
                                    <td><%# Eval("B7_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("B7_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Type of Organization:</td>
                                    <td><%# Eval("B8_Name") %></td>
                                    <td class="center">4</td>
                                    <td class="center"><%# Eval("B8_Val") %></td>
                                </tr>
                                <tr class="td-header">
                                    <td colspan="4">Employment Details</td>
                                </tr>
                                <tr>
                                    <td>Person Type:</td>
                                    <td><%# Eval("C1_Name") %></td>
                                    <td class="center">4</td>
                                    <td class="center"><%# Eval("C1_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Length of Service/Business:</td>
                                    <td><%# Eval("C2_Name") %></td>
                                    <td class="center">3</td>
                                    <td class="center"><%# Eval("C2_Val") %></td>
                                </tr>
                                <tr>
                                    <td>6 Months Avg. A/C Balance:</td>
                                    <td><%# Eval("C3_Name") %></td>
                                    <td class="center">3</td>
                                    <td class="center"><%# Eval("C3_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Residential Status (Local):</td>
                                    <td><%# Eval("C4_Name") %></td>
                                    <td class="center">4</td>
                                    <td class="center"><%# Eval("C4_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Phone in own name at:</td>
                                    <td><%# Eval("C5_Name") %></td>
                                    <td class="center">3</td>
                                    <td class="center"><%# Eval("C5_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Holding Valid Passport:</td>
                                    <td><%# Eval("C6_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("C6_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Regd. Club Membership:</td>
                                    <td><%# Eval("C7_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("C7_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Credit Reference from Source:</td>
                                    <td><%# Eval("C8_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("C8_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Marital Status:</td>
                                    <td><%# Eval("C9_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("C9_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Spouse is Employeed:</td>
                                    <td><%# Eval("C10_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("C10_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Ownership of Vehicle:</td>
                                    <td><%# Eval("C11_Name") %></td>
                                    <td class="center">2</td>
                                    <td class="center"><%# Eval("C11_Val") %></td>
                                </tr>
                                <tr>
                                    <td>Age (years):</td>
                                    <td><%# Eval("C12_Name") %></td>
                                    <td class="center">3</td>
                                    <td class="center"><%# Eval("C12_Val") %></td>
                                </tr>
                                <tr class="td-header">
                                    <td colspan="4">Points for Professionals & Businessman</td>
                                </tr>
                                <tr>
                                    <td>Professions/Businessman:</td>
                                    <td><%# Eval("D1_Name") %></td>
                                    <td class="center">10</td>
                                    <td class="center"><%# Eval("D1_Val") %></td>
                                </tr>
                                <tr class="td-header">
                                    <td colspan="2">Multiple Factor on Total: <%# Eval("Factor") %></td>
                                    <td class="center">100</td>
                                    <td class="center"><%# Eval("Total_Val") %></td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr>
                                    <td colspan="2">CIB Status: <%# Eval("CIB") %></td>
                                </tr>
                                <tr>
                                    <td colspan="2">Calculated Limit: <%# Eval("Income","{0:N2}") %> x <%# Eval("Factor") %> = <b><%# Eval("CalculatedLimited","{0:N2}") %> BDT</b></td>
                                </tr>
                                <tr>
                                    <td>Previous Limit (BDT): <%# Eval("Prev_Limit","{0:N2}") %></td>
                                    <td>Previous Limit (USD): <%# Eval("Prev_Limit_USD","{0:N2}") %></td>
                                </tr>
                                <tr>
                                    <td>Prepared By: <%# Eval("Updated_By") %>, <%# Eval("UpdateByName") %><%# Eval("UpdateByDegisnation",", {0}") %></td>
                                    <td><%# Eval("Verified_By","Verified By: {0}") %><%# Eval("VerifiedByName",", {0}") %><%# Eval("VerifiedByDegisnation",", {0}") %></td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr class="td-header">
                                    <td colspan="2">Reviewed By</td>
                                </tr>
                                <tr>
                                    <td colspan='2' valign="top">
                                        <div>
                                            Remarks: <%# Eval("Comments","{0}").ToString().Replace("\n","<br>") %>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <%# Eval("AC1") %></td>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        <%# Eval("AC2") %>
                                    </td>
                                </tr>
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr class="td-header">
                                    <td colspan="2" >Approval Commitee</td>
                                </tr>
                                <tr>
                                    <td valign="top">Remarks: <%# Eval("Comments_Dep_Head","<b>{0}</b>") %>
                                        <br />
                                        Proposed/Approved Limit: BDT:
                                        <%# Eval("Proposed_Limit","{0:N2}") %>

                                        <%# Eval("Proposed_Limit_USD"," and USD: {0:N2}") %>
                                    </td>
                                    <td valign="bottom" style="min-width: 80px" align="center">
                                        <br />
                                        <br /><br />
                                        <hr />
                                        <%# Eval("AC3") %>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td valign="top">Remarks: <%# Eval("Comments_App_Commitee","<b>{0}</b>") %>
                                        <br />
                                        Approved Limit: BDT:
                                        <%# Eval("Approved_Limit","{0:N2}") %>
                                        <%# Eval("Approved_Limit_usd"," and USD: {0:N2}") %>
                                    </td>
                                    <td valign="bottom" align="center">
                                        <br /><br />
                                        <br />
                                        <hr />
                                        <%# Eval("AC4") %>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td valign="top">Remarks: <%# Eval("Comments_App_Commitee1","<b>{0}</b>") %>
                                        <br />
                                        Approved Limit: BDT:
                                        <%# Eval("Approved_Limit1","{0:N2}") %>
                                        <%# Eval("Approved_Limit_usd1"," and USD: {0:N2}") %>
                                    </td>
                                    <td rowspan="2" valign="bottom" align="center">
                                        <br /><br />
                                        <br />
                                        <hr />
                                        <%# Eval("AC5") %>
                                    </td>
                                </tr>
                               
                            </table>
                            <table class="Grid" style="border-collapse: collapse; width: 100%">
                                <tr class="td-header">
                                    <td colspan="2">Card Division Official Use Only</td>
                                </tr>
                                <tr>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        Authorized Signature</td>
                                    <td width="50%" valign="bottom" align="center">
                                        <br />
                                        <br />
                                        <hr />
                                        Authorized Signature</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table style="border-collapse: collapse" class="noborder" width="100%">
                                            <tr>
                                                <td>Card Type: <%# Eval("Card_Type_Name","<b>{0}</b>") %>
                                                </td>
                                                <td>Card No: <%# Eval("Card_No","<b>{0}</b>") %>
                                                </td>
                                                <td>Approval Date: <%# Eval("Approval_Date","<b>{0:dd/MM/yyyy}</b>") %>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <div style="text-align: right"><%# Eval("Update_Date_Time","Updated on: {0:MMM dd, yyyy h:mm:ss tt}") %></div>
                        </ItemTemplate>
                        <ItemStyle Width="700px" CssClass="print-small" />
                        
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False" ControlStyle-Width="80px">
                        <EditItemTemplate>
                            <asp:Button ID="cmdUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:Button>
                            <asp:ConfirmButtonExtender runat="server" ID="conUpdate" TargetControlID="cmdUpdate"
                                ConfirmText="Do you want to Update?" />
                            <asp:Button ID="cmdCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:Button>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:Button ID="cmdInsert" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert"></asp:Button>
                            <asp:Button ID="cmdCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:Button>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="cmdEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:Button>
                            
                        </ItemTemplate>
                        <ItemStyle CssClass="hidden-print" />
                    </asp:TemplateField>

















                </Fields>
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />

            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>" InsertCommand="usp_Credit_Add_Edit" InsertCommandType="StoredProcedure" SelectCommand="usp_OpenCredit" SelectCommandType="StoredProcedure" UpdateCommand="usp_Credit_Add_Edit" UpdateCommandType="StoredProcedure" OnInserted="SqlDataSource1_Inserted" OnUpdated="SqlDataSource1_Updated">
                <InsertParameters>
                    <asp:Parameter Name="Applicant" Type="String" />
                    <asp:Parameter Name="ADDRESS" Type="String" />
                    <asp:Parameter Name="Contact_No" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="Company" Type="String" />
                    <asp:Parameter Name="Designation" Type="String" />
                    <asp:Parameter Name="TIN_No" Type="String" />
                    <asp:Parameter Name="Income" Type="Decimal" />
                    <asp:Parameter Name="B1" Type="Int16" />
                    <asp:Parameter Name="B2" Type="Int16" />
                    <asp:Parameter Name="B3" Type="Int16" />
                    <asp:Parameter Name="B4" Type="Int16" />
                    <asp:Parameter Name="B5" Type="Int16" />
                    <asp:Parameter Name="B6" Type="Int16" />
                    <asp:Parameter Name="B7" Type="Int16" />
                    <asp:Parameter Name="B8" Type="Int16" />
                    <asp:Parameter Name="C1" Type="Int16" />
                    <asp:Parameter Name="C2" Type="Int16" />
                    <asp:Parameter Name="C3" Type="Int16" />
                    <asp:Parameter Name="C4" Type="Int16" />
                    <asp:Parameter Name="C5" Type="Int16" />
                    <asp:Parameter Name="C6" Type="Int16" />
                    <asp:Parameter Name="C7" Type="Int16" />
                    <asp:Parameter Name="C8" Type="Int16" />
                    <asp:Parameter Name="C9" Type="Int16" />
                    <asp:Parameter Name="C10" Type="Int16" />
                    <asp:Parameter Name="C11" Type="Int16" />
                    <asp:Parameter Name="C12" Type="Int16" />
                    <asp:Parameter Name="D1" Type="Int16" />
                    <asp:Parameter Name="DBR" Type="String" />
                    <asp:Parameter Name="CIB" Type="String" />
                    <asp:Parameter Name="Approved_Limit" Type="Decimal" />
                    <asp:Parameter Name="Proposed_Limit" Type="Decimal" />
                    <asp:Parameter Name="Approved_Limit_usd" Type="Decimal" />
                    <asp:Parameter Name="Proposed_Limit_usd" Type="Decimal" />
                    <asp:Parameter Name="Approved_Limit1" Type="Decimal" />
                    <asp:Parameter Name="Approved_Limit_usd1" Type="Decimal" />
                    <asp:Parameter Name="Approval_Date" Type="DateTime" DefaultValue="01/01/1900" />
                    <asp:Parameter Name="Card_No" Type="String" />
                    <asp:Parameter Name="Card_Type" Type="Int32" DefaultValue="0" />
                    <asp:Parameter Name="Verified_By" Type="String" />
                    <asp:Parameter Name="AC1" Type="String" />
                    <asp:Parameter Name="AC2" Type="String" />
                    <asp:Parameter Name="AC3" Type="String" />
                    <asp:Parameter Name="AC4" Type="String" />
                    <asp:Parameter Name="AC5" Type="String" />
                    <asp:Parameter Name="AC6" Type="String" />
                    <asp:Parameter Name="STATUS" Type="Int32" DefaultValue="0" />
                    <asp:SessionParameter SessionField="EMPID" Name="Updated_By" Type="String" />                    
                    <asp:Parameter Name="Comments" Type="String" />
                    <asp:Parameter Name="Comments_Dep_Head" Type="String" />
                    <asp:Parameter Name="Comments_App_Commitee" Type="String" />
                    <asp:Parameter Name="Comments_App_Commitee1" Type="String" />
                    <asp:Parameter Name="CalLimit" Type="String" />
                    <asp:Parameter Name="SL" Type="Int64" DefaultValue="0" Direction="InputOutput" />
                    <asp:Parameter Name="Msg" Type="String" DefaultValue=" " Size="255" Direction="InputOutput" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="param_SL" QueryStringField="id" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Msg" Type="String" DefaultValue =" " Size="255" Direction="InputOutput" />
                    <asp:QueryStringParameter Name="SL" QueryStringField="id" Type="Int64" />
                    <asp:Parameter Name="Applicant" Type="String" />
                    <asp:Parameter Name="ADDRESS" Type="String" />
                    <asp:Parameter Name="Contact_No" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="Company" Type="String" />
                    <asp:Parameter Name="Designation" Type="String" />
                    <asp:Parameter Name="TIN_No" Type="String" />
                    <asp:Parameter Name="Income" Type="Decimal" />
                    <asp:Parameter Name="B1" Type="Int16" />
                    <asp:Parameter Name="B2" Type="Int16" />
                    <asp:Parameter Name="B3" Type="Int16" />
                    <asp:Parameter Name="B4" Type="Int16" />
                    <asp:Parameter Name="B5" Type="Int16" />
                    <asp:Parameter Name="B6" Type="Int16" />
                    <asp:Parameter Name="B7" Type="Int16" />
                    <asp:Parameter Name="B8" Type="Int16" />
                    <asp:Parameter Name="C1" Type="Int16" />
                    <asp:Parameter Name="C2" Type="Int16" />
                    <asp:Parameter Name="C3" Type="Int16" />
                    <asp:Parameter Name="C4" Type="Int16" />
                    <asp:Parameter Name="C5" Type="Int16" />
                    <asp:Parameter Name="C6" Type="Int16" />
                    <asp:Parameter Name="C7" Type="Int16" />
                    <asp:Parameter Name="C8" Type="Int16" />
                    <asp:Parameter Name="C9" Type="Int16" />
                    <asp:Parameter Name="C10" Type="Int16" />
                    <asp:Parameter Name="C11" Type="Int16" />
                    <asp:Parameter Name="C12" Type="Int16" />
                    <asp:Parameter Name="D1" Type="Int16" />
                    <asp:Parameter Name="DBR" Type="String" />
                    <asp:Parameter Name="CIB" Type="String" />
                    <asp:Parameter Name="Approved_Limit" Type="Decimal" />
                    <asp:Parameter Name="Proposed_Limit" Type="Decimal" />
                    <asp:Parameter Name="Approved_Limit_usd" Type="Decimal" />
                    <asp:Parameter Name="Proposed_Limit_usd" Type="Decimal" />
                    <asp:Parameter Name="Approved_Limit1" Type="Decimal" />
                    <asp:Parameter Name="Approved_Limit_usd1" Type="Decimal" />
                    <asp:Parameter Name="Approval_Date" Type="DateTime" DefaultValue="01/01/1900" />
                    <asp:Parameter Name="Card_No" Type="String" />
                    <asp:Parameter Name="Card_Type" Type="Int32" DefaultValue="0" />
                    <asp:Parameter Name="Verified_By" Type="String" />
                    <asp:Parameter Name="AC1" Type="String" />
                    <asp:Parameter Name="AC2" Type="String" />
                    <asp:Parameter Name="AC3" Type="String" />
                    <asp:Parameter Name="AC4" Type="String" />
                    <asp:Parameter Name="AC5" Type="String" />
                    <asp:Parameter Name="AC6" Type="String" />
                    <asp:Parameter Name="STATUS" Type="Int32" DefaultValue="0" />
                    <asp:SessionParameter SessionField="EMPID" Name="Updated_By" Type="String" />
                    <asp:Parameter Name="Comments" Type="String" />
                    <asp:Parameter Name="Comments_Dep_Head" Type="String" />
                    <asp:Parameter Name="Comments_App_Commitee" Type="String" />
                    <asp:Parameter Name="Comments_App_Commitee1" Type="String" />
                    <asp:Parameter Name="CalLimit" Type="Decimal" />
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

