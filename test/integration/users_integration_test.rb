require 'integration/test_helper'

class UsersIntegrationTest < ActionController::IntegrationTest

  def test_new
    get_via_redirect new_user_path
    assert_successful_path new_user_path
    assert assigns :user
  end
  
  def test_create
    assert_difference "User.count" do
        post_via_redirect users_path :user => { :login => 'toto', 
                                                :password => 'pass', 
                                                :password_confirmation => 'pass', 
                                                :email => 'toto@toto.com',
                                                :nom  => 'Bourgois',
                                                :prenom  => 'Romain',
                                                :date_de_naissance => Date.today,
                                                :lieu_de_naissance => 'Paris',
                                                :nationalite => 'Française',
                                                :adresse => '41 boulevard saint Jacques',
                                                :ville => 'Paris',
                                                :code_postal => 75000,
                                                :pays => 'France',
                                                :tel_portable => '0629450203',
                                                :tel_fixe => '0139517190'
                                              }
    end
    assert_successful_path root_path
  end

  def test_create_invalid
    assert_no_difference "User.count" do
        post_via_redirect users_path :user => { :login => 'toto'}
    end
    assert_template :new
    assert_response :success
  end

end