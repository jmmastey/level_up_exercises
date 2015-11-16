class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :external_id
      t.string :name, required: true
      t.string :phone
      t.string :description
      t.references :location
      t.decimal :minimum_pickup
      t.decimal :minimum_delivery
      t.decimal :maximum_pickup
      t.decimal :maximum_delivery

      t.timestamps null: false
    end
  end
end
