class ChangeDateTimeToDateInUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :date_de_naissance, :date
  end

  def self.down
    change_column :users, :date_de_naissance, :datetime
  end
end