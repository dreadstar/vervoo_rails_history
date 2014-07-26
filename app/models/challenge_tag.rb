class ChallengeTag < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :tag
end
