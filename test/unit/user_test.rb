require 'functional/test_helper'

class UserTest < ActiveSupport::TestCase

  should belong_to :user_droit

  should validate_presence_of :login
  should validate_presence_of :email
  should validate_format_of(:email).with('/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i')
  should validate_presence_of :nom
  should validate_presence_of :prenom
  should validate_presence_of :date_de_naissance
  should validate_presence_of :lieu_de_naissance
  should validate_presence_of :nationalite
  should validate_presence_of :adresse
  should validate_presence_of :ville
  should validate_presence_of :code_postal
  should validate_presence_of :pays
  should validate_presence_of :tel_portable
  should validate_presence_of :tel_fixe

end