class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name
      t.text :favorite_routes
      t.text :recent_routes

      t.timestamps null: false
    end
  end
end
