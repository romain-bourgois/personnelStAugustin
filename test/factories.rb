Factory.define :user do |u|
  u.login 'bob'
  u.password 'aaaa'
  u.email {Factory.next :email}
  u.password_confirmation 'aaaa'
  u.persistence_token ""
  u.nom 'Bourgois'
  u.prenom 'Romain'
  u.date_de_naissance Date.today
  u.lieu_de_naissance 'Paris'
  u.nationalite 'Française'
  u.adresse '41 boulevard saint Jacques'
  u.ville 'Paris'
  u.code_postal '75000'
  u.pays 'France'
  u.tel_portable '0629450203'
  u.tel_fixe '0139517190'
end

Factory.define :user_droit do |ud|
  ud.intitule {Factory.next :intitule}
  ud.code_inchangeable {Factory.next :code_inchangeable}
end

Factory.sequence :intitule do |n|
  "intitule#{n}"
end

Factory.sequence :email do |n|
  "toto#{n}@toto.com"
end

Factory.sequence :code_inchangeable do |n|
  "code_inchangeable#{n}"
end