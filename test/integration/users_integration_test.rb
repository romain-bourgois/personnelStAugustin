require 'integration/test_helper'

class UsersIntegrationTest < ActionController::IntegrationTest

  def test_new
    get_via_redirect new_user_path
    assert_successful_path new_user_path
    assert assigns :user
  end
  
  def test_create
    assert_difference "User.count" do
        post_via_redirect users_path :user => {:login => 'toto', :password => 'pass', :password_confirmation => 'pass', :email => 'toto@toto.com'}
    end
    assert_successful_path root_path
  end

end