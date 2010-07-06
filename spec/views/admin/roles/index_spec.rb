require File.dirname(__FILE__) + '/../../../spec_helper'

describe 'index' do
  let(:users){[]}
  let(:role){mock_model(Role,:role_name => 'Test', :description => 'The test role.', :users => users, :standard? => false)}
  let(:roles){[role]}
  before do
    template.should_receive(:include_stylesheet).with('rbac/rbac')
    users.stub!(:count)
    assigns[:role] = role
    assigns[:roles] = roles
  end
  it "should provide a link to edit each role" do
    render 'admin/roles/index'
    response.should have_tag('a[href=?]',/\/admin\/roles\/\d+/,'Test')
  end
end