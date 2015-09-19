class AddHiddenToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :hidden, :boolean, null: false, default: false
  end
end
