require 'test_helper'

class ActiveSupport::TestCase
  
  def assert_successful_path url
    assert_response :success
    assert_equal url, path
  end
  
end