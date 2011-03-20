require 'integration/test_helper'

class UserSessionsIntegrationTest < ActionController::IntegrationTest

  def test_new
    get_via_redirect new_user_sessions_path
    assert_successful_path new_user_sessions_path
  end
  
  def test_create_valid
    user = Factory :user, :login => 'toto', :password => 'tata', :password_confirmation => 'tata'
    post_via_redirect user_sessions_path :user_session => {:login => 'toto', :password => 'tata'}
    assert_successful_path root_path
    assert session["user_credentials"]
  end

  def test_create_invalid
    user = Factory :user, :login => 'login', :password => 'pass', :password_confirmation => 'pass'
    post_via_redirect user_sessions_path(:user_session => {:login => 'fake_login', :password => 'fake_pass'})
    assert_template :new
    assert_nil session["user_credentials"]
  end

end