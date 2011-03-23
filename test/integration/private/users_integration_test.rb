require 'integration/test_helper'

class Private::UsersIntegrationTest < ActionController::IntegrationTest

  def test_edit
    user_connecte = log_in_a_user_integration
    get_via_redirect edit_private_user_path(user_connecte)
    assert_successful_path edit_private_user_path(user_connecte)
  end
  
  def test_update
    user_connecte = log_in_a_user_integration
    put_via_redirect private_user_path(user_connecte), :user => {:prenom => 'prénom changé'}
    assert_successful_path edit_private_user_path(user_connecte)
    assert_equal 'prénom changé', user_connecte.reload.prenom
  end
  
  def test_update_renvoi_edit_si_mauvais_parametre
    user_connecte = log_in_a_user_integration
    put_via_redirect private_user_path(user_connecte), :user => {:prenom => ''}
    assert_template :edit
    assert_equal user_connecte.reload.prenom, user_connecte.prenom
  end
  
  def test_redirige_vers_root_si_pas_connecte
    user = Factory :user
    get_via_redirect edit_private_user_path(user)
    assert_successful_path root_path
  end

end