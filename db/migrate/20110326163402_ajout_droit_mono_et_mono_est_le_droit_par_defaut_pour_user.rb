class AjoutDroitMonoEtMonoEstLeDroitParDefautPourUser < ActiveRecord::Migration
  def self.up
    new_droit = UserDroit.new :intitule => 'moniteur', :code_inchangeable => 'mono'
    new_droit.save!
    change_column_default :users, :user_droit_id, new_droit.id
  end

  def self.down
    change_column_default :users, :user_droit_id, nil
  end
end