<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucRoleFunctionManagement.ascx.cs" Inherits="Controls_ucRoleFunctionManagement"%>

<style>
    .hiddencol { display: none; }

    .hideArrow {
        border-radius: 5px;
        -webkit-appearance: none;
    }
</style>

<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 rowGridData">

    <asp:Label ID="lbRole" runat="server" Text="Select role"></asp:Label>
    <asp:DropDownList ID="ddlRole" runat="server" OnLoad="ddlRoleLoad" AutoPostBack="true"
        onselectedindexchanged="ddlRole_SelectedIndexChanged"></asp:DropDownList>
    <br /> <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="table-striped table-bordered"
        >
              <RowStyle HorizontalAlign="Left"></RowStyle>
              <HeaderStyle HorizontalAlign="Center"/>
              <Columns>
                  <asp:TemplateField HeaderText="Id" ItemStyle-Width="5%">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%; text-align:center" Enabled="false" ID="Id_display" runat="server" Text='<%# Eval("Id_display") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                 <asp:TemplateField HeaderText="Active" ItemStyle-Width="5%">
                      <ItemTemplate>
                          <asp:CheckBox ID="chkActive" Enabled="false" style="width:100%; text-align:center" runat="server" 
                              Checked='<%#((bool)Eval("Active"))%>'/>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Role" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                      <ItemTemplate>
                          <asp:HiddenField Id="Role" runat="server" Value='<%# Eval("Role") %>'/>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Role" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                      <ItemTemplate>
                          <asp:HiddenField Id="FunctionId" runat="server" Value='<%# Eval("FunctionId") %>'/>
                      </ItemTemplate>
                  </asp:TemplateField>

                  <asp:TemplateField HeaderText="Name" ItemStyle-Width="30%" >
                      <ItemTemplate>
                          <asp:Textbox style="width:100%" Enabled="false" ID="StaffId" runat="server" Text='<%# Eval("FunctionName_vi") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <%--<asp:TemplateField HeaderText="English" ItemStyle-Width="30%">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%" Enabled="false" ID="ConsumerId" runat="server" Text='<%# Eval("FunctionName_en") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Local Language" ItemStyle-Width="30%">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%" Enabled="false" ID="Email" runat="server" Text='<%# Eval("FunctionName_other") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>--%>
                  
              </Columns>
          </asp:GridView>

    <div style="text-align:right">
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

