class CreateTypeSejours < ActiveRecord::Migration
  def self.up
    create_table :type_sejours do |t|
      t.column :intitule, :string
      t.column :code_inchangeable, :string
      
    end
  end

  def self.down
    drop_table :type_sejours
  end
end
