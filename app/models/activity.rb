class Activity < ActiveRecord::Base
  validates_presence_of :name, :message => "is required"
  attr_protected :enabled
  belongs_to :user, :foreign_key => "created_by_user_id"
  has_many :challenge_activities
  has_many :challenges, :through => :challenge_activities
  has_many :activity_tags
  has_many :tags, :through => :activity_tags
  accepts_nested_attributes_for :activity_tags
end
