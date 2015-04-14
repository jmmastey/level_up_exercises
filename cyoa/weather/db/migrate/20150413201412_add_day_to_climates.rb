class AddDayToClimates < ActiveRecord::Migration
  def change
    add_column :climates, :day, :string
  end
end
