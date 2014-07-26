class User < ActiveRecord::Base
  validates_presence_of :email, :if => :not_openid?, :message => "is required"
  validates_presence_of :password, :if => :not_openid?, :message => "is required"
  validates_presence_of :password_confirmation, :if => :not_openid?, :message => "is required"
  validates_presence_of :salt, :if => :not_openid?, :message => "is required"
  validates_confirmation_of :password, :if => :not_openid?
  validates_uniqueness_of :email, :if => :not_openid?, :message => "is not unique", :allow_nil => true
  validates_format_of :email, :if => :not_openid?, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  validates_length_of :password, :within => 5..40, :if => :not_openid?

  #validates_presence_of :email, :message => "is required"
  #validates_presence_of :password, :if => :password_required?, :message => "is required"
  #validates_presence_of :password_confirmation, :if => :password_required?, :message => "is required"
  #validates_presence_of :salt, :if => :password_required?, :message => "is required"
  #validates_confirmation_of :password, :if => :password_required?
  #validates_uniqueness_of :email, :message => "is not unique"
  #validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  #validates_length_of :password, :within => 5..40, :if => :password_required?

  attr_protected :id, :enabled, :salt
  attr_accessor :password, :password_confirmation, :hashed_confirmation
  has_many :user_roles
  has_many :roles, :through => :user_roles
  has_many :challenge_users
  has_many :challenges, :through => :challenge_users
  accepts_nested_attributes_for :user_roles

  def password_confirmation=(new_password_confirmation)  
    @password_confirmation = new_password_confirmation
  end

  def not_openid?
    identity_url.blank?
  end

  def password_required?
    not_openid? && (crypted_password.blank? or not password.blank?)
  end

  def image_url
    if ENV['RAILS_ENV'] == "development" then
      return read_attribute(:image_url)
    elsif ENV['RAILS_ENV'] == "production" then
      return "http://images.vervue.com" + read_attribute(:image_url)
    end
  end

  def short_image_url
    str = read_attribute(:image_url)
    if !str.nil? then
      return str[str.index("/uploads"), str.length]
    else
      return nil
    end
  end

  def self.random_string(len)
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  def password=(pass)
    @password = pass
    self.salt = User.random_string(10) if !self.salt?
    self.hashed_password = User.encrypt(@password, self.salt)
  end

  def before_save
    self.hashed_password = User.encrypt(password, self.salt) if !self.password.blank?
  end
  def password_required?
    self.hashed_password.blank? || !self.password.blank?
  end

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifier.deliver_forgot_password(self.email, new_pass)
  end

  def self.authenticate(email, password)
    user = find(:first, :conditions => { :email => email })
    if user.nil? then
      return nil
    else
      user.update_attribute(:last_login, DateTime.now)
      if !user.salt? then
        user.update_attribute(:salt, User.random_string(10) )
      end
      if !user.hashed_password then
        user.update_attribute(:hashed_password, User.encrypt(password, user.salt) )
      end
      if User.encrypt(password, user.salt) == user.hashed_password then
        return user
      else
        return nil
      end
    end
  end

end
