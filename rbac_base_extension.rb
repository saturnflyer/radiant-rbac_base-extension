# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class RbacBaseExtension < Radiant::Extension
  version "1.1"
  description "Allows other extensions to control access managed by the roles created here. Administrators may add and remove users from roles as needed without regard to the standard Radiant roles."
  url "http://www.saturnflyer.com/"
  
  define_routes do |map|
    map.rbac 'admin/rbac', :controller => 'admin/role_manager', :action => 'index'
    map.role_details 'admin/rbac/details', :controller => 'admin/role_manager', :action => 'details'
    map.connect 'admin/rbac/:action', :controller => 'admin/role_manager'
    map.connect 'admin/rbac/:action/:id', :controller => 'admin/role_manager'
  end
  
  def activate
    admin.tabs.add "Roles", "/admin/rbac", :after => "Layouts", :visibility => [:admin]
    User.send :has_and_belongs_to_many, :roles
    User.send :include, RbacSupport
  end
  
  def deactivate
    admin.tabs.remove "Roles"
  end
  
end