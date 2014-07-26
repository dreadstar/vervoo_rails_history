require "migration_helpers"

class AddCreatedByToTables < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    add_column :charities, :created_by_user_id, :integer, :default => 1
    add_column :sponsors, :created_by_user_id, :integer, :default => 1
    add_column :challenges, :created_by_user_id, :integer, :default => 1
    add_foreign_key(:charities, :created_by_user_id, :users)
    add_foreign_key(:sponsors, :created_by_user_id, :users)
    add_foreign_key(:challenges, :created_by_user_id, :users)
  end

  def self.down
    remove_foreign_key(:challenges, :created_by_user_id)
    remove_foreign_key(:sponsors, :created_by_user_id)
    remove_foreign_key(:charities, :created_by_user_id)
    remove_column :challenges, :created_by_user_id, :integer
    remove_column :sponsors, :created_by_user_id, :integer
    remove_column :charities, :created_by_user_id, :integer
  end
end
