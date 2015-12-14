class ScoringForBills < ActiveRecord::Migration
  def change
    add_column :bills, :score, :number
    add_column :bills, :num_voted, :number
    add_index :bills, :score
    add_index :bills, :num_voted
  end
end
