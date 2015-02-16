class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :name
      t.datetime :start
      t.datetime :end
      t.references :forecast, index: true

      t.timestamps null: false
    end
    add_foreign_key :periods, :forecasts
  end
end
