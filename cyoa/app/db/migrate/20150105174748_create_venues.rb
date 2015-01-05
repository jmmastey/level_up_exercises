class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :city
      t.string :address
      t.string :url

      t.timestamps
    end
  end
end
