# Create the bills table
class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :bill_id
      t.string :bill_type
      t.integer :number
      t.integer :congress
      t.string :chamber
      t.date :introduced_on
      t.date :last_action_at
      t.date :last_vote_at
      t.date :last_version_on
      t.string :official_title
      t.string :short_title
      t.string :summary
      t.string :summary_short

      t.timestamps
    end
  end
end
