class CharityQuestionChoice < ActiveRecord::Base
  belongs_to :charity_question
  validates_presence_of :charity_question_id, :message => "is required"
end
