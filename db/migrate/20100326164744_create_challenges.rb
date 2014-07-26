require "migration_helpers"

class CreateChallenges < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :challenges, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.string :name, :null => false, :limit => 50
      t.string :description, :null => false, :limit => 255
      t.date :start_date, :null => true
      t.date :end_date, :null => true
      t.decimal :grant_amount, :null => true, :precision => 10, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :challenges
  end
end
