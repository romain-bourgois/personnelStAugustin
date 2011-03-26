require 'integration/test_helper'

class SitesIntegrationTest < ActionController::IntegrationTest

  def test_index
    get_via_redirect sites_path
    assert_successful_path sites_path
  end

end