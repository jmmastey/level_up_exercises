class CreateBillTags < ActiveRecord::Migration
  def change
    create_table :bill_tags do |t|
      t.integer :bill_id, null: false
      t.integer :tag_id, null: false

      t.timestamps null: false
    end
  end
end
