class User < ActiveRecord::Base
    acts_as_authentic
    
    validates_presence_of :login
    validates_presence_of :password
    validates_presence_of :password_confirmation
    validates_presence_of :email
    validates_uniqueness_of :login
    validates_uniqueness_of :email
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    
end