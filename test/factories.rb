Factory.define :user do |f|
  f.login 'bob'
  f.password 'aaaa'
  f.email 'rbourgoi@isep.fr'
  f.password_confirmation 'aaaa'
  f.persistence_token ""
end