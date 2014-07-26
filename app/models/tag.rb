class Tag < ActiveRecord::Base
  validates_uniqueness_of :name, :message => "is not unique"
  has_many :activity_tags
  has_many :activities, :through => :activity_tags
  has_many :challenge_tags
  has_many :challenges, :through => :challenge_tags
  has_many :charity_tags
  has_many :charities, :through => :charity_tags
  has_many :sponsor_tags
  has_many :sponsor, :through => :sponsor_tags
end
