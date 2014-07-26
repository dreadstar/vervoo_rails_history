class AddHashedPasswordToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :hashed_password, :null => true, :length => 50
      t.string :salt, :null => true, :length => 50
    end
  end
  
  def self.down
    change_table :users do |t|
      t.remove :hashed_password, :salt
    end
  end
end
