require 'functional/test_helper'

class UserTest < ActiveSupport::TestCase

  should validate_presence_of :login
  should validate_presence_of :password
  should validate_presence_of :password_confirmation
  should validate_presence_of :email
  should validate_format_of(:email).with('/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i')

end
