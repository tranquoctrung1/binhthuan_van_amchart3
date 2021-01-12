<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucUserManagement.ascx.cs" Inherits="Controls_ucUserManagement"%>

<style>
    .hiddencol { display: none; }

    .hideArrow {
        border-radius: 5px;
        -webkit-appearance: none;
    }
</style>

<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 rowGridData">

    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="table-striped table-bordered"
        onrowdatabound="GridView1_RowDataBound">
              <RowStyle HorizontalAlign="Left"></RowStyle>
              <HeaderStyle HorizontalAlign="Center"/>
              <Columns>
                  <asp:TemplateField HeaderText="Id" ItemStyle-Width="5%">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%; text-align:center" Enabled="false" ID="Id_display" runat="server" Text='<%# Eval("Id_display") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="User name" ItemStyle-Width="15%">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%" Enabled="false" ID="Username" runat="server" Text='<%# Eval("Username") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Role" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                      <ItemTemplate>
                          <asp:HiddenField Id="Role" runat="server" Value='<%# Eval("Role") %>'/>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="StaffId" ItemStyle-Width="5%" >
                      <ItemTemplate>
                          <asp:Textbox style="width:100%" Enabled="false" ID="StaffId" runat="server" Text='<%# Eval("StaffId") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="ConsumerId" ItemStyle-Width="8%">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%" Enabled="false" ID="ConsumerId" runat="server" Text='<%# Eval("ConsumerId") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Email">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%" Enabled="false" ID="Email" runat="server" Text='<%# Eval("Email") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Role" ItemStyle-Width="10%">
                      <ItemTemplate>
                          <asp:DropDownList ID="ddlRole" runat="server" Enabled="false" >
                              
                          </asp:DropDownList>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Active" ItemStyle-Width="10%">
                      <ItemTemplate>
                          <asp:DropDownList ID="ddlActive" runat="server" Enabled="false" SelectedValue='<%# Eval("Active") %>'>
                              <asp:ListItem Value="True">True </asp:ListItem>
                              <asp:ListItem Value="False">False </asp:ListItem>
                          </asp:DropDownList>
                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
          </asp:GridView>

    <div style="text-align:right">
        <asp:Button ID="btnAdd" runat="server" Text="Thêm mới" OnClick="btnAdd_Click" />
        <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" />
        <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
    </div>


</div>

<telerik:RadNotification ID="ntf" runat="server" >
</telerik:RadNotification>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnOK">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<script type="text/javascript">
    
</script>

