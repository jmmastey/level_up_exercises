class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :book_id
      t.binary :comment

      t.timestamps null: false
    end
  end
end
