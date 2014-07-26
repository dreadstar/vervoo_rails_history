class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  validates_presence_of :user_id, :role_id, :message => "is required"

  def role_name
    return Role.find_by_id(read_attribute(:role_id)).name
  end

end
