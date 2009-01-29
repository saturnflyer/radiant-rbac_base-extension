require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::RolesController do
  before do
    @current_user = mock_model(User)
    controller.stub!(:current_user).and_return(mock_model(User))
    controller.current_user.stub!(:admin?).and_return(true)
  end
  describe 'GET index' do
    it "should assign all roles as @roles" do
      @roles = []
      Role.should_receive(:find).with(:all).and_return(@roles)
      get :index
      assigns[:roles].should == @roles
    end
  end
  describe 'GET show' do
    before do
      @role = mock_model(Role)
    end
    it "should find the role from the params" do
      Role.should_receive(:find).with('1').and_return(@role)
      get :show, :id => '1'
    end
    it "should assign the found role as @role" do
      Role.stub!(:find).and_return(@role)
      get :show, :id => '1'
      assigns[:role].should == @role
    end
  end
  describe 'POST create' do
    it "should save a role from the params" do
      @role = mock_model(Role)
      @role.should_receive(:save!).and_return(true)
      Role.should_receive(:new).and_return(@role)
      post :create
    end
    it "should redirect to the roles index" do
      post :create
      response.should redirect_to(admin_roles_path)
    end
    describe "with invalid params" do
      before do
        @role = mock_model(Role)
        @errors = []
        @errors.stub!(:full_messages).and_return(['bad', 'error'])
        @role.stub!(:errors).and_return(@errors)
        @role.should_receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(@role))
        Role.stub!(:new).and_return(@role)
      end
      it "should render the index page" do
        post :create
        response.should render_template('index')
      end
      it "should set the flash error message to the record's full errors" do
        @errors.should_receive(:full_messages).and_return('bad, error')
        post :create
        flash[:error].should == 'bad, error'
      end
    end
  end  
  describe 'DELETE destroy' do
    before do
      @role = mock_model(Role, :role_name => 'Test')
      @role.stub!(:destroy)
      Role.stub!(:find).and_return(@role)
    end
    it "should find the role from the params" do
      Role.should_receive(:find).with('1').and_return(@role)
      delete :destroy, :id => '1'
    end
    it "should destroy the found role" do
      @role.should_receive(:destroy).and_return(true)
      delete :destroy
    end
    it "should redirect to the roles index" do
      delete :destroy
      response.should redirect_to(admin_roles_path)
    end
    describe "with invalid params" do
      it "should redirect to the roles index" do
        Role.should_receive(:find).with('1').and_raise(ActiveRecord::RecordNotFound.new(@role))
        delete :destroy, :id => '1'
        response.should redirect_to(admin_roles_path)
      end
    end
    describe "for a standard Radiant role" do
      before do
        @role = mock_model(Role, :role_name => Role::RADIANT_STANDARDS.first)
        Role.stub!(:find).and_return(@role)
      end
      it "should redirect to the roles index" do
        delete :destroy, :id => '1'
        response.should redirect_to(admin_roles_path)
      end
      it "should not delete the role" do
        @role.should_not_receive(:destroy)
        delete :destroy, :id => '1'
      end
    end
  end
  describe 'DELETE remove_user' do
    before do
      @user = mock_model(User)
      @role = mock_model(Role)
      @role.stub!(:remove_user)
      Role.stub!(:find).and_return(@role)
      User.stub!(:find).and_return(@user)
      
    end
    it "should find the role from the params" do
      Role.should_receive(:find).with('1').and_return(@role)
      delete :remove_user, :role_id => '1', :id => '2'
    end
    it "should find the user from the params" do
      User.should_receive(:find).with('2').and_return(@user)
      delete :remove_user, :role_id => '1', :id => '2'
    end
    it "should remove the user" do
      @role.should_receive(:remove_user).and_return(true)
      delete :remove_user, :role_id => '1', :id => '2'
    end
  end
  describe 'PUT update' do
    before do
      @role = mock_model(Role)
      @role.stub!(:update_attributes).and_return(true)
      Role.stub!(:find).and_return(@role)
    end
    it "should find the role from the params" do
      Role.should_receive(:find).with('1').and_return(@role)
      put :update, :id => '1'
    end
    it "should update the role's attributes from the params" do
      role_params = {'this' => 'that'}
      @role.should_receive(:update_attributes).with(role_params).and_return(true)
      put :update, :id => '1', :role => role_params
    end
    it "should redirect to the role's page" do
      put :update, :id => '1'
      response.should redirect_to(admin_role_path(@role))
    end
  end
end