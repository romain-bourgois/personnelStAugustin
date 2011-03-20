require 'integration/test_helper'

class Private::UserSessionsIntegrationTest < ActionController::IntegrationTest
  def test_destroy
    user_connecte = log_in_a_user_integration
    delete_via_redirect private_user_sessions_path
    assert_successful_path root_path
    assert_nil session["user_credentials"]
  end
end