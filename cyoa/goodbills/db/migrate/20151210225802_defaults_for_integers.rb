class DefaultsForIntegers < ActiveRecord::Migration
  def change
    change_column :bills, :score, :integer, :default => 0
    change_column :bills, :num_voted, :integer, :default => 0
  end
end
