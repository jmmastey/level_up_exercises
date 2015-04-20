class CreateEmailContacts < ActiveRecord::Migration
  def change
    create_table :email_contacts, primary_key: :email_id do |t|
      t.string :email
      t.integer :region_id
    end
  end
end
