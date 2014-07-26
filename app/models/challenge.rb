class Challenge < ActiveRecord::Base
  validates_uniqueness_of :name, :message => "is not unique"
  attr_protected :enabled
  belongs_to :user, :foreign_key => "created_by_user_id"
  has_many :challenge_charities
  has_many :charities, :through => :challenge_charities
  has_many :challenge_sponsors
  has_many :sponsors, :through => :challenge_sponsors
  has_many :challenge_activities
  has_many :activities, :through => :challenge_activities
  has_many :challenge_users
  has_many :users, :through => :challenge_users
  has_many :user_activities, :through => :challenge_activities
  has_many :challenge_tags
  has_many :tags, :through => :challenge_tags
  accepts_nested_attributes_for :challenge_charities
  accepts_nested_attributes_for :challenge_sponsors
  accepts_nested_attributes_for :challenge_activities
  accepts_nested_attributes_for :challenge_tags

  ###############################################################
  ## Define shortcut methods to make things easier in the view ##
  ###############################################################
  def challenge_img
    if !read_attribute(:challenge_img).nil? then
      if ENV['RAILS_ENV'] == "development" then
        return read_attribute(:challenge_img)
      elsif ENV['RAILS_ENV'] == "production" then
        return "http://images.vervue.com" + read_attribute(:challenge_img)
      end
    end
  end
  
   def img_thumb_url
    if !read_attribute(:img_thumb_url).nil? then
      if ENV['RAILS_ENV'] == "development" then
        return read_attribute(:img_thumb_url)
      elsif ENV['RAILS_ENV'] == "production" then
        return "http://images.vervue.com" + read_attribute(:img_thumb_url)
      end
    end
  end

  def self.get_enabled_conditions(enabled)
    if !enabled.nil? && enabled != "" then
      if enabled == true
        return [ "enabled = '1'" ]
      end
    else
      return [ "enabled = '1' or enabled = '0'" ]
    end
  end

  def self.find_all_with_limit_and_offset(enabled, limit, offset)
    return find(:all,
                :conditions => get_enabled_conditions(enabled),
                :limit => limit,
                :offset => offset )
  end

  def self.find_all_order_by_with_limit_and_offset(column_name, asc, enabled, limit, offset)
    return find(:all,
                :conditions => get_enabled_conditions(enabled),
                :order => "#{column_name} " + asc,
                :limit => limit,
                :offset => offset )
  end

  def self.find_all_order_by_challenge_activities_date(enabled, asc, limit, offset)
    return find(:all,
                :include => [ :challenge_activities, :user_activities ],
                :conditions => get_enabled_conditions(enabled),
                :group => "user_activities.challenge_activity_id",
                :order => "user_activities.created_at " + asc,
                :limit => limit,
                :offset => offset)
  end

end
