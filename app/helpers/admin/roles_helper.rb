module Admin::RolesHelper
  def role_spinner(which)
    image('spinner.gif', 
            :class => 'busy', :id => "busy_#{which}", 
            :alt => "",  :title => "", 
            :style => 'display: none;')
  end
end