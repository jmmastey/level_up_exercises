class CreateFillInTheBlankAnswers < ActiveRecord::Migration
  def change
    create_table :fill_in_the_blank_answers do |t|
      t.string :text
      t.belongs_to :fill_in_the_blank_question
      t.index :fill_in_the_blank_question_id, name: :fitb_answer_belongs_to_fill_in_the_blank_question_index

      t.timestamps
    end
  end
end
