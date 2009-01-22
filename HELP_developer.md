With RBAC Base you can develop extensions that require their own roles.

## Developing for RBAC Base
To create an extension that uses it's own role, simply add fields to the
database:
  
    Role.create(:role_name => 'Finance', :allow_empty => false, :description => 'Only users in the Finance role may view financial data')
    
Then, your extension will automatically be able to use `current_user.finance?`
to return a boolean value based on the user being in that role.

By setting `allow_empty` to `false`, the role management interface will
not allow the last user to be removed from your role.

Once you have the role you need, you can even set the visibility of any
tabs that you create in your extension with your new role:

    admin.tabs.add "Finance", "/admin/finance", :after => "Pages", :visibility => [:finance]