class CreateShowings < ActiveRecord::Migration
  def change
    create_table :showings do |t|
      t.belongs_to :event
      t.datetime :time

      t.timestamps
    end
  end
end
