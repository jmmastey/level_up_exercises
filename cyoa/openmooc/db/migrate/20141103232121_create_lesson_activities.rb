class CreateLessonActivities < ActiveRecord::Migration
  def change
    create_table :lesson_activities do |t|
      t.belongs_to :page_content, index: true

      t.timestamps
    end
  end
end
