class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.references :venue, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
