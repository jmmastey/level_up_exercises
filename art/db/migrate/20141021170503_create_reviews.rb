class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, index: true
      t.references :performance, index: true
      t.integer :rating
      t.text :review

      t.timestamps
    end
  end
end
