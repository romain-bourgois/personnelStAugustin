require 'functional/test_helper'

class Private::UserSessionsControllerTest < ActionController::TestCase
  def test_destroy_destroy_user_session
    user_session = log_in_a_user_controller
    user_session.expects :destroy
    delete :destroy
    assert_redirected_to root_path
  end
end