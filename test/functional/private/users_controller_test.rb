require 'functional/test_helper'

class Private::UsersControllerTest < ActionController::TestCase
  
  def test_edit
    user_connecte = log_in_a_user_controller
    user_connecte.stubs :id => 1
    get :edit, :id => user_connecte.id
    assert_response :success
  end
  
  def test_update
    log_in_a_user_controller
    user = User.new
    user.stubs :id => 1
    User.stubs :find => user
    user.expects(:update_attributes!).with('prenom' => 'prenom changé')
    put :update, :id => user, :user => {:prenom => 'prenom changé'}
    assert_redirected_to edit_private_user_path(user)
  end
  
  def test_update_renvoi_edit_si_mauvais_parametre
    log_in_a_user_controller
    user = User.new
    user.stubs :id => 1
    User.stubs :find => user
    user.expects(:update_attributes!).with('prenom' => '').raises ActiveRecord::RecordInvalid.new(user)
    put :update, :id => user, :user => {:prenom => ''}
    assert_template :edit
  end
  
  def test_redirige_sur_root_si_pas_connecte
    get :edit, :id => 1
    assert_redirected_to root_path
  end
  
end