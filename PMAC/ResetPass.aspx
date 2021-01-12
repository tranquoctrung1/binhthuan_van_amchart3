<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="ResetPass.aspx.cs" Inherits="ResetPass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div style="width:350px; margin:0 auto; padding-top: 150px">
    <h4 style="font-size: 20px; font-weight:bold;">RESET PASSWORD</h4>
    <ul class="multiple_columns">
        <li class="text_grid_2_columns">
        </li>
        <li class="control_grid_2_columns">
              <asp:Label ID="lblNotice" Text="" ForeColor="Red" runat="server" ></asp:Label> 
        </li>

        <li class="text_grid_2_columns"><asp:Label ID="lbOldPassword" runat="server" Text="UserName"></asp:Label>
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadTextBox ID="txtUserName" runat="server" >
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtUserName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
        </li>
        <li class="text_grid_2_columns"><asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadTextBox ID="txtEmail" runat="server" >
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtEmail" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" 
                ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail"
                ErrorMessage="Invalid Email Format" ForeColor="Red"></asp:RegularExpressionValidator>
          
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

