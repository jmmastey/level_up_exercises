class CreateRegions < ActiveRecord::Migration
  def up
    create_table :regions, primary_key: :region_id do |t|
      t.string  :country
      t.string  :state
    end
  end

  def down
  end
end
