class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
