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
  
  def test_create
    assert_difference 'TypeSejour.count' do
      post_via_redirect admin_type_sejours_path(:type_sejour => {:intitule => 'toto', :code_inchangeable => 'tata'})
    end
    assert_successful_path admin_type_sejours_path
  end
  
  def test_create_invalid
    assert_no_difference 'TypeSejour.count' do
      post_via_redirect admin_type_sejours_path(:type_sejour => {:intitule => '', :code_inchangeable => 'tata'})
    end
    assert_template :new
  end
  
  def test_edit
    type_sejour = Factory :type_sejour
    get_via_redirect edit_admin_type_sejour_path(type_sejour)
    assert_template :edit
    assert assigns(:type_sejour)
  end
  
  def test_edit_ne_trouve_pas
    get_via_redirect edit_admin_type_sejour_path(1)
    assert_successful_path admin_type_sejours_path
  end
  
  def test_update
    type_sejour = Factory :type_sejour
    put_via_redirect admin_type_sejour_path :id => type_sejour, :type_sejour => {:intitule => 'update'}
    assert_equal 'update', type_sejour.reload.intitule
    assert_successful_path admin_type_sejours_path
  end
  
  def test_update_ne_trouve_pas
    put_via_redirect admin_type_sejour_path :id => 1
    assert_successful_path admin_type_sejours_path
  end
  
  def test_update_invalid
    type_sejour = Factory :type_sejour
    put_via_redirect admin_type_sejour_path :id => type_sejour, :type_sejour => {:intitule => ''}
    assert_not_equal '', type_sejour.reload.intitule
    assert_template :edit
    assert assigns(:type_sejour)
  end
  
  def test_update_change_code_inchangeable_rend_edit
    type_sejour = Factory :type_sejour
    put_via_redirect admin_type_sejour_path :id => type_sejour, :type_sejour => {:code_inchangeable => 'totototo'}
    assert_not_equal 'totototo', type_sejour.reload.code_inchangeable
    assert_template :edit
    assert assigns(:type_sejour)
  end

end