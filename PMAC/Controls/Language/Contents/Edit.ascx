<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Edit.ascx.cs" Inherits="Controls_Language_ucContent_edit" %>


<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">

    
    <form>
      <%--<div class="form-group">
        <label>Control Id:</label>
        <asp:TextBox autocomplete="off" ID="txtControlId" CssClass="form-control" runat="server"></asp:TextBox>     
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  
                ControlToValidate="txtControlId" ErrorMessage="(*)" style="color:red" >
                </asp:RequiredFieldValidator>
      </div>--%>

      <div class="form-group">
        <label>Content:</label>
        <asp:TextBox ID="txtContent" CssClass="form-control" runat="server"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  
                ControlToValidate="txtContent" ErrorMessage="(*)" style="color:red" >
                </asp:RequiredFieldValidator>
      </div>

      <div class="form-group">
        <label>Noted:</label> <br />
        <asp:TextBox ID="txtNoted" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
      </div>

      
      
    </form>
    
    <div style="margin: 0 auto">
        <asp:Button ID="btnSave" CssClass="btn btn-success" runat="server" Text="Lưu thay đổi" OnClick="btnSave_Click" />
        <asp:Button ID="btnCancel" CssClass="btn btn-danger" CausesValidation="false" runat="server" Text="Hủy" OnClick="btnCancel_Click" />
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

