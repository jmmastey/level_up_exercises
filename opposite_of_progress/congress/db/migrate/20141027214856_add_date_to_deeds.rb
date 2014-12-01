# Add date to deeds
class AddDateToDeeds < ActiveRecord::Migration
  def change
    add_column :deeds, :date, :date
  end
end
