require 'functional/test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  
  def setup
    log_in_a_user_controller
  end
  
  def setup_index
    user_a_afficher = User.new :nom => 'toto', :prenom => 'tata'
    user_a_afficher.stubs :id => 1
    @user_pagines = [user_a_afficher]
    @user_pagines.stubs :total_pages => 1
    @search = User.search
  end
  
  def test_index
    setup_index
    
    User.expects :search => @search
    @search.expects(:paginate).with(:page => nil, :per_page => 20).returns @user_pagines
    get :index
    assert_response :success
    assert_equal @user_pagines, assigns(:users)
  end
  
  def test_edit
    user_a_editer = User.new
    user_a_editer.stubs :id => 1
    User.expects(:find).with(user_a_editer).returns user_a_editer
    get :edit, :id => user_a_editer
    assert_response :success
    assert assigns(:user)
    assert assigns(:user_droits)
  end
  
  def test_edit_ne_trouve_pas_le_user
    User.expects(:find).with(12).raises ActiveRecord::RecordNotFound
    get :edit, :id => 12
    assert_redirected_to admin_users_path
  end
  
  def test_update
    user_a_updater = User.new :nom => 'tata', :prenom => 'toto'
    user_a_updater.stubs :id => 1
    User.expects(:find).with(user_a_updater).returns user_a_updater
    user_a_updater.expects(:update_attributes!).with('nom' => 'nouveau nom')
    put :update, :id => user_a_updater, :user => {:nom => 'nouveau nom'}
    assert_redirected_to edit_admin_user_path(user_a_updater)
  end
  
  def test_update_redirige_vers_index_si_user_pas_trouve
    User.expects(:find).with(12).raises ActiveRecord::RecordNotFound
    put :update, :id => 12, :user => {:nom => 'nouveau nom'}
    assert_redirected_to admin_users_path
  end
  
  def test_update_rend_edit_si_mauvais_enregistrement
    user_a_updater = User.new
    user_a_updater.stubs :id => 1
    User.expects(:find).with(user_a_updater).returns user_a_updater
    user_a_updater.expects(:update_attributes!).with('nom' => '').raises ActiveRecord::RecordInvalid.new(user_a_updater)
    put :update, :id => user_a_updater, :user => {:nom => ''}
    assert_template :edit
    assert assigns(:user)
    assert assigns(:user_droits)
  end
  
  def test_update_rend_edit_si_on_essaye_de_modifier_le_role_de_l_admin_connecte
    User.stubs(:find).with(@controller.current_user).returns @controller.current_user
    @controller.current_user.expects(:destroy).never
    put :update, :id => @controller.current_user, :user => {:user_droit_id => 15}
    assert_template :edit
    assert assigns(:user)
    assert assigns(:user_droits)
  end
  
  def test_destroy
    user_a_supprimer = User.new
    user_a_supprimer.stubs :id => 1
    User.stubs(:find).with(user_a_supprimer).returns user_a_supprimer
    user_a_supprimer.expects :destroy
    delete :destroy, :id => user_a_supprimer
    assert_redirected_to admin_users_path
  end

  def test_destroy_ne_trouve_pas_redirige
    User.stubs(:find).with(1).raises ActiveRecord::RecordNotFound
    delete :destroy, :id => 1
    assert_redirected_to admin_users_path
  end
  
  def test_destroy_ne_detruit_pas_le_user_admin_en_cours
    User.stubs(:find).with(@controller.current_user).returns @controller.current_user
    @controller.current_user.expects(:destroy).never
    delete :destroy, :id => @controller.current_user
    assert_redirected_to admin_users_path
  end

end