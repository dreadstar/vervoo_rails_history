require "migration_helpers"

class CreateActivityTags < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :activity_tags, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :activity, :null => false
      t.belongs_to :tag, :null => false
      t.timestamps
    end
    add_foreign_key(:activity_tags, :activity_id, :activities)
    add_foreign_key(:activity_tags, :tag_id, :tags)
  end

  def self.down
    remove_foreign_key(:activity_tags, :tag_id)
    remove_foreign_key(:activity_tags, :activity_id)
    drop_table :activity_tags
  end
end
