class CreateContactTypes < ActiveRecord::Migration
  def change
    create_table :contact_types do |t|
      t.string :name, null: false, index: :unique, limit: 30
      t.string :type, null: false, index: true,    limit: 10
    end
  end
end
