class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.string :iso, :null => false, :limit => 3
      t.string :name, :null => false, :limit => 80
      t.string :printable_name, :null => false, :limit => 80
      t.string :iso3, :null => true, :limit => 3
      t.string :numcode, :null => true, :limit => 3
    end
  end

  def self.down
    drop_table :countries
  end
end
