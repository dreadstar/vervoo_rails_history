class ModifyUserActivities < ActiveRecord::Migration
  def self.up
    remove_column :user_activities, :activity_tracker_table
    remove_column :user_activities, :activity_tracker_class
    add_column :user_activities, :activity_data, :text
    remove_column :challenge_activities, :activity_tracker_table
    remove_column :challenge_activities, :activity_tracker_class
  end

  def self.down
    add_column :challenge_activities, :activity_tracker_table
    add_column :challenge_activities, :activity_tracker_class
    remove_column :user_activities, :activity_data
    add_column :user_actions, :activity_tracker_table
    add_column :user_actions, :activity_tracker_class
  end
end
