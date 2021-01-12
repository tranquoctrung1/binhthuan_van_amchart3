<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucSystemGeneral.ascx.cs" Inherits="Controls_ucSystemGeneral"%>

<style>
    .hiddencol { display: none; }
</style>

<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12 rowGridData">

    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="table-striped table-bordered">
              <RowStyle HorizontalAlign="Left"></RowStyle>
              <HeaderStyle HorizontalAlign="Center"/>
              <Columns>
                  <asp:TemplateField Visible="true" ItemStyle-CssClass="hiddencol"  HeaderStyle-CssClass="hiddencol">
                      <ItemTemplate>
                          <asp:HiddenField Id="Id" runat="server" Value='<%# Eval("Id") %>'/>                          
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="ID" ItemStyle-Width="20px" ItemStyle-CssClass="">
                      <ItemTemplate>
                          <asp:Textbox style="text-align: center" Enabled="false" ID="Id_display" runat="server" Text='<%# Eval("Id_display") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField>
                      <ItemTemplate>
                          <asp:HyperLink ID="Link" NavigateUrl='<%# Eval("NavigateURL") %>' runat="server" Text='<%# Eval("HyperLinkText") %>'></asp:HyperLink>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Content">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%" Enabled="false" ID="Val" runat="server" Text='<%# Eval("Val") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Description">
                      <ItemTemplate>
                          <asp:Textbox style="width:100%" Enabled="false" ID="Description" runat="server" Text='<%# Eval("Description") %>'></asp:Textbox>
                      </ItemTemplate>
                  </asp:TemplateField>
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

