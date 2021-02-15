<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SMS_Inbox.aspx.cs" Inherits="SMS_Inbox" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        function RefreshSMSCount() {
            var obj = document.getElementById("ctl00_ContentPlaceHolder2_lblSMSCount");
            var sms = document.getElementById("ctl00_ContentPlaceHolder2_txtSMS");
            //int i = sms.length;
            //obj.innerHTML = sms;
            textCounter(sms, obj, 160);
        }
        function textCounter(field, cntfield, maxlimit) {
            cntfield.innerHTML = maxlimit - field.value.length;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    SMS Inbox of Card Activation Request
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick">
            </asp:Timer>
            <table class="Panel1 ui-corner-all">
                <tr>
                    <td align="left" >
                        Status</td><td>
                        <asp:DropDownList ID="cboStatus" runat="server" AutoPostBack="True" OnSelectedIndexChanged="cboStatus_SelectedIndexChanged">
                            <asp:ListItem Value="NEW">NEW</asp:ListItem>                            
                        </asp:DropDownList>
                    </td>
                </tr>
                </table>
                <br />
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                            PagerSettings-Mode="NumericFirstLast" PageSize="10" PagerSettings-Position="TopAndBottom"
                            AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None"
                            BorderWidth="1px" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource1"
                            ForeColor="Black" CssClass="Grid" GridLines="Both" Style="font-size: small" OnRowCommand="GridView1_RowCommand">
                            <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
                            <RowStyle BackColor="#F7F7DE" VerticalAlign="Top" />
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                    SortExpression="ID" ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Mobile" HeaderText="From Mobile" SortExpression="Mobile"
                                    ItemStyle-Wrap="false">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Msg" HeaderText="SMS Message" SortExpression="Msg" />                                
                                <asp:TemplateField HeaderText="Received On" SortExpression="DT" ItemStyle-Wrap="false"
                                    ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <span title='<%# Eval("DT")%>'>
                                            <%# TrustControl1.ToRelativeDate(Eval("DT")) %></span></ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="IP" HeaderText="IP/PC" SortExpression="IP" ItemStyle-HorizontalAlign="Center"
                                    ItemStyle-Wrap="false">
                                    <ItemStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ModemID" HeaderText="Modem" SortExpression="ModemID" ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Action" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Button runat="server" ID="cmdActive" Text="Activated" Width="100px" ToolTip="Mark as activated and send confirmation sms"
                                            CommandName="ACTION" CommandArgument=' <%# "activated###" + Eval("ID") + "###" + Eval("Msg") %>' />
                                        <asp:Button runat="server" ID="cmdInvalidInfo" Text="Invalid Info" Width="100px"
                                            ToolTip="Mark as invalid and send sms" CommandName="ACTION" CommandArgument=' <%# "invalid###" + Eval("ID") + "###" + Eval("Msg") %>' />
                                        <asp:Button runat="server" ID="cmdInvalidSmsFormat" Text="Reject" Width="100px"
                                            ToolTip="Mark as wrong and send sms" CommandName="ACTION" CommandArgument=' <%# "wrong###" + Eval("ID") + "###" + Eval("Msg") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Wrap="False" />
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle1" />
                            <EmptyDataTemplate>
                                No SMS found, Thank you.
                            </EmptyDataTemplate>
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                   
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="sp_SMS_Inbox_Card_Activation" SelectCommandType="StoredProcedure"
                OnSelected="SqlDataSource1_Selected">
                <SelectParameters>
                    <asp:ControlParameter Name="Status" ControlID="cboStatus" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label>
            <span style="visibility: hidden">
                <asp:Button ID="cmdShow" runat="server" CausesValidation="False" />
                <asp:Button ID="cmdShowUpload" runat="server" CausesValidation="False" />
            </span>
            <asp:ModalPopupExtender PopupControlID="ModalPanel" CancelControlID="ModalClose"
                ID="modal" runat="server" Enabled="True" TargetControlID="cmdShow" PopupDragHandleControlID="ModalTitleBar"
                BackgroundCssClass="ModalPopupBG" RepositionMode="RepositionOnWindowResize">
            </asp:ModalPopupExtender>
            <asp:Panel runat="server" ID="ModalPanel" Width="310px" BackImageUrl="~/Images/cff.gif">
                <div style="padding: background-color:Green; padding: 5px">
                    <asp:Panel runat="server" ID="ModalTitleBar" CssClass="MoveIcon" BackColor="#35D5E3"
                        HorizontalAlign="Center" Width="300px">
                        <table width="300px" style="background-image: url('Images/bg1.gif')">
                            <tr>
                                <td align="left" style="color: White; font-size: large; font-weight: bold;">
                                    <asp:Label ID="ModalTitle" runat="server" Text="Reply SMS"></asp:Label>
                                </td>
                                <td align="right">
                                    <a href="#" style="cursor: default">
                                        <asp:Image ID="ModalClose" runat="server" ImageUrl="~/Images/close.gif" ToolTip="Close" />
                                    </a>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:TextBox ID="txtSMS" Font-Bold="False" runat="server" Width="260px" TextMode="MultiLine"
                            Height="130px" Font-Names="Verdana" Font-Size="Small" onchange="javascript:RefreshSMSCount()"
                            onkeydown="javascript:RefreshSMSCount()" onkeyup="javascript:RefreshSMSCount()"
                            MaxLength="160"></asp:TextBox>
                        <table width="100%">
                            <tr>
                                <td align="left" style="padding-left: 20px">
                                    <asp:Button ID="cmdSend" runat="server" Text="Send" Width="100px" OnClick="cmdSend_Click" />
                                </td>
                                <td align="right" style="padding-right: 20px; font-size: small">
                                    <asp:Label ID="lblSMSCount" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:HiddenField ID="hidID" runat="server" />
                    <asp:HiddenField ID="hidTyle" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSourceSMS_Out" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                        SelectCommand="sp_SMS_Process" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hidID" Name="INBOXID" PropertyName="Value" Type="Int32" />
                            <asp:ControlParameter ControlID="txtSMS" PropertyName="Text" DefaultValue=" " Name="Msg"
                                Type="String" Size="255" />
                            <asp:Parameter Name="APPID" Type="Int32" DefaultValue="19" />
                            <asp:ControlParameter ControlID="hidTyle" Name="Status" PropertyName="Value" Type="String" />
                            <asp:Parameter Direction="InputOutput" Name="ID" Type="Int32" DefaultValue="0" />
                            <asp:SessionParameter Name="EMPID" SessionField="EMPID" Type="String" />
                            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>
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