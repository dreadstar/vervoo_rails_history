require "migration_helpers"

class CreateCharityQuestionChoices < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :charity_question_choices, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :charity_question, :null => false
      t.string :choice, :null => false, :limit => 255
      t.integer :sort_order, :null => true
    end
    add_foreign_key(:charity_question_choices, :charity_question_id, :charity_questions)
  end

  def self.down
    remove_foreign_key(:charity_question_choices, :charity_question_id)
    drop_table :charity_question_choices
  end
end
