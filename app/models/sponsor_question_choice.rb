class SponsorQuestionChoice < ActiveRecord::Base
  belongs_to :sponsor_question
  validates_presence_of :sponsor_question_id, :message => "is required"
end
