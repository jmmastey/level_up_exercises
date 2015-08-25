class CreateBillActions < ActiveRecord::Migration
  def change
    create_table :bill_actions do |t|
      t.string :text
      t.date :date
      t.integer :bill_id

      t.timestamps null: false
      t.index :created_at
    end
  end
end
