class AddDefaultToRecommendations < ActiveRecord::Migration
  def up
    change_column(:recommendations, :recommended, :boolean, default: false)
  end

  def down
    change_column(:recommendations, :recommended, :boolean, default:  nil)
  end
end
