With RBAC Base you can develop extensions that require their own roles.

## Developing for RBAC Base
To create an extension that uses it's own role, simply add fields to the
database:
  
    Role.create(:role_name => 'Finance', :allow_empty => false, :description => 'Only users in the Finance role may view financial data')
    
Then, your extension will automatically be able to use `current_user.finance?`
to return a boolean value based on the user being in that role.

By setting `allow_empty` to `false`, the role management interface will
not allow the last user to be removed from your role.

Once you have the role you need, you can set the visibility of any
controllers that you create in your extension with your new role:

      only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
        :when => [:designer, :admin],
        :denied_url => { :controller => 'admin/pages', :action => 'index' },
        :denied_message => 'You must have designer privileges to perform this action.'