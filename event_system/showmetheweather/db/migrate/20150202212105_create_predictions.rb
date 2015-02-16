class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.string :label
      t.string :value
      t.references :period, index: true

      t.timestamps null: false
    end
    add_foreign_key :predictions, :periods
  end
end
