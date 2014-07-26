class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.string :email, :null => false, :limit => 100
      t.string :password, :null => false, :limit => 50
      t.boolean :enabled, :default => 0
      t.string :first_name, :null => true, :limit => 50
      t.string :middle_name, :null => true, :limit => 50
      t.string :last_name, :null => true, :limit => 50
      t.string :nickname, :null => true, :limit => 50
      t.date :date_of_birth, :null => true
      t.string :address1, :null => true, :limit => 50
      t.string :address2, :null => true, :limit => 50
      t.string :city, :null => true, :limit => 100
      t.string :state, :null => true, :limit => 2
      t.string :province, :null => true, :limit => 50
      t.string :postal_code, :null => true, :limit => 10
      t.string :country, :null => true, :limit => 3
      t.string :gender, :null => true, :limit => 1
      t.string :phone_number, :null => true, :limit => 15
      t.string :image_url, :null => true, :limit => 255
      t.string :ip_address, :null => true, :limit => 16
      t.datetime :last_login, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
