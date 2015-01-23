class CreateUserContacts < ActiveRecord::Migration
  def change
    create_table :user_contacts do |t|
      t.integer     :user_id,         null: false
      t.integer     :contact_type_id, null: false
      t.string      :contact,         null: false, limit: 100
      t.timestamps                    null: false
      
    end
  end
end
