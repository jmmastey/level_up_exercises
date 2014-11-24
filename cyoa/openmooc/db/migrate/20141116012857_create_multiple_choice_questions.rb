class CreateMultipleChoiceQuestions < ActiveRecord::Migration
  def change
    create_table :multiple_choice_questions do |t|
      t.references :page_content, index: true

      t.timestamps
    end
  end
end
