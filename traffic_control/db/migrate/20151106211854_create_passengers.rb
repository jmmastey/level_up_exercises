class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :seating_preference
      t.string :meal_preference

      t.timestamps null: false
    end
  end
end
