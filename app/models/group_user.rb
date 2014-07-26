class GroupUser < ActiveRecord::Base
  validates_presence_of :group_id, :user_id, :message => "is required"
  belongs_to :group
  belongs_to :user

  def self.find_group_ids_by_user_id(user_id)
    find(:all, :select => "group_id", :conditions => [ "user_id = :u", { :u => user_id } ])
  end

end
