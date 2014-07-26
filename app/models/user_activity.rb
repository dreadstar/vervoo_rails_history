require "json"

class UserActivity < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge_activity
  #serialize :activity_data, Hash

  before_save :json_serialize
  after_save  :json_deserialize

  def json_serialize
    #if !read_attribute(:activity_data).nil? && read_attribute(:activity_data) != "" then
    if !self.activity_data.nil? && self.activity_data != "" then
      self.activity_data = self.activity_data.to_json
    end
  end

  def json_deserialize
    if !self.activity_data.nil? && self.activity_data != "" then
      self.activity_data = JSON.parse(self.activity_data)
    end
  end

  def after_find
    json_deserialize
  end

  def self.find_all_by_user_id_and_challenge(user_id, challenge)
    return find(:all,
                :conditions => [ "user_id = :ui and challenge_activity_id in (:ais)", { :ui => user_id, :ais => challenge.challenge_activity_ids } ])
  end

end
