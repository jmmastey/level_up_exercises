class CreateUserContacts < ActiveRecord::Migration
  def change
    create_table :user_contacts do |t|
      
      t.timestamps null: false
    end
  end
end
