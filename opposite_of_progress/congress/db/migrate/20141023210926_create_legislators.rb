class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :bioguide_id
      t.date :birthday
      t.string :chamber
      t.string :party
      t.string :title
      t.date :term_start
      t.date :term_end
      t.string :gender
      t.string :first_name
      t.string :nickname
      t.string :middle_name
      t.string :last_name
      t.string :state
      t.string :twitter_id
      t.string :facebook_id

      t.timestamps
    end
  end
end
