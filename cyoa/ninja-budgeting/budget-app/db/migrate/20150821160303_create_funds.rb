class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.string :name
      t.decimal :amount
      t.text :components

      t.timestamps null: false
    end
  end
end
