<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucRoleManagement.ascx.cs" Inherits="Controls_ucRoleManagement"%>

<style>
    .hiddencol { display: none; }

    .hideArrow {
        border-radius: 5px;
        -webkit-appearance: none;
    }
</style>

<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 rowGridData">

    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="table-striped table-bordered">
              <RowStyle HorizontalAlign="Left"></RowStyle>
              <HeaderStyle HorizontalAlign="Center"/>
              <Columns>
                  <asp:TemplateField HeaderText="Id" ItemStyle-Width="5%">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%; text-align:center" Enabled="false" ID="Id_display" runat="server" Text='<%# Eval("Id_display") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Role" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                      <ItemTemplate>
                          <asp:HiddenField Id="Role" runat="server" Value='<%# Eval("Role") %>'/>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Description" ItemStyle-Width="15%">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%" Enabled="false" ID="Description" runat="server" Text='<%# Eval("Description") %>'></asp:Textbox>
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

