class RenameTableLessonActivitiesToContents < ActiveRecord::Migration
  def change
    rename_table :lesson_activities, :contents
  end
end
