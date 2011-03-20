require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase     

  def test_new
    get :new
    assert_response :success
  end
  
  def test_create
    post :create
    assert_redirected_to root_path
  end

end