class NewsletterSubscriber < ActiveRecord::Base
  validates_presence_of :email, :message => "is required"
  validates_uniqueness_of :email, :message => "is not unique"
end
