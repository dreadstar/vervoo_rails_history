require "migration_helpers"

class CreateGroupUsers < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    create_table :group_users, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :group, :null => false
      t.belongs_to :user, :null => false
      t.boolean :administrator, :null => false, :default => 0
      t.timestamps
    end
    add_foreign_key(:group_users, :group_id, :groups)
    add_foreign_key(:group_users, :user_id, :users)
    add_index :group_users, [:user_id, :group_id], :unique => true
  end

  def self.down
    remove_index :group_users, :column => [:user_id, :group_id]
    remove_foreign_key(:group_users, :user_id)
    remove_foreign_key(:group_users, :group_id)
    drop_table :group_users
  end
end
