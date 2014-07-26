class ChallengeCharity < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :charity
end
