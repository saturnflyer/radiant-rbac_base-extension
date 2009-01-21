require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'index' do
  before do
    template.should_receive(:include_stylesheet).with('rbac/rbac')
    @users = []
    @users.stub!(:count)
    @roles = [mock_model(Role,:role_name => 'Test', :users => @users)]
    assigns[:roles] = @roles
  end
  it "should provide a link to edit each role" do
    render 'admin/roles/index'
    response.should have_tag('a[href=?]',/\/admin\/roles\/\d+/,'Test')
  end
end