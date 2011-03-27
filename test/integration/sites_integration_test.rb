require 'integration/test_helper'

class PagesIntegrationTest < ActionController::IntegrationTest

  def test_index
    get_via_redirect pages_path
    assert_successful_path pages_path
  end

end