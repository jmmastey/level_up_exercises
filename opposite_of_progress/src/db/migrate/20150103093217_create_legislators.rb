class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string  :bioguide_id

      # Personal Details
      t.string  :first_name
      t.string  :last_name
      t.string  :middle_name
      t.string  :name_suffix

      # Representation Details
      t.string  :title
      t.string  :chamber
      t.string  :party
      t.string  :state
      t.integer :district
      t.string  :state_rank

      # Contatct Details
      t.string  :phone

      # Social Media Details
      t.string  :youtube_id
      t.string  :facebook_id
      t.string  :twitter_id

      t.timestamps
    end

    add_index :legislators, :bioguide_id, unique: true
  end
end
