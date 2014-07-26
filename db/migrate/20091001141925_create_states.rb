class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.string :name, :null => false, :limit => 40
      t.string :abbrev, :null => false, :limit => 2
      t.boolean :usual, :null => false
    end
  end

  def self.down
    drop_table :states
  end
end
