class AddSeoNameToTables < ActiveRecord::Migration
  def self.up
    add_column :charities, :seo_name, :string, :length => 100
    add_column :challenges, :seo_name, :string, :length => 100
    add_column :sponsors, :seo_name, :string, :length => 100
  end

  def self.down
    add_column :sponsors, :seo_name
    add_column :challenges, :seo_name
    add_column :charities, :seo_name
  end
end
