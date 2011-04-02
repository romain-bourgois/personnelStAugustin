require 'test_helper'

class TypeSejourTest < ActiveSupport::TestCase
  
  should validate_presence_of :intitule
  should validate_presence_of :code_inchangeable
  
end
