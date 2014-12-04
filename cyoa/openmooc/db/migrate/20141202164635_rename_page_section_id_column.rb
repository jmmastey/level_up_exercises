class RenamePageSectionIdColumn < ActiveRecord::Migration
  def change
    rename_column :pages, :section_id, :lesson_id
    rename_column :pages, :activity_id, :content_id
    rename_column :pages, :activity_type, :content_type
  end
end
