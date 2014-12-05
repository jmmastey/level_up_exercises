class AddDescriptionToCourses < ActiveRecord::Migration
  def change
    change_table(:courses) do |t|
      t.text :description
    end
  end
end
