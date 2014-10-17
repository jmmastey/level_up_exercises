class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|

      t.timestamps null: false
    end
  end
end
