class RemoveYearFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :year, :string
  end
end
