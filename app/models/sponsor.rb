class Sponsor < ActiveRecord::Base
  validates_presence_of :email, :name, :message => "is required"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "is invalid"
  validates_format_of :phone_number, :with => /^\d\d\d-\d\d\d-\d\d\d\d$/, :allow_nil => true, :allow_blank => true, :message => "must be of the format: ###-###-####"
  validates_format_of :postal_code, :with => /^\d{5}(-\d{4})?$/, :allow_nil => true, :allow_blank => true, :message => "must be in the form 12345 or 12345-1234"
  validates_uniqueness_of :name, :message => "is not unique"
  attr_protected :enabled
  belongs_to :user, :foreign_key => "created_by_user_id"
  has_many :challenge_sponsors
  has_many :challenges, :through => :challenge_sponsors
  has_many :sponsor_tags
  has_many :tags, :through => :sponsor_tags
  accepts_nested_attributes_for :sponsor_tags

  def image_url
    if !read_attribute(:image_url).nil? then
      if ENV['RAILS_ENV'] == "development" then
        return read_attribute(:image_url)
      elsif ENV['RAILS_ENV'] == "production" then
        return "http://images.vervue.com" + read_attribute(:image_url)
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
        return ["enabled = '1'"]
      end
    else
      return ["enabled = '1' or enabled = '0'"]
    end
  end

  def self.find_all_with_limit_and_offset(enabled, limit, offset)
    return find(:all,
                :conditions => get_enabled_conditions(enabled),
                :limit => limit,
                :offset => offset)
  end

  def self.find_all_order_by_with_limit_and_offset(column_name, asc, enabled, limit, offset)
    return find(:all,
                :conditions => get_enabled_conditions(enabled),
                :order => "#{column_name} " + asc,
                :limit => limit,
                :offset => offset)
  end

end
