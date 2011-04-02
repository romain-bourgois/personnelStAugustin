require 'functional/test_helper'

class Admin::TypeSejoursControllerTest < ActionController::TestCase
  
  def setup
    log_in_a_user_controller
  end
  
  def test_index
    type_sejour = TypeSejour.new
    TypeSejour.stubs :all => [type_sejour]
    get :index
    assert_equal [type_sejour], assigns(:type_sejours)
  end
  
  def test_new
    type = TypeSejour.new
    TypeSejour.stubs :new => type
    get :new
    assert assigns(:type_sejour)
  end

end