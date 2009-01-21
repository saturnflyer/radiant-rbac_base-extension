class AddStandardRoleDetails < ActiveRecord::Migration
  def self.up
    Role.find(:all).each do |role|
      role.update_attribute(:allow_empty, true)
    end
    Role.find_by_role_name('Admin').update_attributes({:allow_empty => false,
      :description => %{Users in the Admin role, by default, have access to all features of the system.}})
    Role.find_by_role_name('Developer').update_attributes({
      :description => %{Users in the Admin role, by default, have access to all features of the system.}})
  end
  def self.down
    # no need
  end
end