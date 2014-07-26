require "migration_helpers"

class CreateUserQuestionChoices < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :user_question_choices, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.belongs_to :user_question, :null => false
      t.string :choice, :null => false, :limit => 255
      t.integer :sort_order, :null => true
    end
    add_foreign_key(:user_question_choices, :user_question_id, :user_questions)
  end

  def self.down
    remove_foreign_key(:user_question_choices, :user_question_id)
    drop_table :user_question_choices
  end
end
