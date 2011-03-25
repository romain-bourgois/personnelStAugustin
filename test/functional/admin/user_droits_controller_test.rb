require 'functional/test_helper'

class Admin::UserDroitsControllerTest < ActionController::TestCase

  def test_new
    log_in_a_user_controller
    get :new
    assert_response :success
    assert assigns(:user_droit)
  end
  
  def test_create
    log_in_a_user_controller
    user_droit = UserDroit.new
    UserDroit.stubs(:new).with('intitule' => 'moniteur', 'code_unique' => 'mono').returns user_droit
    user_droit.expects(:save!)
    post :create, :user_droit => {:intitule => 'moniteur', :code_unique => 'mono'}
    assert_redirected_to  admin_user_droits_path
  end
  
  def test_index
    log_in_a_user_controller
    get :index
    assert_response :success
    assert assigns(:user_droits)
  end
  
  def test_redirige_vers_admin_si_pas_connecte_comme_admin
    get :index
    redirect_to root_path
  end
  
  

end