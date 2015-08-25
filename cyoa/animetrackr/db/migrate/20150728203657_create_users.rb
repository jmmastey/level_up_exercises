class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.date :join_date, :null => false, :default => Time.now

      t.timestamps null: false
    end
  end
end
