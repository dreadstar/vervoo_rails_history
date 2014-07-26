class ChallengeSponsor < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :sponsor
end
