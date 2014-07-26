require "migration_helpers"

class RenameActionsToActivities < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    remove_foreign_key(:action_tracker_facebook_shares, :challenge_id)
    remove_foreign_key(:action_tracker_facebook_shares, :challenge_action_id)
    remove_foreign_key(:action_tracker_facebook_shares, :action_id)
    remove_foreign_key(:action_tracker_facebook_shares, :user_id)

    remove_foreign_key(:challenge_actions, :action_id)
    remove_foreign_key(:challenge_actions, :challenge_id)

    rename_table :actions, :activities
    add_column :activities, :enabled, :boolean, :default => false

    rename_table :challenge_actions, :challenge_activities
    rename_column :challenge_activities, :action_id, :activity_id
    rename_column :challenge_activities, :action_value, :activity_value
    rename_column :challenge_activities, :action_tracker_table, :activity_tracker_table
    rename_column :challenge_activities, :action_tracker_class, :activity_tracker_class
    add_foreign_key(:challenge_activities, :challenge_id, :challenges)
    add_foreign_key(:challenge_activities, :activity_id, :activities)

    rename_table :action_tracker_facebook_shares, :activity_tracker_facebook_shares
    rename_column :activity_tracker_facebook_shares, :action_id, :activity_id
    rename_column :activity_tracker_facebook_shares, :challenge_action_id, :challenge_activity_id
    add_foreign_key(:activity_tracker_facebook_shares, :challenge_id, :challenges)
    add_foreign_key(:activity_tracker_facebook_shares, :challenge_activity_id, :challenge_activity)
    add_foreign_key(:activity_tracker_facebook_shares, :activity_id, :activity)
    add_foreign_key(:activity_tracker_facebook_shares, :user_id, :users)
  end 
  def self.down
    remove_foreign_key(:activity_tracker_facebook_shares, :challenge_id)
    remove_foreign_key(:activity_tracker_facebook_shares, :challenge_activity_id)
    remove_foreign_key(:activity_tracker_facebook_shares, :activity_id)
    remove_foreign_key(:activity_tracker_facebook_shares, :user_id)

    remove_foreign_key(:challenge_activities, :activity_id)
    remove_foreign_key(:challenge_activities, :challenge_id)

    rename_table :activities, :actions

    rename_table :challenge_activities, :challenge_actions
    rename_column :challenge_actions, :activity_id, :action_id
    rename_column :challenge_actions, :activity_value, :action_value
    rename_column :challenge_actions, :activity_tracker_table, :action_tracker_table
    rename_column :challenge_actions, :activity_tracker_class, :action_tracker_class
    add_foreign_key(:challenge_actions, :challenge_id, :challenges)
    add_foreign_key(:challenge_actions, :action_id, :actions)

    rename_table :activity_tracker_facebook_shares, :action_tracker_facebook_shares
    rename_column :action_tracker_facebook_shares, :action_id, :action_id
    rename_column :action_tracker_facebook_shares, :challenge_activity_id, :challenge_action_id
    add_foreign_key(:action_tracker_facebook_shares, :challenge_id, :challenges)
    add_foreign_key(:action_tracker_facebook_shares, :challenge_action_id, :challenge_action)
    add_foreign_key(:action_tracker_facebook_shares, :action_id, :action)
    add_foreign_key(:action_tracker_facebook_shares, :user_id, :users)
  end
end
