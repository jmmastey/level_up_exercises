class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.datetime :start
      t.decimal :length
      t.references :airport, index: true

      t.timestamps
    end
  end
end
