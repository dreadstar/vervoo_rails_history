require "migration_helpers"

class CreateTags < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :tags, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.string :name, :null => false, :limit => 50
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
