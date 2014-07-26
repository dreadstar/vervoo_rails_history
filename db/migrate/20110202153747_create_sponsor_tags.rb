require "migration_helpers"

class CreateSponsorTags < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :sponsor_tags, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :sponsor, :null => false
      t.belongs_to :tag, :null => false
      t.timestamps
    end
    add_foreign_key(:sponsor_tags, :sponsor_id, :sponsors)
    add_foreign_key(:sponsor_tags, :tag_id, :tags)
  end

  def self.down
    remove_foreign_key(:sponsor_tags, :tag_id)
    remove_foreign_key(:sponsor_tags, :sponsor_id)
    drop_table :sponsor_tags
  end
end
