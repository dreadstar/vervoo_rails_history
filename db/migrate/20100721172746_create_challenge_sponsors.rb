require "migration_helpers"

class CreateChallengeSponsors < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :challenge_sponsors, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :challenge, :null => false
      t.belongs_to :sponsor, :null => false
      t.timestamps
    end
    add_foreign_key(:challenge_sponsors, :challenge_id, :challenges)
    add_foreign_key(:challenge_sponsors, :sponsor_id, :sponsors)
  end

  def self.down
    remove_foreign_key(:challenge_sponsors, :sponsor_id)
    remove_foreign_key(:challenge_sponsors, :challenge_id)
    drop_table :challenge_sponsors
  end
end
