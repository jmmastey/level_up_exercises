class CreateContactTypes < ActiveRecord::Migration
  def change
    create_table :contact_types do |t|
      t.string :name, null: false
      t.string :type, null: false
    end
    add_index :contact_types, :name, unique: true
    add_index :contact_types, :type, unique: false
  end
end
