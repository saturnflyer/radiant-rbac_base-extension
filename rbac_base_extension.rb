# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class RbacBaseExtension < Radiant::Extension
  version "1.2"
  description "Allows other extensions to control access managed by the roles created here. Administrators may add and remove users from roles as needed without regard to the standard Radiant roles."
  url "http://www.saturnflyer.com/"
  
  def activate
    Radiant::Config['roles.admin.sees_everything'] = 'true' unless Radiant::Config['roles.admin.sees_everything']
    if Role.table_exists?
      tab 'Settings' do
        add_item('Roles', '/admin/roles')
      end
      User.send :has_and_belongs_to_many, :roles
      User.send :include, RbacSupport
      admin.users.edit[:form].delete('edit_roles')
      UserActionObserver.instance.send :add_observer!, Role
    end
    Admin::UsersController.class_eval {
      helper Admin::AlterationsHelper
    }
  end
  
  def deactivate
  end
  
end
