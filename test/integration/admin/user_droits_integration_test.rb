require 'integration/test_helper'

class Admin::UserDroitsIntegrationTest < ActionController::IntegrationTest

  def setup
    user = log_in_a_user_integration
    droit_admin = Factory :user_droit, :intitule => 'administrateur', :code_inchangeable => 'admin'
    user.user_droit = droit_admin
    user.save!
  end

  def test_new
    get_via_redirect new_admin_user_droit_path
    assert_successful_path new_admin_user_droit_path
    assert assigns(:user_droit)
  end
  
  def test_create
    assert_difference "UserDroit.count" do
      post_via_redirect admin_user_droits_path :user_droit => {:intitule => 'nouvel_intitule', :code_inchangeable => 'nouveau_code'}
    end
    assert_successful_path admin_user_droits_path
  end
  
  def test_create_catch_exception_if_raised_and_return_new_template
    assert_no_difference "UserDroit.count" do
      post_via_redirect admin_user_droits_path :user_droit => {:intitule => '', :code_inchangeable => ''}
    end
    assert assigns(:user_droit)
    assert_template :new
  end
  
  def test_index
    get_via_redirect admin_user_droits_path
    assert_successful_path admin_user_droits_path
    assert assigns(:user_droits)
  end
  
  def test_redirige_vers_root_path_si_pas_connecte
    delete_via_redirect private_user_sessions_path
    get_via_redirect admin_user_droits_path
    assert_successful_path root_path
    assert_equal 'Vous devez être connecté en tant qu\'administrateur pour accéder à cette page', flash[:error]
  end
  
  def test_edit
    user_droit = Factory :user_droit
    get_via_redirect edit_admin_user_droit_path(user_droit)
    assert_equal assigns(:user_droit), user_droit
    assert_successful_path edit_admin_user_droit_path(user_droit)
  end
  
  def test_edit_ne_trouve_pas_de_droit
    get_via_redirect edit_admin_user_droit_path(12)
    assert_response :success
  end
  
  def test_update
    user_droit = Factory :user_droit
    put_via_redirect admin_user_droit_path :id => user_droit, :user_droit => {:intitule => 'changé'}
    assert_equal 'changé', user_droit.reload.intitule
    assert_response :success
  end
  
  def test_update_ne_trouve_pas_de_droit
    put_via_redirect admin_user_droit_path :id => 12, :user_droit => {:intitule => 'changé'}
    assert_response :success
  end
  
  def test_update_avec_entree_invalide
    user_droit = Factory :user_droit
    put_via_redirect admin_user_droit_path :id => user_droit, :user_droit => {:intitule => ''}
    assert_equal assigns(:user_droit), user_droit.reload
    assert_template :edit
  end
  
  def test_destroy
    droit_default = Factory :user_droit, :code_inchangeable => 'mono'
    droit_user = Factory :user_droit
    user = Factory :user, :user_droit => droit_user
    assert_difference 'UserDroit.count', -1 do
      delete_via_redirect admin_user_droit_path :id => droit_user
    end
    assert_successful_path admin_user_droits_path
    assert_equal droit_default, user.reload.user_droit
  end
  
  def test_destroy_record_not_found
    delete_via_redirect admin_user_droit_path :id => 123
    assert_response :success
    assert_successful_path admin_user_droits_path
  end

end