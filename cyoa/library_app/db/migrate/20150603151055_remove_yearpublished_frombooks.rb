class RemoveYearpublishedFrombooks < ActiveRecord::Migration
  def change
    remove_column :books, :year_published
  end
end
