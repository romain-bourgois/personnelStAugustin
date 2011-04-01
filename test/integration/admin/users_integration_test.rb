require 'integration/test_helper'

class Admin::UsersIntegrationTest < ActionController::IntegrationTest

  def setup
    @user = log_in_a_user_integration
    droit_admin = Factory :user_droit, :intitule => 'administrateur', :code_inchangeable => 'admin'
    @user.user_droit = droit_admin
    @user.save!
  end

  def test_index
    user_a_afficher = Factory :user
    get_via_redirect admin_users_path
    assert_successful_path admin_users_path
    assert_equal [@user, user_a_afficher], assigns(:users)
  end
  
  def test_edit
    user_a_editer = Factory :user
    get_via_redirect edit_admin_user_path(user_a_editer)
    assert_successful_path edit_admin_user_path(user_a_editer)
    assert assigns(:user)
    assert assigns(:user_droits)
  end
  
  def test_edit_ne_trouve_pas_le_user
    get_via_redirect edit_admin_user_path(12)
    assert_successful_path admin_users_path
  end
  
  def test_update
    user_a_updater = Factory :user
    put_via_redirect admin_user_path :id => user_a_updater, :user => {:nom => 'nouveau_nom'}
    assert_successful_path edit_admin_user_path(user_a_updater)
    assert_equal 'nouveau_nom', user_a_updater.reload.nom
  end
  
  def test_update_redirige_vers_index_si_user_pas_trouve
    put_via_redirect admin_user_path :id => 12, :user => {:nom => 'nouveau_nom'}
    assert_successful_path admin_users_path
  end
  
  def test_update_rend_edit_si_mauvais_enregistrement
    user_a_updater = Factory :user
    put_via_redirect admin_user_path :id => user_a_updater, :user => {:nom => ''}
    assert_template :edit
    assert_not_equal '', user_a_updater.reload.nom
    assert assigns(:user)
    assert assigns(:user_droits)
  end

end