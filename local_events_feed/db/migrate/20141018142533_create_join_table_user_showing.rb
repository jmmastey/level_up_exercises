class CreateJoinTableUserShowing < ActiveRecord::Migration
  def change
    create_join_table :users, :showings do |t|
      # t.index [:user_id, :showing_id]
      # t.index [:showing_id, :user_id]
    end
  end
end
