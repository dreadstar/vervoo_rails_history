require "migration_helpers"

class CreateChallengeActions < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    create_table :challenge_actions, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :challenge, :null => false
      t.belongs_to :action, :null => false
      t.string :action_value, :null => true, :length => 50
      t.string :action_tracker_table, :null => true, :length => 20
      t.string :action_tracker_class, :null => true, :length => 20
      t.timestamps
    end
    add_foreign_key(:challenge_actions, :challenge_id, :challenges)
    add_foreign_key(:challenge_actions, :action_id, :actions)
  end

  def self.down
    remove_foreign_key(:challenge_actions, :action_id)
    remove_foreign_key(:challenge_actions, :challenge_id)
    drop_table :challenge_actions
  end
end
