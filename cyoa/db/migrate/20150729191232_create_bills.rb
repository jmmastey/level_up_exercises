class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :bill_id
      t.string :bill_type
      t.string :chamber
      t.integer :congress
      t.integer :cosponsors_count
      t.date :introduced_on
      t.string :official_title
      t.string :popular_title
      t.string :short_title
      t.text :summary_short
      t.string :url
      t.date :last_action_at
      t.string :last_action_type
      t.text :last_action_text
      t.string :last_version_pdf
      t.integer :legislator_id

      t.timestamps null: false
    end
  end
end
