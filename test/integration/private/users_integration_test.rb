require 'integration/test_helper'

class Private::UsersIntegrationTest < ActionController::IntegrationTest

  def test_edit
    user_connecte = log_in_a_user_integration
    get_via_redirect edit_private_user_path(user_connecte.id)
    assert_successful_path edit_private_user_path(user_connecte.id)
    assert assigns(:user)
  end

end