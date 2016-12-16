class CreateBillTags < ActiveRecord::Migration
  def change
    create_table :bill_tags do |t|
      t.integer :bill_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
