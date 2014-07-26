class ChallengeActivity < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :activity
  has_many :user_activities

  def activity_name
    return Activity.find_by_id(read_attribute(:activity_id)).name
  end

end
