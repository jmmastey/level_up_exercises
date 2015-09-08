class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :location
      t.date :date
      t.text :description
      t.decimal :amount
      t.string :category
      t.integer :term_id
      t.string :how_paid
      t.string :type

      t.timestamps null: false
    end
  end
end
