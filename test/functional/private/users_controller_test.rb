require 'functional/test_helper'

class Private::UsersControllerTest < ActionController::TestCase
  
  def test_edit
    user_session = log_in_a_user_controller
    user_session.stubs :id => 1
    user = User.new
    user.stubs :id => 1
    User.stubs(:find).with(1).returns user
    get :edit, :id => user_session.id
    assert_response :success
    assert assigns(:user)
  end
  
end