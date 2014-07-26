require "migration_helpers"

class CreateGroups < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    create_table :groups, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.string :name, :null => false, :limit => 100
      t.belongs_to :creator_user, :class_name => "User", :null => false
      t.timestamps
    end
    add_foreign_key(:groups, :creator_user_id, :users)
  end

  def self.down
    remove_foreign_key(:groups, :creator_user_id)
    drop_table :groups
  end
end
