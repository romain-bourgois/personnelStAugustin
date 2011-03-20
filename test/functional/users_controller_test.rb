require 'functional/test_helper'

class UsersControllerTest < ActionController::TestCase     

  def test_new
    get :new
    assert_response :success
    assert assigns :user
  end
  
  def test_create
    user = User.new
    User.expects(:new).with('login' => 'toto', 'password' => 'pass', 'password_confirmation' => 'pass', 'email' => 'toto@toto.com').returns user
    user.expects(:save!)
    post :create, :user => {:login => 'toto', :password => 'pass', :password_confirmation => 'pass', :email => 'toto@toto.com'}
    assert_redirected_to root_path
  end

end