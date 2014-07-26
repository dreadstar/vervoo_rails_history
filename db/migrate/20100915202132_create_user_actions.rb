require "migration_helpers"

class CreateUserActions < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    create_table :user_actions, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :user, :null => false
      t.belongs_to :challenge_action, :null => false
      t.string :action_tracker_table, :null => true, :length => 20
      t.string :action_tracker_class, :null => true, :length => 20
      t.timestamps
    end
    add_foreign_key(:user_actions, :user_id, :users)
    add_foreign_key(:user_actions, :challenge_action_id, :challenge_actions)
  end

  def self.down
    remove_foreign_key(:user_actions, :challenge_action_id)
    remove_foreign_key(:user_actions, :user_id)
    drop_table :user_actions
  end
end
