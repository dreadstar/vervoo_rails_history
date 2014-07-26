require "migration_helpers"

class CreateSponsorQuestionAnswers < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :sponsor_question_answers, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :sponsor, :null => false
      t.belongs_to :sponsor_question, :null => false
      t.belongs_to :sponsor_question_choice, :null => true
      t.string :text_answer, :null => true, :limit => 255
      t.timestamps
    end
    add_foreign_key(:sponsor_question_answers, :sponsor_id, :sponsors)
    add_foreign_key(:sponsor_question_answers, :sponsor_question_id, :sponsor_questions)
    add_foreign_key(:sponsor_question_answers, :sponsor_question_choice_id, :sponsor_question_choices)
  end

  def self.down
    remove_foreign_key(:sponsor_question_answers, :sponsor_question_choice_id)
    remove_foreign_key(:sponsor_question_answers, :sponsor_question_id)
    remove_foreign_key(:sponsor_question_answers, :sponsor_id)
    drop_table :sponsor_question_answers
  end
end
