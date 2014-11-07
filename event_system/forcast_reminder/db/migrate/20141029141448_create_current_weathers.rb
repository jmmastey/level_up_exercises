class CreateCurrentWeathers < ActiveRecord::Migration
  def change
    create_table :current_weathers do |t|
      t.integer :zip_code
      t.float :temperature
      t.string :conditions

      t.timestamps null: false
    end
  end
end
