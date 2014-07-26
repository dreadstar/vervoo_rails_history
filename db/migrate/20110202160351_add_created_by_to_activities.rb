require "migration_helpers"

class AddCreatedByToActivities < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    add_column :activities, :created_by_user_id, :integer, :default => 1
    add_foreign_key(:activities, :created_by_user_id, :users)
  end

  def self.down
    remove_foreign_key(:activities, :created_by_user_id)
    remove_column :activities, :created_by_user_id, :integer
  end
end
