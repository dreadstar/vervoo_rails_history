require 'active_record/fixtures'

class LoadRolesDatas < ActiveRecord::Migration
  def self.up
    directory = File.join(File.dirname(__FILE__), "data")
    Fixtures.create_fixtures(directory, "roles")
  end

  def self.down
    Role.delete_all
  end
end
