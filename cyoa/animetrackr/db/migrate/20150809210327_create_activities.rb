class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :activity
      t.belongs_to :library_item, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
