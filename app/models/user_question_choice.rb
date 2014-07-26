class UserQuestionChoice < ActiveRecord::Base
  belongs_to :user_question
  validates_presence_of :user_question_id, :message => "is required"
end
