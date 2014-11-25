class AddSponsorIdToBills < ActiveRecord::Migration
  def change
    add_column :bills, :sponsor_id, :string
  end
end
