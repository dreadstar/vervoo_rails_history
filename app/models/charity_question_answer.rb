class CharityQuestionAnswer < ActiveRecord::Base
  belongs_to :charity
  belongs_to :charity_question
  belongs_to :charity_question_choice
  validates_presence_of :charity_id, :charity_question_id, :message => "is required"
end
