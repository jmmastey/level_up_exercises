class CreateFavoriteLegislators < ActiveRecord::Migration
  def change
    create_table :favorite_legislators do |t|
      t.belongs_to :user
      t.belongs_to :legislator
      t.timestamps
    end
  end
end
