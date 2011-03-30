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
  end
  
  def test_edit_ne_trouve_pas_le_user
    User.expects(:find).with(12).raises ActiveRecord::RecordNotFound
    get :edit, :id => 12
    assert_redirected_to admin_users_path
  end
  
end