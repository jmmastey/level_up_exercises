class PlaceLimitOnAuthorLength < ActiveRecord::Migration
  def change
    change_column :tweets, :author, :string, limit: 50
  end
end
