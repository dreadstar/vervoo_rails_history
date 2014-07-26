class CreateSponsorQuestions < ActiveRecord::Migration
  def self.up
    create_table :sponsor_questions, :options => 'CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=InnoDB' do |t|
      t.string :question, :null => false, :limit => 255
      t.string :question_type, :null => false, :limit => 10
      t.boolean :active, :default => 0
    end
  end

  def self.down
    drop_table :sponsor_questions
  end
end
