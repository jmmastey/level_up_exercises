class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.string :location
      t.time :time
      t.date :date

      t.timestamps
    end
  end
end
