<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ATM_Cashload_Batch.aspx.cs" Inherits="ATM_Cashload_Batch" %>

<%@ Register Src="TrustControl.ascx" TagName="TrustControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="EMP.ascx" TagName="EMP" TagPrefix="uc2" %>
<%@ Register Src="Branch.ascx" TagName="Branch" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <uc1:TrustControl ID="TrustControl1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

        <table>
                <tr>
                    <td>
                        <table class="Panel1 ui-corner-all">
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="True" CausesValidation="True"
                                        onfocus="this.select()" Watermark="enter information to filter" Width="150px"></asp:TextBox>
                                </td>
                                                                
                                <td>
                                    <asp:Button ID="cmdSearch" runat="server" Text="Filter" Width="80px" Style="font-weight: 700" />
                                </td>
                            </tr>
                        </table>
                    </td>                    
                </tr>
            </table>


            <asp:GridView ID="GridViewAtmValue" runat="server" AutoGenerateColumns="False" BackColor="White"
                DataSourceID="SqlDataSource1" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px"
                DataKeyNames="ID" CellPadding="4" CssClass="Grid" Style="font-size: small" ForeColor="Black"
                AllowSorting="True" PageSize="15" AllowPaging="True" GridLines="Vertical" PagerSettings-Position="TopAndBottom"
                PagerSettings-PageButtonCount="30" PagerSettings-Mode="NumericFirstLast" 
                OnRowUpdated="GridViewAtmValue_RowUpdated" 
                onrowcommand="GridViewAtmValue_RowCommand">
                <Columns>
                    <asp:BoundField DataField="AtmID" HeaderText="Atm ID" SortExpression="AtmID" ItemStyle-HorizontalAlign="Left"
                        ReadOnly="true">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Name" HeaderText="Atm Name" SortExpression="Name" ItemStyle-HorizontalAlign="Left"
                        ReadOnly="true">
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TotalCaset_1000" HeaderText="No. of Casset<br>Note_1000"
                        SortExpression="TotalCaset_1000" HtmlEncode="false" ItemStyle-HorizontalAlign="Center"
                        ReadOnly="true">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TotalCaset_500" HeaderText="No. of Casset<br>Note_500"
                        SortExpression="TotalCaset_500" HtmlEncode="false" ItemStyle-HorizontalAlign="Center"
                        ReadOnly="true">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TotalNoteCount_1000" HeaderText="Available<br>Note_1000"
                        SortExpression="TotalNoteCount_1000" HtmlEncode="false" ReadOnly="true" />
                    <asp:BoundField DataField="TotalNoteCount_500" HeaderText="Available<br>Note_500"
                        SortExpression="TotalNoteCount_500" HtmlEncode="false" ReadOnly="true" />

                     <%--<asp:BoundField DataField="AvailableAmount" HeaderText="Available<br>Amount"
                        SortExpression="AvailableAmount" HtmlEncode="false" ReadOnly="true" DataFormatString="{0:N0}" />--%>
                        

                     <asp:TemplateField HeaderText="Available<br>Amount" SortExpression="AvailableAmount">
                        <ItemTemplate>                            
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("AvailableAmount"))%>
                        </ItemTemplate>                        
                    </asp:TemplateField>


                    
                    <asp:BoundField DataField="TotalContent_1000" HeaderText="Count<br>Total_1000" HtmlEncode="false"
                        SortExpression="TotalContent_1000" Visible="true" ReadOnly="true" />
                    <asp:BoundField DataField="TotalContent_500" HeaderText="Count<br>Total_500" HtmlEncode="false"
                        SortExpression="TotalContent_500" Visible="true" ReadOnly="true" />
                    <asp:TemplateField HeaderText="Required&lt;br&gt;Note_1000">
                        <ItemTemplate>
                            <%# Eval("TotalReq_1000") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTotalReq_1000" runat="server" Text='<%# Bind("TotalReq_1000") %>'
                                Width="50px" CssClass="right txtTotalReq_1000" MaxLength="6"></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtTotalReq_1000"
                                TargetControlID="txtTotalReq_1000" FilterType="Numbers">
                            </asp:FilteredTextBoxExtender>
                        </EditItemTemplate>
                        <ItemStyle Font-Bold="True" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Required&lt;br&gt;Note_500">
                        <ItemTemplate>
                            <%# Eval("TotalReq_500") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTotalReq_500" runat="server" Text='<%# Bind("TotalReq_500") %>'
                                Width="50px" CssClass="right txtTotalReq_500" MaxLength="6"></asp:TextBox>
                            <asp:FilteredTextBoxExtender runat="server" ID="FilteredTextBoxExtendertxtTotalReq_500"
                                TargetControlID="txtTotalReq_500" FilterType="Numbers">
                            </asp:FilteredTextBoxExtender>
                        </EditItemTemplate>
                        <ItemStyle Font-Bold="True" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Req&lt;br&gt;Amount" SortExpression="TotalReqAmount">
                        <ItemTemplate>
                            <%--<%# Eval("TotalReqAmount", "{0:N0}") %>--%>
                            <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("TotalReqAmount"))%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Label ID="lblTotalReqAmount" CssClass="lblTotalReqAmount" runat="server" Text='<%# Eval("TotalReqAmount", "{0:N0}") %>'></asp:Label>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="InstructToBranch" SortExpression="InstructToBranch"
                        HeaderText="Instruct<br>to Branch" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="lnkEdit" ToolTip="Edit" Visible='<%# (bool)Eval("Editable") %>'
                                CommandName="Edit" CommandArgument='<%# Eval("ID") %>'><img src="Images/edit-label.png" width="20" height="20" border="0" /></asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Button ID="lnkUpdate" CommandName="Update" runat="server" Text="Update" />
                            <asp:ConfirmButtonExtender runat="server" ID="con_Update" TargetControlID="lnkUpdate"
                                ConfirmText="Do you want to Update?">
                            </asp:ConfirmButtonExtender>
                            <asp:Button ID="lnkCancel" CommandName="Cancel" runat="server" CausesValidation="false"
                                Text="Cancel" />
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:CheckBoxField DataField="InstructionGiven" SortExpression="InstructionGiven"
                        HeaderText="Instruction<br>Given" ItemStyle-HorizontalAlign="Center" ReadOnly="true">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:CheckBoxField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkInstruct" Visible='<%# (bool)Eval("InstructBtnVisible") %>' CommandName="Instruct"
                                runat="server" Text="Instruct" CommandArgument='<%# Eval("AtmID") %>'></asp:LinkButton>
                            <asp:ConfirmButtonExtender runat="server" ID="con_lnkInstruct" TargetControlID="lnkInstruct"
                                ConfirmText="Do you want to send Cash Loading Instruction?">
                            </asp:ConfirmButtonExtender>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <PagerSettings PageButtonCount="30" Position="TopAndBottom" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" CssClass="PagerStyle" />
                <RowStyle BackColor="#F7F7DE" VerticalAlign="Middle" HorizontalAlign="Right" />
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
                <EditRowStyle BackColor="#FFA200" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                SelectCommand="s_ATM_Value_Batch" SelectCommandType="StoredProcedure" OnSelected="SqlDataSource1_Selected"
                UpdateCommand="s_ATM_Value_Update" UpdateCommandType="StoredProcedure" OnUpdated="SqlDataSource1_Updated">
                <SelectParameters>
                    <asp:QueryStringParameter Name="batchId" QueryStringField="batchId" Type="Int32" />
                    <asp:ControlParameter ControlID="txtSearch" Name="Filter" PropertyName="Text" Type="String"
                        DefaultValue="*" />                        
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ID" Type="Int64" />
                    <asp:Parameter Name="TotalReq_500" Type="Int32" />
                    <asp:Parameter Name="TotalReq_1000" Type="Int32" />
                    <asp:Parameter Name="InstructToBranch" Type="Boolean" />
                    <asp:SessionParameter Name="Updateby" Type="String" SessionField="EMPID" />
                    <asp:Parameter Direction="InputOutput" Name="Done" Type="Boolean" DefaultValue="false" />
                    <asp:Parameter Direction="InputOutput" Name="Msg" Type="String" Size="255" DefaultValue=" " />
                </UpdateParameters>
            </asp:SqlDataSource>
            <table>
                <tr>
                    <td>
                        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" BackColor="White"
                            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" CssClass="Grid"
                            DataSourceID="SqlDataSource2" ForeColor="Black" GridLines="Vertical">
                            <AlternatingRowStyle BackColor="White" />
                            <EditRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <Fields>
                                <asp:BoundField DataField="TotalRows" HeaderText="Total Rows" ReadOnly="True" SortExpression="TotalRows" />
                                <asp:BoundField DataField="InstructToBranch" HeaderText="Instruct to Branch" ReadOnly="True"
                                    SortExpression="InstructToBranch" />
                                <%--<asp:BoundField DataField="TotalReqAmount" HeaderText="Total Amount" ReadOnly="True"
                                    SortExpression="TotalReqAmount" DataFormatString="{0:N2}" />--%>

                                <asp:TemplateField HeaderText="Total Amount" SortExpression="TotalReqAmount">
                                    <ItemTemplate>                            
                                        <%# string.Format(TrustControl1.Bangla, "{0:N0}", Eval("TotalReqAmount"))%>
                                    </ItemTemplate>                        
                                </asp:TemplateField>

                                <asp:BoundField DataField="TotalReqAmountInWard" HeaderText="" ReadOnly="True" SortExpression="TotalReqAmountInWard" />
                            </Fields>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CardDataConnectionString %>"
                            SelectCommand="s_ATM_Value_Batch_Summary" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="batchId" QueryStringField="batchid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td>
                        <div class="Panel1" style="display: inline-block">
                            <asp:TextBox ID="txtInstructionComment" Width="400px" placeholder="Comment/Instruction"
                                runat="server"></asp:TextBox>
                            <br />
                            <asp:Button ID="cmdInstruction" runat="server" Height="35px" Text="Instruct to Branches"
                                OnClick="cmdInstruction_Click" />
                            <asp:ConfirmButtonExtender runat="server" ID="con1" TargetControlID="cmdInstruction"
                                ConfirmText="Do you want to send Cash Loading Instruction?">
                            </asp:ConfirmButtonExtender>
                        </div>
                    </td>
                </tr>
            </table>
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
