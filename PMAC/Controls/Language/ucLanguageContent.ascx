<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucLanguageContent.ascx.cs" Inherits="Controls_ucLanguageContent"%>

<style>
    .hiddencol { display: none; }
</style>

<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">

    <div class="tab-content" id="ChangeLanguage">

      <div class="tab-pane fade show active rowGridData" id="home" role="tabpanel" aria-labelledby="home-tab" style="padding: inherit; margin:10px auto" >
          
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="table-striped table-bordered">
              <RowStyle HorizontalAlign="Left"></RowStyle>
              <HeaderStyle HorizontalAlign="Center" />
              <Columns>
                  <asp:TemplateField Visible="true" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                      <ItemTemplate>
                          <asp:HiddenField ID="Id_vi" runat="server" Value='<%# Eval("Id_vi") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField Visible="true" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                      <ItemTemplate>
                          <asp:HiddenField ID="Id_en" runat="server" Value='<%# Eval("Id_en") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField Visible="true" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                      <ItemTemplate>
                          <asp:HiddenField ID="Id_other" runat="server" Value='<%# Eval("Id_other") %>' />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="STT" ItemStyle-Width="20px" ItemStyle-CssClass="">
                      <ItemTemplate>
                          <asp:TextBox Style="text-align: center" Enabled="false" ID="Id" runat="server" Text='<%# Eval("Id_display") %>'></asp:TextBox>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Tiếng Việt">
                      <ItemTemplate>
                          <asp:TextBox Enabled="false" ID="Content_vi" runat="server" Text='<%# Eval("Content_vi") %>'></asp:TextBox>
                          <asp:Image ID="Image1" runat="server" />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="English">
                      <ItemTemplate>
                          <asp:TextBox Enabled="false" ID="Content_en" runat="server" Text='<%# Eval("Content_en") %>'></asp:TextBox>
                          <asp:Image ID="Image2" runat="server" />
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Local Language">
                      <ItemTemplate>
                          <asp:TextBox Enabled="false" ID="Content_other" runat="server" Text='<%# Eval("Content_other") %>'></asp:TextBox>
                          <asp:Image ID="Image3" runat="server" />
                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
          </asp:GridView>
                           
          <div style="text-align: right">
              <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" />
              <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
          </div>
      </div>
      

        
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

