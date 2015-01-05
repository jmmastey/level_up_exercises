class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.decimal :avg_price
      t.decimal :low_price
      t.decimal :high_price
      t.string :title

      t.timestamps
    end
  end
end
