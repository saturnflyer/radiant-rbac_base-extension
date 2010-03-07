class Admin::RolesController < ApplicationController
  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove_user, :add_user, :users, :destroy,
    :when => :admin,
    :denied_url => { :controller => 'pages', :action => 'index' },
    :denied_message => 'You must have administrative privileges to edit Roles.'
  skip_before_filter :verify_authenticity_token, :only => [:users, :remove_user, :add_user]
  def index
    @roles = Role.find(:all)
    @role = Role.new
  end
  
  def show
    @role = Role.find(params[:id])
  end
  
  def edit
    
  end
  def new
    
  end
  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      redirect_to admin_role_path(@role)
    else
      render :action => 'show'
    end
  end
  
  def create
    @role = Role.new(params[:role])
    @role.save!
    redirect_to admin_roles_path
  rescue ActiveRecord::RecordInvalid => invalid
    flash[:error] = invalid.record.errors.full_messages
    render :action => :index
  end
  
  def destroy
    @role = Role.find(params[:id])
    @role.destroy unless Role::RADIANT_STANDARDS.include?(@role.role_name)
    redirect_to admin_roles_path()
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'The specified Role could not be found.'
    redirect_to :action => :index
  end
  
  def users
    role = Role.find(params[:role_id])
    
    available_users = User.find(:all, :conditions => ['id NOT IN (SELECT user_id FROM roles_users WHERE role_id = ?)', role.id])
    taken_users = role.users
    
    result = {:available => [], :taken => []}
    
    available_users.each do | usr |
      result[:available] << [usr.id, usr.name]
    end
    
    taken_users.each do | usr |
      result[:taken] << [usr.id, usr.name]
    end
    
    respond_to do |format|
      format.js { render :json => result.to_json }
    end
  end
  
  def add_user
    role = Role.find(params[:role_id])
    user = User.find(params[:id])
    
    if role.users << user
      render :json => {:status => "Ok", :role_id => role.id, :user_id => user.id }.to_json
    else
      render :json => {:status => "Error", :user_id => user.id }.to_json
    end
  end
  
  def remove_user 
    role = Role.find(params[:role_id])
    user = User.find(params[:id])
    
    if role.remove_user(user)
      render :json => {:status => "Ok", :role_id => role.id, :user_id => user.id }.to_json
    else
      render :json => {:status => "Error", :user_id => user.id }.to_json
    end
  end
end