﻿<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sattlement_Upload.aspx.cs" Inherits="Sattlement_Upload" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Sattlement_Upload.aspx.cs" Inherits="Sattlement_Upload" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">


        function UploadError() {
            $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html('File Uploading Error. Please try again.');
        }

        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var contentType = args.get_contentType();
            var text = "Size of " + filename + " is " + args.get_length() + " bytes";
            if (contentType.length > 0) {
                text += " and content type is '" + contentType + "'.";
            }
            $('#UploadBtn').show('Slow');
            $('#ctl00_ContentPlaceHolder2_lblUploadStatus').html('<b>' + filename + '</b> is successfully uploaded.<br>');

        }            

    </script>

    <style type="text/css">
        .Border1
        {
            background-color: #FFFFB5;
            padding: 10px;
            border: solid 1px green;
            width: 200px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    Settlement File Upload/Download</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField runat="server" ID="HidPageID" />
            <asp:HiddenField runat="server" ID="HidUploadTempFile" />
            <div id="tabs" style="width: 900px;">
                <ul>
                    <li style="display: inline"><a href='#upload'>Upload</a></li><li style="display: inline">
                        <a href='#history'>History</a></li></ul>
                <div id="upload">
                    <asp:Button ID="cmdClearData" runat="server" Text="Clear Data" OnClick="cmdClearData_Click"
                        Visible="false" />
                    <asp:Panel ID="Panel1" runat="server">
                        <div class="Panel1 ui-corner-all" style="padding: 0 0 10px 0px; width: 700px">
                            <table>
                                <tr>
                                    <td valign="top" style="padding: 10px">
                                        <img src="Images/card.gif" width="100px" height="66px" />
                                    </td>
                                    <td>
                                        <div style="font-size: small; font-weight: bolder; padding: 10px 0px 3px 0px;">
                                            Please select Settlement txt file:</div>
                                        <asp:AsyncFileUpload ID="FileUpload1" runat="server" OnUploadedComplete="FileUpload1_UploadedComplete"
                                            ThrobberID="myThrobber" OnClientUploadComplete="UploadComplete" OnClientUploadError="UploadError"
                                            CssClass="AsyncFileUploadField" OnUploadedFileError="FileUpload1_UploadedFileError"
                                            UploaderStyle="Traditional" />
                                        <asp:Image ImageUrl="~/Images/ajax-loader.gif" ID="myThrobber" runat="server" />
                                        <div style="padding: 5px 0px 10px 0px">
                                            <asp:Label ID="lblUploadStatus" runat="server" Text=""></asp:Label>
                                        </div>
                                        <div style="display: none;" id="UploadBtn">
                                            <asp:Button ID="cmdCheck" runat="server" Text="View Data" Width="150px" Font-Bold="true"
                                                Height="30px" OnClick="cmdCheck_Click" CssClass="ui-corner-all" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel2" runat="server">
                        <%--<table class="Panel1 ui-corner-all">
                            <tr>
                                <td>
                                    Select Accounts who have card transactions on and after:
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtDate" CssClass="Date" Width="80px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDate" Text="*"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <asp:Button ID="cmdUpdate" runat="server" Text="Save for Reissue" Width="160px" Font-Bold="true"
                                        Height="30px" OnClick="cmdUpdate_Click" />
                                    <asp:ConfirmButtonExtender ID="cmdUpdate_ConfirmButtonExtender" runat="server" ConfirmText="Are you sure?"
                                        Enabled="True" TargetControlID="cmdUpdate">
                                    </asp:ConfirmButtonExtender>
                                </td>
                            </tr>
                        </table>--%>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </asp:Panel>

                    <div style="padding-left:20px;text-align:right;" align="center">
                <asp:Button ID="ProcessSettlementValue" runat="server" Text="Save Data" Width="120px" Visible="false" OnClick="SettlementProcess" />
                <asp:ConfirmButtonExtender runat="server" ID="confirmsave" TargetControlID="ProcessSettlementValue" ConfirmText="Do you want to Save?"></asp:ConfirmButtonExtender>
                                        </div>

                    <asp:GridView ID="GridView1" runat="server" BackColor="White" AllowPaging="True"
                        CssClass="Grid" AllowSorting="True" BorderColor="#DEDFDE" BorderStyle="None"
                        BorderWidth="1px" CellPadding="4" ForeColor="Black" AutoGenerateColumns="False"
                        Style="font-size: small; font-family: Arial" DataKeyNames="SettlementID"
                        PageSize="15" DataSourceID="ObjectDataSource1">
                        <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" PageButtonCount="30" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <Columns>
                            <asp:BoundField DataField="SettlementID" HeaderText="#" 
                                ReadOnly="True" SortExpression="SettlementID"
                                InsertVisible="False" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="BankName" HeaderText="Bank Name" ItemStyle-HorizontalAlign="Left"
                                SortExpression="BankName" />
                            <asp:BoundField DataField="AccountNo" HeaderText="Account No" 
                                SortExpression="AccountNo" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" 
                                ItemStyle-HorizontalAlign="Right" DataFormatString="{0:N2}"  />
                            <asp:BoundField DataField="DrCr" HeaderText="DrCr" SortExpression="DrCr" 
                                ItemStyle-HorizontalAlign="Center" />
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <PagerStyle HorizontalAlign="Left" CssClass="PagerStyle" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>

                    <%--<td style="padding-left:20px">
                <asp:Button ID="ProcessSettlementValue" runat="server" Text="Save Data" Width="120px" Visible="false" OnClick="SettlementProcess"/>
                                        </td>--%>

                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"
                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                        TypeName="DataSet_ATMTableAdapters.TempSettlementTableAdapter">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HidPageID" Name="SessionID" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:Parameter Name="BankName" Type="String" />
                            <asp:Parameter Name="AccountNo" Type="String" />
                            <asp:Parameter Name="Amount" Type="Decimal" />
                            <asp:Parameter Name="DrCr" Type="String" />
                            <asp:Parameter Name="SessionID" Type="String" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                    <asp:Button runat="server" ID="cmdUploadAgain" Text="Upload Another" Width="130px"
                        Height="30px" Font-Bold="true" Visible="false" OnClick="cmdUploadAgain_Click" />
                </div>

                


                <div id="history">
                    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" CssClass="Grid" AllowSorting="True"
                        AutoGenerateColumns="False" BackColor="White" Width="800px" PagerSettings-Position="TopAndBottom"
                        PagerSettings-Mode="NumericFirstLast" BorderColor="#DEDFDE" BorderStyle="Solid"
                        BorderWidth="1px" CellPadding="4" PageSize="20" DataKeyNames="ID" DataSourceID="SqlDataSourceDataUploadLog"
                        ForeColor="Black" Style="font-size: small" 
                        EnableSortingAndPagingCallbacks="True" 
                        onselectedindexchanged="GridView2_SelectedIndexChanged">
                        <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                        <RowStyle BackColor="#F7F7DE" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                SortExpression="ID" />
                            <asp:TemplateField HeaderText="Uploaded On" SortExpression="DT" ItemStyle-Wrap="false"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <span title='<%# Eval("DT", "{0:dddd, \nd MMMM, yyyy \nh:mm:ss tt}")%>'>
                                        <%# TrustControl1.ToRecentDateTime(Eval("DT"))%></span></ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="About" SortExpression="DT" ItemStyle-Wrap="false"
                                ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <%# TrustControl1.ToRelativeDate((DateTime)Eval("Dt")) %>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Wrap="False" /> 
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="By Emp" SortExpression="EmpID">
                                <ItemTemplate>
                                    <uc2:EMP ID="EMP1" runat="server" Username='<%# Eval("EmpID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" DataFormatString="{0:N0}" />
                            <%--<asp:BoundField DataField="SelectedAfter" HeaderText="Selected After" SortExpression="SelectedAfter"
                                DataFormatString="{0:dd MMM yyyy}" />--%>

                                <asp:TemplateField HeaderText="View Data" SortExpression="batchId">
                                <ItemTemplate>
                                    <a href='SettlementView.aspx?batchid=<%# Eval("ID") %>' target="_blank" class="Link">
                                        <span style="color: blue">
                                            View</span></a>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%--<asp:TemplateField HeaderText="" SortExpression="batchId">
                                <ItemTemplate>
                                    <a href='SettlementDrView.aspx?batchId=<%# Eval("ID") %>' target="_blank" class="Link">
                                        <span style="color: blue">
                                            DrDownload</span></a>
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                            <%-- <asp:TemplateField>
                               <ItemTemplate>
                                   <asp:LinkButton runat="server" ID="lblDelteExisting" Text="D"></asp:LinkButton>
                                   <asp:ConfirmButtonExtender runat="server" ID="ConfirmButtonExtenderlblDelteExisting" TargetControlID="lblDelteExisting"></asp:ConfirmButtonExtender>
                               </ItemTemplate>
                               </asp:TemplateField>
 --%>
 

                             

                           
                            <asp:TemplateField HeaderText="Download">
                                <ItemTemplate>                            
                                    <a href='SettlementFileDownload.aspx?batchid=<%# Eval("ID") %>&type=Dr&EMPID=<%# Eval("EMPID") %>' target="_blank">Dr</a>
                                    |
                                    <a href='SettlementFileDownload.aspx?batchid=<%# Eval("ID") %>&type=Cr&EMPID=<%# Eval("EMPID") %>' target="_blank">Cr</a>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%--<asp:TemplateField HeaderText="Download">
                                <ItemTemplate>                            
                                    <a href='SettlementFileDownload.aspx?batchid=<%# Eval("ID") %>'>DR</a>
                                    |
                                    <a href='SettlementFileDownload.aspx?batchid=<%# Eval("ID") %>'>CR</a>
                                </ItemTemplate>
                            </asp:TemplateField>  --%>      

                            

                            
                             

                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    
                    <asp:SqlDataSource ID="SqlDataSourceDataUploadLog" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="SELECT * FROM [settlementUploadlog] order by ID desc"></asp:SqlDataSource>
                </div>
            </div>
            <br />
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