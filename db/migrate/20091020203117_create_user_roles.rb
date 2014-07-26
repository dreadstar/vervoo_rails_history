require "migration_helpers"

class CreateUserRoles < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    create_table :user_roles, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :user, :null => false
      t.belongs_to :role, :null => false
      t.timestamps
    end
    add_foreign_key(:user_roles, :user_id, :users)
    add_foreign_key(:user_roles, :role_id, :roles)
  end

  def self.down
    remove_foreign_key(:user_roles, :role_id)
    remove_foreign_key(:user_roles, :user_id)
    drop_table :user_roles
  end
end
