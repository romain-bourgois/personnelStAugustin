class CreateUserDroits < ActiveRecord::Migration
  def self.up
    create_table :user_droits do |t|
      t.column :intitule, :string
      t.column :code_inchangeable, :string
      t.timestamps
    end
    u = UserDroit.new :intitule => 'administrateur', :code_inchangeable => 'admin'
    u.save!
  end

  def self.down
    drop_table :user_droits
  end
end
