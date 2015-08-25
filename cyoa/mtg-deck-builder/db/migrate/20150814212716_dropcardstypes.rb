class Dropcardstypes < ActiveRecord::Migration
  def change
    drop_table :cards_types
  end
end
