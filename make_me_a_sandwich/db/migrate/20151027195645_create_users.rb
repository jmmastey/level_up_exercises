class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :external_id, unique: true, index: true, required: true
      t.string :email
      t.string :last_name
      t.string :first_name
    end
  end
end
