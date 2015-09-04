class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.integer :month
      t.integer :year
      t.integer :user_id
      t.text :options

      t.timestamps null: false
    end
  end
end
