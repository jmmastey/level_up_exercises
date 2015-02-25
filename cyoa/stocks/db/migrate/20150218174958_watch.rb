class Watch < ActiveRecord::Migration
  def change
    create_join_table :users, :stocks, name => :watch do |t|
      t.index [:user_id, :stock_id]
      t.index [:stock_id, :user_id]
      t.timestamps null: false
    end
  end
end
