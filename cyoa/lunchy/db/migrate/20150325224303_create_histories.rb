class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.date :visited
      t.references :venue, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
