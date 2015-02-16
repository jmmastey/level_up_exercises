class CreateGoodDeeds < ActiveRecord::Migration
  def change
    create_table :good_deeds do |t|
      t.integer :congress_number
      t.string :congress_url
      t.text :official_title
      t.date :introduced_on
      t.references :legislator, index: true

      t.timestamps null: false
    end
    add_foreign_key :good_deeds, :legislators
  end
end
