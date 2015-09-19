class AddListPostionToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :list_position, :integer
  end
end
