class AddUpdatedAtIndex < ActiveRecord::Migration
  def change
    add_index :events, :updated_at
  end
end
