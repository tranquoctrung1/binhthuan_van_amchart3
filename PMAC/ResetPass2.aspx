<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="ResetPass2.aspx.cs" Inherits="ResetPass2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="width:400px; margin:0 auto; padding-top: 150px">
    <h4 style="font-size: 20px; font-weight:bold;">RESET PASSWORD (2)</h4>
    <ul class="multiple_columns">
        <li class="text_grid_2_columns">
        </li>
        <li class="control_grid_2_columns">
              <asp:Label ID="lblNotice" Text="" ForeColor="Red" runat="server" ></asp:Label> 
        </li>

        <li class="text_grid_2_columns"><asp:Label ID="lbOldPassword" runat="server" Text="Mật khẩu mới"></asp:Label>
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadTextBox ID="txtNewPassword" runat="server" TextMode="Password" >
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtNewPassword" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
        </li>
        <li class="text_grid_2_columns"><asp:Label ID="lblEmail" runat="server" Text="Nhập lại Mật khẩu mới"></asp:Label>
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadTextBox ID="txtReNewPassword" runat="server" TextMode="Password" >
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtReNewPassword" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ErrorMessage="Mật khẩu xác nhận không khớp." ForeColor="Red" Font-Italic="True" 
                ControlToCompare="txtNewPassword" ControlToValidate="txtReNewPassword"></asp:CompareValidator>
          
        </li>
        <li class="text_grid_2_columns" style="padding-top:20px">
        </li>
        <li class="control_grid_2_columns" style="padding-top:20px">
            <telerik:RadButton ID="btnOK" runat="server" Text="Submit" 
                onclick="btnOK_Click">
            </telerik:RadButton>
        </li>
        <li class="text_grid_2_columns">
        </li>
        <li class="control_grid_2_columns">
        </li>
    </ul>

</div>

</asp:Content>

