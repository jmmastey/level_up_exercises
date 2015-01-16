class AddWebsiteColumnToLegislatorsTable < ActiveRecord::Migration
  def change
    add_column :legislators, :website, :string
  end
end
