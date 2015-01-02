class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :date
      t.references :artist, index: true

      t.timestamps null: false
    end
  end
end
