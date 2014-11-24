class ChangingCourseToUsePagecontent < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.change :description, :text, limit: 250
      t.belongs_to :page_content, index: true
    end
  end
end
