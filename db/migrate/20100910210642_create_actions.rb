class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.string :name, :null => false, :limit => 50
      t.string :description, :null => false, :limit => 500
      t.timestamps
    end
  end

  def self.down
    drop_table :actions
  end
end
