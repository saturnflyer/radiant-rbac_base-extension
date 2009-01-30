class SetupStandardRoles < ActiveRecord::Migration
  def self.up
    User.send :has_and_belongs_to_many, :roles
    self.setup_admins
    self.setup_developers
  end
  def self.down
    say("Removing all Roles.")
    Role.find(:all, :conditions => ["role_name = 'Admin' OR role_name = 'Developer'"]).map(&:destroy)
  end
  
  def self.setup_admins
    admin_users = User.find_all_by_admin(true)
    admin_role = Role.create!(:role_name => 'Admin')
    admin_users.each do |user|
      say("Adding #{user.login} to the #{admin_role.role_name} role.")
      user.roles << admin_role
    end
  end
  
  def self.setup_developers
    developer_users = User.find_all_by_developer(true)
    developer_role = Role.create!(:role_name => 'Developer')
    developer_users.each do |user|
      say("Adding #{user.login} to the #{developer_role.role_name} role.")
      user.roles << developer_users
    end
  end
end