require "migration_helpers"

class CreateCharityTags < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :charity_tags, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :charity, :null => false
      t.belongs_to :tag, :null => false
      t.timestamps
    end
    add_foreign_key(:charity_tags, :charity_id, :charities)
    add_foreign_key(:charity_tags, :tag_id, :tags)
  end

  def self.down
    remove_foreign_key(:charity_tags, :tag_id)
    remove_foreign_key(:charity_tags, :charity_id)
    drop_table :charity_tags
  end
end
