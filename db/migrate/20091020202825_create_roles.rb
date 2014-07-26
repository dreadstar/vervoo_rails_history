class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.string :name, :null => false, :limit => 50
    end
  end

  def self.down
    drop_table :roles
  end
end
