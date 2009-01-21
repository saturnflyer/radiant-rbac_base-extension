class Admin::RolesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:users, :remove_user, :add_user]
  def index
    @roles = Role.find(:all)
  end
  
  def show
    @role = Role.find(params[:id])
  end
  
  def edit
    
  end
  def new
    
  end
  def update
    
  end
  
  def create
    @role = Role.new(params[:role])
    @role.save!
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid => invalid
    flash[:error] = invalid.record.errors.full_messages
    render :action => :index
  end
  
  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to admin_roles_path()
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'The specified Role could not be found.'
    redirect_to :action => :index
  end
  
  def users
    role = Role.find(params[:role_id])
    
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
    
    respond_to do |format|
      format.js { render :json => result.to_json }
    end
  end
  
  def add_user
    user_id = params[:id]
    role_id = params[:role_id]
    debugger
    role = Role.find(role_id)
    user = User.find(user_id)
    
    role.users << user
    if role.save
      render :json => {:status => "Ok", :role_id => role.id, :user_id => user.id }.to_json
    else
      render :json => {:status => "Error", :user_id => user.id }.to_json
    end
  end
  
  def remove_user 
    user_id = params[:id]
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
end