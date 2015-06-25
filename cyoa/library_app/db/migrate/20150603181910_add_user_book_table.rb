class AddUserBookTable < ActiveRecord::Migration
  def change
    create_join_table :books, :users
  end
end
