<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Edit.ascx.cs" Inherits="Controls_Language_ucFunction_edit" %>


<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">

    
    <form>
      <div class="form-group">
        <label>Form Name:</label>
        <asp:TextBox autocomplete="off" ID="txtFormName" CssClass="form-control" runat="server"></asp:TextBox>           
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  
                ControlToValidate="txtFormName" ErrorMessage="(*)" style="color:red" >
                </asp:RequiredFieldValidator>
      </div>      

      <div class="form-group">
        <label>Status:</label> <br />
        <asp:DropDownList ID="txtStatus" runat="server">
                                    <asp:ListItem Text="Ẩn" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Hiển Thị" Value="1"></asp:ListItem>
                                </asp:DropDownList>
      </div>

       <div class="form-group">
        <label>URL:</label>
        <asp:TextBox ID="txtURL" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
      </div>

      
      
    </form>
    
    <div style="margin: 0 auto">
        <asp:Button ID="btnSave" CssClass="btn btn-success" runat="server" Text="Lưu thay đổi" OnClick="btnSave_Click" />
        <asp:Button ID="btnCancel" CausesValidation="false" CssClass="btn btn-danger" runat="server" Text="Hủy" OnClick="btnCancel_Click" />
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

