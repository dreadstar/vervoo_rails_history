require "migration_helpers"

class CreateChallengeTags < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :challenge_tags, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :challenge, :null => false
      t.belongs_to :tag, :null => false
      t.timestamps
    end
    add_foreign_key(:challenge_tags, :challenge_id, :challenges)
    add_foreign_key(:challenge_tags, :tag_id, :tags)
  end

  def self.down
    remove_foreign_key(:challenge_tags, :tag_id)
    remove_foreign_key(:challenge_tags, :challenge_id)
    drop_table :challenge_tags
  end
end
