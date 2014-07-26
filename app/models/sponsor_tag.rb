class SponsorTag < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :tag
end
