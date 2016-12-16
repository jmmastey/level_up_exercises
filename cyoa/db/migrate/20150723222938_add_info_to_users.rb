class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zipcode, :string
    add_column :users, :political_party, :string
  end
end
