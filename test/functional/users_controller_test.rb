require 'functional/test_helper'

class UsersControllerTest < ActionController::TestCase     

  def test_new
    get :new
    assert_response :success
    assert assigns :user
  end
  
  def test_create
    user = User.new
    User.expects(:new).with('login' => 'toto', 
                            'password' => 'pass', 
                            'password_confirmation' => 'pass', 
                            'email' => 'toto@toto.com',
                            'nom'  => 'Bourgois',
                            'prenom'  => 'Romain',
                            'date_de_naissance' => Date.today,
                            'lieu_de_naissance' => 'Paris',
                            'nationalite' => 'Française',
                            'adresse' => '41 boulevard saint Jacques',
                            'ville' => 'Paris',
                            'code_postal' => 75000,
                            'pays' => 'France',
                            'tel_portable' => '0629450203',
                            'tel_fixe' => '0139517190'
                            ).returns user
    user.expects(:save!)
    post :create, :user => {  :login => 'toto', 
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
    assert_redirected_to root_path
  end
  
  def test_create_invalid
    user = User.new
    User.expects :new => user
    user.expects(:save!).raises(ActiveRecord::RecordInvalid.new(user))
    User.expects :new => user
    post :create, :user => {}
    assert_response :success
    assert_template :new
  end

end