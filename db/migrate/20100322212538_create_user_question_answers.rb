require "migration_helpers"

class CreateUserQuestionAnswers < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :user_question_answers, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :user, :null => false
      t.belongs_to :user_question, :null => false
      t.belongs_to :user_question_choice, :null => true
      t.string :text_answer, :null => true, :limit => 255
      t.timestamps
    end
    add_foreign_key(:user_question_answers, :user_id, :users)
    add_foreign_key(:user_question_answers, :user_question_id, :user_questions)
    add_foreign_key(:user_question_answers, :user_question_choice_id, :user_question_choices)
  end

  def self.down
    remove_foreign_key(:user_question_answers, :user_question_choice_id)
    remove_foreign_key(:user_question_answers, :user_question_id)
    remove_foreign_key(:user_question_answers, :user_id)
    drop_table :user_question_answers
  end
end
