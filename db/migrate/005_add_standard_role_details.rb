class AddStandardRoleDetails < ActiveRecord::Migration
  def self.up
    Role.find(:all).each do |role|
      if role.name == 'Admin'
        say("Adding Admin description.")
        role.update_attributes({:allow_empty => false,
          :description => %{Users in the Admin role, by default, have access to all features of the system.}})
      elsif role.name == 'Designer'
        say("Adding Designer description.")
        role.update_attributes({:allow_empty => true,
          :description => %{Users in the Designer role, by default, have access to all features of the system except user management.}})
      else
        role.update_attribute(:allow_empty, true)
      end
    end
  end
  def self.down
    # no need
  end
end