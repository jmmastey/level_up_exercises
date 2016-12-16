class AddUserProfile < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string  :last_name
      t.string  :first_name
      t.string  :phone
      t.string  :about
      t.references :location
      t.boolean :profile_visible, default: false
    end
  end
end
