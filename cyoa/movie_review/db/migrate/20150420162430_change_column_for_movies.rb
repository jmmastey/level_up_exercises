class ChangeColumnForMovies < ActiveRecord::Migration
  def change
  	change_column :movies, :release_date, :date
  end
end
