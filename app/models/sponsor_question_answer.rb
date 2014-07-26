class SponsorQuestionAnswer < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :sponsor_question
  belongs_to :sponsor_question_choice
  validates_presence_of :sponsor_id, :sponsor_question_id, :message => "is required"
end
