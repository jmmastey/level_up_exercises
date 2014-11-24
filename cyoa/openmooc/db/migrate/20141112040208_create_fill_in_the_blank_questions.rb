class CreateFillInTheBlankQuestions < ActiveRecord::Migration
  def change
    create_table :fill_in_the_blank_questions do |t|
      t.references :page_content, index: true

      t.timestamps
    end
  end
end
