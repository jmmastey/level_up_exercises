class RemoveJoinTableUserEvent < ActiveRecord::Migration
  def change
    drop_join_table :users, :events do |t|
    end
  end
end
