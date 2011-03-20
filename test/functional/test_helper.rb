require 'test_helper'

class ActiveSupport::TestCase

  def log_in_a_user_controller
    user = User.new :login => 'toto', :password => 'tata', :password_confirmation => 'tata'
    user_session = UserSession.stubs :user => user
    UserSession.stubs(:new).with('login' => 'toto', 'password' => 'tata').returns(user_session)
    UserSession.stubs :find => user_session
    user_session
  end
  
end