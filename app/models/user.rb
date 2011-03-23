class User < ActiveRecord::Base
    acts_as_authentic
    
    validates_presence_of :login
    validates_presence_of :email
    validates_uniqueness_of :login
    validates_uniqueness_of :email
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    validates_presence_of :nom
    validates_presence_of :prenom
    validates_presence_of :date_de_naissance
    validates_presence_of :lieu_de_naissance
    validates_presence_of :nationalite
    validates_presence_of :adresse
    validates_presence_of :ville
    validates_presence_of :code_postal
    validates_presence_of :pays
    validates_presence_of :tel_portable
    validates_presence_of :tel_fixe
end