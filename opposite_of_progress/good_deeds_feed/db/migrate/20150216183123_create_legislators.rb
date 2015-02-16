class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :party
      t.string :state
      t.string :gender
      t.string :website
      t.string :twitter_id
      t.date :birthdate

      t.timestamps null: false
    end
  end
end
