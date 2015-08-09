class CreateDeckTable < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :decks, [:user_id, :created_at]
  end
end
