require "migration_helpers"

class CreateChallengeUsers < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :challenge_users, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :challenge, :null => false
      t.belongs_to :user, :null => false
      t.timestamps
    end
    add_foreign_key(:challenge_users, :challenge_id, :challenges)
    add_foreign_key(:challenge_users, :user_id, :users)
  end

  def self.down
    remove_foreign_key(:challenge_users, :user_id)
    remove_foreign_key(:challenge_users, :challenge_id)
    drop_table :challenge_users
  end
end
