class CreateRealms < ActiveRecord::Migration
  def change
    create_table :realms do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
