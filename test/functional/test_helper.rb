require 'test_helper'

class ActiveSupport::TestCase

  def log_in_a_user_controller
    user = User.new :login => 'toto', :password => 'tata', :password_confirmation => 'tata', :email => 'toto@toto.com', :nom  => 'Bourgois', :prenom  => 'Romain', :date_de_naissance => Date.today, :lieu_de_naissance => 'Paris', :nationalite => 'Française', :adresse => '41 boulevard saint Jacques', :ville => 'Paris', :code_postal => 75000, :pays => 'France', :tel_portable => '0629450203', :tel_fixe => '0139517190'
    user_session = UserSession.stubs :user => user
    UserSession.stubs(:new).with('login' => 'toto', 'password' => 'tata').returns(user_session)
    UserSession.stubs :find => user_session
    @controller.stubs :current_user => user
    user_session
  end
  
end