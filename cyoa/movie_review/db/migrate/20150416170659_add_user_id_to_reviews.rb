class AddUserIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :user_id, :integer
  end
end
