require 'test_helper'

class ActiveSupport::TestCase
  
  def assert_successful_path url
    assert_response :success
    assert_equal url, path
  end
  
  def log_in_a_user_integration
    user = Factory :user, :login => "rbourgois", :password => "aaaa", :password_confirmation => "aaaa"
    post_via_redirect user_sessions_path, :user_session => {:login => 'rbourgois', :password => 'aaaa'}
    droit = Factory :user_droit
    user.user_droit = droit
    user.save!
    user
  end
  
end