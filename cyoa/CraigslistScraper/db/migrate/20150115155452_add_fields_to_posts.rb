class AddFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :bedrooms, :integer
    add_column :posts, :bathrooms, :decimal
    add_column :posts, :sqft, :integer
    add_column :posts, :cats, :string
    add_column :posts, :dogs, :string
    add_column :posts, :w_d_in_unit, :string
    add_column :posts, :street_parking, :string
  end
end
