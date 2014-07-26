require "migration_helpers"

class RenameUserActionsToActivities < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    remove_foreign_key(:user_actions, :challenge_action_id)
    remove_foreign_key(:user_actions, :user_id)
    rename_table :user_actions, :user_activities
    rename_column :user_activities, :challenge_action_id, :challenge_activity_id
    rename_column :user_activities, :action_tracker_table, :activity_tracker_table
    rename_column :user_activities, :action_tracker_class, :activity_tracker_class
    add_foreign_key(:user_activities, :user_id, :users)
    add_foreign_key(:user_activities, :challenge_activity_id, :challenge_activities)
  end

  def self.down
    remove_foreign_key(:user_activities, :challenge_activity_id)
    remove_foreign_key(:user_activities, :user_id)
    rename_table :user_activities, :user_actions
    rename_column :user_actions, :challenge_activity_id, :challenge_action_id
    rename_column :user_actions, :activity_tracker_table, :action_tracker_table
    rename_column :user_actions, :activity_tracker_class, :action_tracker_class
    add_foreign_key(:user_actions, :user_id, :users)
    add_foreign_key(:user_actions, :challenge_action_id, :challenge_actions)
  end
end
