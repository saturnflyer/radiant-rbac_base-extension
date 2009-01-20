class Admin::RoleManagerController < ApplicationController
  # Remove this line if your controller should only be accessible to users
  # that are logged in:
  # no_login_required
  skip_before_filter :verify_authenticity_token
  
  before_filter :check_admin_role
  before_filter :load_roles, :only => [:index, :new, :create]
  
  def index
    @role = Role.new
  end
  
  def new
    if request.post? 
      @role = Role.new(params[:role])
      if @role.save
        redirect_to :action => :details, :id => @role.id
      end
    else
      @role = Role.new
    end
  end
  
  def create
    @role = Role.new(params[:role])
    @role.save
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid => invalid
    flash[:error] = invalid.record.errors
    render :index
  end
  
  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to rbac_path()
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'The specified Role could not be found.'
    redirect_to :action => :index
  end

  def assign
    if request.post? and request.xhr?
      user = User.find(params[:user_id])
      role = Role.find(params[:role_id])
      
    else
      @users = User.find(:all)
      @roles = Role.find(:all)
    end
  end

  def details
    @role = Role.find(params[:id])
  end
  
  def add_user_to_role
    user_id = params[:user_id]
    role_id = params[:role_id]
    
    role = Role.find(role_id)
    user = User.find(user_id)
    
    role.users << user
    if role.save
      render :json => {:status => "Ok", :role_id => role.id, :user_id => user.id }.to_json
    else
      render :json => {:status => "Error", :user_id => user.id }.to_json
    end
  end
  
  def remove_user_from_role 
    user_id = params[:user_id]
    role_id = params[:role_id]
    
    role = Role.find(role_id)
    user = User.find(user_id)
    
    role.users.delete(user)
    if role.save
      render :json => {:status => "Ok", :role_id => role.id, :user_id => user.id }.to_json
    else
      render :json => {:status => "Error", :user_id => user.id }.to_json
    end
  end
  
  def get_role_users
    if request.xhr?
      role = Role.find(params[:id])
      
      available_users = User.find(:all, :conditions => ['id NOT IN (SELECT user_id FROM roles_users WHERE role_id = ?)', role.id])
      taken_users = role.users
      
      result = Hash.new
      result[:available] = Array.new 
      result[:taken] = Array.new 
      
      available_users.each do | usr |
        result[:available] << [usr.id, usr.name]
      end
      
      taken_users.each do | usr |
        result[:taken] << [usr.id, usr.name]
      end
      
      render :json => result.to_json
    end
  end
  
  private
  
  def check_admin_role
    redirect_to admin_path() unless current_user.admin?
  end
  
  def load_roles
    @roles = Role.find(:all)
  end
end
