class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :nom, :string
    add_column :users, :prenom, :string
    add_column :users, :date_de_naissance, :datetime
    add_column :users, :lieu_de_naissance, :string
    add_column :users, :nationalite, :string
    add_column :users, :adresse, :text
    add_column :users, :ville, :string
    add_column :users, :code_postal, :integer
    add_column :users, :pays, :string
    add_column :users, :tel_portable, :string
    add_column :users, :tel_fixe, :string
  end

  def self.down
    remove_column :users, :tel_fixe
    remove_column :users, :tel_portable
    remove_column :users, :pays
    remove_column :users, :code_postal
    remove_column :users, :ville
    remove_column :users, :adresse
    remove_column :users, :nationalite
    remove_column :users, :lieu_de_naissance
    remove_column :users, :date_de_naissance
    remove_column :users, :prenom
    remove_column :users, :nom
  end
end