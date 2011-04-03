require 'functional/test_helper'

class Admin::TypeSejoursControllerTest < ActionController::TestCase
  
  def setup
    log_in_a_user_controller
  end
  
  def test_index
    type_sejour = TypeSejour.new
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

end