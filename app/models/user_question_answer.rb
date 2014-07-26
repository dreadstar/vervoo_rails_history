class UserQuestionAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_question
  belongs_to :user_question_choice
  validates_presence_of :user_id, :user_question_id, :message => "is required"
end
