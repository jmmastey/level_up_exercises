class CreateCongressionalDistricts < ActiveRecord::Migration
  def change
    create_table :congressional_districts do |t|
      t.string :zipcode
      t.string :state
      t.integer :congressional_district_id

      t.timestamps null: false

      t.index :zipcode
      t.index :state
    end
  end
end
