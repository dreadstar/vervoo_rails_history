require 'active_record/fixtures'

class LoadStatesData < ActiveRecord::Migration
  def self.up
    directory = File.join(File.dirname(__FILE__), "data")
    Fixtures.create_fixtures(directory, "states")
  end

  def self.down
    State.delete_all
  end
end
