class Role < ActiveRecord::Base
  validates_presence_of :name, :message => "is required"
  has_many :user_roles
end
