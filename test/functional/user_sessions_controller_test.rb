require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase     

  def test_new
    get :new
    assert_response :success
  end
  
  def test_create
    user = User.new :login => 'toto', :password => 'tata', :password_confirmation => 'tata'
    user_session = UserSession.stubs :user => user
    UserSession.stubs(:new).with('login' => 'toto', 'password' => 'tata').returns(user_session)
    user_session.expects :save!
    post :create, :user_session => {:login => 'toto', :password => 'tata'}
    assert_redirected_to root_path
  end
  
  def test_create_mauvais_leve_une_exception
      post :create, :user_session => {:login => 'fake', :password => 'fake_pass'}
      assert_template :new
      assert_response :success
  end
  

end