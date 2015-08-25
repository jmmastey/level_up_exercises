class AddStateToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :state, :string
  end
end
