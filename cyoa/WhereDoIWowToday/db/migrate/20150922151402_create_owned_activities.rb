class CreateOwnedActivities < ActiveRecord::Migration
  def change
    create_table :owned_activities do |t|
      t.references :activity, index: true
      t.references :user, index: true
      t.boolean :hidden
      t.integer :list_position

      t.timestamps null: false
    end
    add_foreign_key :owned_activities, :activities
    add_foreign_key :owned_activities, :users
  end
end
