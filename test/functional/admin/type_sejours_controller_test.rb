require 'functional/test_helper'

class Admin::TypeSejoursControllerTest < ActionController::TestCase
  
  def setup
    log_in_a_user_controller
  end
  
  def test_index
    type_sejour = TypeSejour.new :intitule => 'toto', :code_inchangeable => 'tata'
    type_sejour.stubs :id => 1
    TypeSejour.stubs :all => [type_sejour]
    get :index
    assert_template :index
    assert_equal [type_sejour], assigns(:type_sejours)
  end
  
  def test_new
    type = TypeSejour.new
    TypeSejour.stubs :new => type
    get :new
    assert_template :new
    assert assigns(:type_sejour)
  end
  
  def test_create
    nouveau_type = TypeSejour.new :intitule => 'toto', :code_inchangeable => 'tata'
    TypeSejour.stubs(:new).with('intitule' => 'toto', 'code_inchangeable' => 'tata').returns nouveau_type
    nouveau_type.expects :save!
    post :create, :type_sejour => {:intitule => 'toto', :code_inchangeable => 'tata'}
    assert_redirected_to admin_type_sejours_path
  end
  
  def test_create_invalid
    nouveau_type = TypeSejour.new :intitule => '', :code_inchangeable => 'tata'
    TypeSejour.stubs(:new).with('intitule' => '', 'code_inchangeable' => 'tata').returns nouveau_type
    nouveau_type.expects(:save!).raises ActiveRecord::RecordInvalid.new(nouveau_type)
    post :create, :type_sejour => {:intitule => '', :code_inchangeable => 'tata'}
    assert_template :new
  end
  
  def test_edit
    type_sejour_a_editer = TypeSejour.new :intitule => 'toto', :code_inchangeable => 'tata'
    TypeSejour.stubs(:find).with(type_sejour_a_editer).returns type_sejour_a_editer
    type_sejour_a_editer.stubs :id => 1
    get :edit, :id => type_sejour_a_editer
    assert_template :edit
    assert assigns(:type_sejour)
  end
  
  def test_edit_ne_trouve_pas
    TypeSejour.expects(:find).with(1).raises ActiveRecord::RecordNotFound
    get :edit, :id => 1
    assert_redirected_to admin_type_sejours_path
  end
  
  def test_update
    type_sejour_a_editer = TypeSejour.new :intitule => 'toto', :code_inchangeable => 'tata'
    TypeSejour.stubs(:find).with(type_sejour_a_editer).returns type_sejour_a_editer
    type_sejour_a_editer.stubs :id => 1
    type_sejour_a_editer.expects(:update_attributes!).with('intitule' => 'titi')
    put :update, :id => type_sejour_a_editer, :type_sejour => {:intitule => 'titi'}
    assert_redirected_to admin_type_sejours_path
  end
  
  def test_update_ne_trouve_pas
    TypeSejour.expects(:find).with(1).raises ActiveRecord::RecordNotFound
    put :update, :id => 1
    assert_redirected_to admin_type_sejours_path
  end
  
  def test_update_invalide
    type_sejour_a_editer = TypeSejour.new :intitule => 'toto', :code_inchangeable => 'tata'
    TypeSejour.stubs(:find).with(type_sejour_a_editer).returns type_sejour_a_editer
    type_sejour_a_editer.stubs :id => 1
    type_sejour_a_editer.expects(:update_attributes!).with('intitule' => '').raises ActiveRecord::RecordInvalid.new(type_sejour_a_editer)
    put :update, :id => type_sejour_a_editer, :type_sejour => {:intitule => ''}
    assert_template :edit
    assert assigns(:type_sejour)
  end
  
  def test_update_change_code_inchangeable_rend_edit
    type_sejour_a_editer = TypeSejour.new :intitule => 'toto', :code_inchangeable => 'tata'
    TypeSejour.stubs(:find).with(type_sejour_a_editer).returns type_sejour_a_editer
    type_sejour_a_editer.stubs :id => 1
    type_sejour_a_editer.expects(:update_attributes!).never
    put :update, :id => type_sejour_a_editer, :type_sejour => {:code_inchangeable => ''}
    assert_template :edit
    assert assigns(:type_sejour)
  end

end