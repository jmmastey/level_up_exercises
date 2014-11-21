class AddUniquenessIndexToEvents < ActiveRecord::Migration
  def change
    add_index :events, [:name, :location, :link], :unique => true
  end
end
