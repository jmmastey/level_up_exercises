class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.string :venue_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
