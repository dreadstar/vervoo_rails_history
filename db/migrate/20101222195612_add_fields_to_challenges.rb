class AddFieldsToChallenges < ActiveRecord::Migration
  def self.up
    change_table :challenges do |t|
      t.string :challenge_img, :null => true, :limit => 512
      t.decimal :total_offer, :null => true, :precision => 10, :scale => 2
      t.decimal :amount_raised, :null => true, :precision => 10, :scale => 2
      t.string :sponsor_blurb, :limit => 512
      t.string :charity_blurb, :limit => 512
      t.boolean :enabled, :default => false
    end
  end

  def self.down
    change_table :challenges do |t|
      t.remove :challenge_img, :total_offer, :amount_raised, :sponsor_blurb, :charity_blurb, :enabled
    end
  end
end
