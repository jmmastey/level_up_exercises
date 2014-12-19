# Add enacted to bills
class AddEnactedAtToBills < ActiveRecord::Migration
  def change
    add_column :bills, :enacted_at, :date
  end
end
