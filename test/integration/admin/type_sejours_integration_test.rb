require 'integration/test_helper'

class Admin::TypeSejoursIntegrationTest < ActionController::IntegrationTest

  def setup
    @user = log_in_a_user_integration
    droit_admin = Factory :user_droit, :intitule => 'administrateur', :code_inchangeable => 'admin'
    @user.user_droit = droit_admin
    @user.save!
  end
  
  def test_index
    get_via_redirect admin_type_sejours_path
    assert_successful_path admin_type_sejours_path
    assert assigns(:type_sejours)
  end
  
  def test_new
    get_via_redirect new_admin_type_sejour_path
    assert_successful_path new_admin_type_sejour_path
    assert assigns(:type_sejour)
  end

end