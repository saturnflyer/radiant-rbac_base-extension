class RenameRoleDeveloperToDesigner < ActiveRecord::Migration
  def self.up
    if role = Role.find_by_role_name('Developer')
      role.update_attribute(:role_name, 'Designer')
    end
  end

  def self.down
    if role = Role.find_by_role_name('Designer')
      role.update_attribute(:role_name, 'Developer')
    end
  end
end
