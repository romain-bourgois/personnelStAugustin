require 'integration/test_helper'

class Admin::UserDroitsIntegrationTest < ActionController::IntegrationTest

  def setup
    log_in_a_user_integration
  end

  def test_new
    get_via_redirect new_admin_user_droit_path
    assert_successful_path new_admin_user_droit_path
    assert assigns(:user_droit)
  end
  
  def test_create
    assert_difference "UserDroit.count" do
      post_via_redirect admin_user_droits_path :user_droit => {:intitule => 'moniteur', :code_inchangeable => 'mono'}
    end
    assert_successful_path admin_user_droits_path
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

end