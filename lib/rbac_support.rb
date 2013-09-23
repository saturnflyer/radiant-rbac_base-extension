module RbacSupport
  def self.admin_is_omniscient?
    @admin_is_omniscient ||= (Radiant::Config['roles.admin.sees_everything'] == 'true')
  end
  
  all_roles = Role.find(:all)
  
  all_roles.each do | possible_role |
    define_method("#{possible_role.role_name.underscore}?") do 
      if @my_roles == nil
        @my_roles = Hash.new
        roles.each do | role |
          @my_roles["#{role.role_name.underscore}"] = true
        end
      end
      if RbacSupport.admin_is_omniscient? && possible_role.role_name.downcase != 'admin'
        return true if admin?
      end
      @my_roles["#{possible_role.role_name.underscore}"] #|| self[:admin] == true
    end
  end
end
