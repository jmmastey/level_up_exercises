class CreateClimates < ActiveRecord::Migration
  def change
    create_table :climates do |t|
      t.timestamp :date
      t.decimal :max_temp
      t.decimal :min_temp
      t.decimal :precipitation_probability
      t.string :precipitation_type
      t.decimal :humidity
      t.string :summary

      t.timestamps null: false
    end
  end
end
