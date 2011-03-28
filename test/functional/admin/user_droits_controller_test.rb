require 'functional/test_helper'

class Admin::UserDroitsControllerTest < ActionController::TestCase
  
  def setup
    log_in_a_user_controller
  end
  
  def test_new
    get :new
    assert_response :success
    assert assigns(:user_droit)
  end
  
  def test_create
    user_droit = UserDroit.new
    UserDroit.stubs(:new).with('intitule' => 'moniteur', 'code_unique' => 'mono').returns user_droit
    user_droit.expects(:save!)
    post :create, :user_droit => {:intitule => 'moniteur', :code_unique => 'mono'}
    assert_redirected_to  admin_user_droits_path
  end
  
  def test_create_catch_exception_if_raised_and_return_new_template
    user_droit = UserDroit.new
    UserDroit.stubs(:new).with('intitule' => '', 'code_unique' => '').returns user_droit
    user_droit.expects(:save!).raises ActiveRecord::RecordInvalid.new(user_droit)
    post :create, :user_droit => {:intitule => '', :code_unique => ''}
    assert assigns(:user_droit)
    assert_template :new
  end
  
  def test_index
    get :index
    assert_response :success
    assert assigns(:user_droits)
  end
  
  def test_redirige_vers_admin_si_pas_connecte_comme_admin
    @controller.stubs :current_user => nil
    get :index
    assert_redirected_to root_path
  end
  
  def test_edit
    droit = UserDroit.new
    droit.stubs :id => 23
    UserDroit.expects(:find).with(droit).returns droit
    get :edit, :id => droit
    assert_response :success
    assert_equal assigns(:user_droit), droit
  end
  
  def test_edit_ne_trouve_pas_de_droit
    UserDroit.expects(:find).with(12).raises ActiveRecord::RecordNotFound
    get :edit, :id => 12
    assert_redirected_to admin_user_droits_path
  end
  
  def test_update
    droit = UserDroit.new :intitule => 'tata', :code_inchangeable => 'toto'
    droit.stubs :id => 23
    UserDroit.expects(:find).with(droit).returns droit
    droit.expects(:update_attributes!).with('intitule' => 'changé')
    put :update, :id => droit, :user_droit => {:intitule => 'changé'}
    assert_redirected_to admin_user_droits_path
  end
  
  def test_update_ne_trouve_pas
    UserDroit.expects(:find).with(12).raises ActiveRecord::RecordNotFound
    put :update, :id => 12, :user_droit => {:intitule => 'changé'}
    assert_redirected_to admin_user_droits_path
  end
  
  def test_update_pas_bonne_entree
    droit = UserDroit.new :intitule => 'tata', :code_inchangeable => 'toto'
    droit.stubs :id => 23
    UserDroit.expects(:find).with(droit).returns droit
    droit.expects(:update_attributes!).with('intitule' => '').raises ActiveRecord::RecordInvalid.new(droit)
    put :update, :id => droit, :user_droit => {:intitule => ''}
    assert_template :edit
    assert_equal droit, assigns(:user_droit)
  end
  
  def test_destroy
    droit = UserDroit.new :intitule => 'tata', :code_inchangeable => 'toto'
    droit.stubs :id => 23
    UserDroit.expects(:find).with(droit).returns droit
    droit.expects(:delete)
    put :destroy, :id => droit
    assert_redirected_to admin_user_droits_path
  end

end