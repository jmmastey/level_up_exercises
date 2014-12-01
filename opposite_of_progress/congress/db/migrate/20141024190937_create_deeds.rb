# Create the deeds table
class CreateDeeds < ActiveRecord::Migration
  def change
    create_table :deeds do |t|
      t.string :bioguide_id
      t.string :bill_id
      t.string :deed

      t.timestamps
    end
  end
end
