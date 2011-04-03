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
  
  def test_update_invalid
    droit = UserDroit.new :intitule => 'tata', :code_inchangeable => 'toto'
    droit.stubs :id => 23
    UserDroit.expects(:find).with(droit).returns droit
    droit.expects(:update_attributes!).with('intitule' => '').raises ActiveRecord::RecordInvalid.new(droit)
    put :update, :id => droit, :user_droit => {:intitule => ''}
    assert_template :edit
    assert_equal droit, assigns(:user_droit)
  end
  
  def test_update_change_code_inchangeable_rend_edit
    droit = UserDroit.new :intitule => 'tata', :code_inchangeable => 'toto'
    droit.stubs :id => 23
    UserDroit.stubs(:find).with(droit).returns droit
    droit.expects(:update_attributes!).with('code_inchangeable' => 'changé').never
    put :update, :id => droit, :user_droit => {:code_inchangeable => 'changé'}
    assert_template :edit
    assert assigns(:user_droit)
  end
  
  def test_destroy
    UserDroit.stubs(:find_by_code_inchangeable).with('admin')
    
    droit = UserDroit.new :intitule => 'tata', :code_inchangeable => 'toto'
    droit.stubs :id => 23
    UserDroit.expects(:find).with(droit).returns droit
    
    droit_par_default = UserDroit.new :intitule => 'moniteur', :code_inchangeable => 'mono'
    droit_par_default.stubs :id => 21
    UserDroit.expects(:find_by_code_inchangeable).with('mono').returns droit_par_default
    
    user_nouveau = User.new :user_droit => droit
    User.expects(:where).with(:user_droit_id =>  droit.id).returns [user_nouveau]
    user_nouveau.expects(:update_attribute).with(:user_droit, droit_par_default)
    droit.expects :delete
    delete :destroy, :id => droit
    assert_redirected_to admin_user_droits_path
  end
  
  def test_destroy_record_not_found
    UserDroit.expects(:find).with(123).raises ActiveRecord::RecordNotFound
    put :destroy, :id => 123
    assert_redirected_to admin_user_droits_path
  end
  
  def test_destroy_essaye_de_supprimer_admin
    UserDroit.stubs(:find_by_code_inchangeable).with('admin')
    
    droit_admin = UserDroit.new :intitule => 'administrateur', :code_inchangeable => 'admin'
    droit_admin.stubs :id => 1
    UserDroit.expects(:find).with(droit_admin).returns droit_admin
    User.expects(:where).never
    droit_admin.expects(:delete).never
    delete :destroy, :id => droit_admin
    assert_redirected_to admin_user_droits_path
  end
  
  def test_destroy_essaye_de_supprimer_mono
    UserDroit.stubs(:find_by_code_inchangeable).with('admin')
    
    droit_default = UserDroit.new :intitule => 'moniteur', :code_inchangeable => 'mono'
    UserDroit.stubs(:find_by_code_inchangeable).with('mono').returns droit_default
    droit_default.stubs :id => 1
    
    User.expects(:where).never
    droit_default.expects(:delete).never
    delete :destroy, :id => droit_default
    assert_redirected_to admin_user_droits_path
  end

end