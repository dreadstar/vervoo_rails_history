class CreateNewsletterSubscribers < ActiveRecord::Migration

  def self.up
    create_table :newsletter_subscribers, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.string :email, :null => false, :limit => 100
      t.string :first_name, :null => true, :limit => 50
      t.string :last_name, :null => true, :limit => 50
      t.string :address1, :null => true, :limit => 50
      t.string :address2, :null => true, :limit => 50
      t.string :city, :null => true, :limit => 100
      t.string :state, :null => true, :limit => 2
      t.string :province, :null => true, :limit => 50
      t.string :postal_code, :null => true, :limit => 10
      t.string :country, :null => true, :limit => 3
      t.string :subscriber_type, :null => true, :limit => 10
      t.timestamps
    end
  end

  def self.down
    drop_table :newsletter_subscribers
  end
end
