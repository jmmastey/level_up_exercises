class AddUniqueLatitudeLongitude < ActiveRecord::Migration
  def change
    add_index :points, [:lat, :lon], unique: true
  end
end
