require "migration_helpers"

class CreateSponsorQuestionChoices < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :sponsor_question_choices, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :sponsor_question, :null => false
      t.string :choice, :null => false, :limit => 255
      t.integer :sort_order, :null => true
    end
    add_foreign_key(:sponsor_question_choices, :sponsor_question_id, :sponsor_questions)
  end

  def self.down
    remove_foreign_key(:sponsor_question_choices, :sponsor_question_id)
    drop_table :sponsor_question_choices
  end
end
