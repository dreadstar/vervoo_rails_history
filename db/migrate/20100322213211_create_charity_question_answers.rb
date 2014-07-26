require "migration_helpers"

class CreateCharityQuestionAnswers < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :charity_question_answers, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :charity, :null => false
      t.belongs_to :charity_question, :null => false
      t.belongs_to :charity_question_choice, :null => true
      t.string :text_answer, :null => true, :limit => 255
      t.timestamps
    end
    add_foreign_key(:charity_question_answers, :charity_id, :charities)
    add_foreign_key(:charity_question_answers, :charity_question_id, :charity_questions)
    add_foreign_key(:charity_question_answers, :charity_question_choice_id, :charity_question_choices)
  end

  def self.down
    remove_foreign_key(:charity_question_answers, :charity_question_choice_id)
    remove_foreign_key(:charity_question_answers, :charity_question_id)
    remove_foreign_key(:charity_question_answers, :charity_id)
    drop_table :charity_question_answers
  end
end
