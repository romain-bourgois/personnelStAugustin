Factory.define :user do |u|
  u.login 'bob'
  u.password 'aaaa'
  u.email 'rbourgoi@isep.fr'
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