ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :roles#, :member => {:users => :get, :remove_user => :delete, :add_user => :post}
    admin.role_user '/roles/:role_id/users/:id', :controller => 'roles', :action => 'remove_user', :conditions => {:method => :delete}
    admin.role_user '/roles/:role_id/users/:id', :controller => 'roles', :action => 'add_user', :conditions => {:method => :post}
    admin.role_users '/roles/:role_id/users', :controller => 'roles', :action => 'users', :conditions => {:method => :get}
  end
  #legacy paths
  map.rbac 'admin/rbac', :controller => 'admin/roles', :action => 'index'
  map.role_details 'admin/roles/:id', :controller => 'admin/roles', :action => 'show'
end