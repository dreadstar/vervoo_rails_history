class Group < ActiveRecord::Base
  has_many :group_users
  belongs_to :creator_user, :class_name => "User"
  validates_presence_of :name, :creator_user_id, :message => "is required"
end
