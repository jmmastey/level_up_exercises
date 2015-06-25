class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :book_id
      t.string :title
      t.string :author
      t.integer :owi_num
      t.integer :year_published

      t.timestamps null: false
    end
  end
end
