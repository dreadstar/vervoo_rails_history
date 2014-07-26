require 'active_record/fixtures'

class LoadCountriesData < ActiveRecord::Migration
  def self.up
    directory = File.join(File.dirname(__FILE__), "data")
    Fixtures.create_fixtures(directory, "countries")
  end

  def self.down
    Country.delete_all
  end
end
