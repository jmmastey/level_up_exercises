class AddUrlColumnToLegislatorsTable < ActiveRecord::Migration
  def change
    add_column :legislators, :url, :string
  end
end
