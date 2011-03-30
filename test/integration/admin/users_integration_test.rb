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
  end
  
  def test_edit_ne_trouve_pas_le_user
    get_via_redirect edit_admin_user_path(12)
    assert_successful_path admin_users_path
  end

end