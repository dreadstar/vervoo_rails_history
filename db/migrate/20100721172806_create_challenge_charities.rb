require "migration_helpers"

class CreateChallengeCharities < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :challenge_charities, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :challenge, :null => false
      t.belongs_to :charity, :null => false
      t.timestamps
    end
    add_foreign_key(:challenge_charities, :challenge_id, :challenges)
    add_foreign_key(:challenge_charities, :charity_id, :charities)
  end

  def self.down
    remove_foreign_key(:challenge_charities, :charity_id)
    remove_foreign_key(:challenge_charities, :challenge_id)
    drop_table :challenge_charities
  end
end
