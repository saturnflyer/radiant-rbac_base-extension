module Admin::AlterationsHelper
  def roles(user)
    list = []
    user.roles.each do |role|
      list << role.role_name
    end
    list.join(', ')
  end
end
