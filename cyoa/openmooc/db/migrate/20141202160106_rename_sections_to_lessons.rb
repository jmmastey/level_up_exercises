class RenameSectionsToLessons < ActiveRecord::Migration
  def change
    rename_table :sections, :lessons
  end
end
