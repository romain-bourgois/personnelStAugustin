class UserDroit < ActiveRecord::Base
  
  validates_presence_of :intitule
  validates_presence_of :code_inchangeable
  
  validates_uniqueness_of :intitule
  validates_uniqueness_of :code_inchangeable
  
end
