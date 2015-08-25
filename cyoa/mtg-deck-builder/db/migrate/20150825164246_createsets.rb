class Createsets < ActiveRecord::Migration
  def change
    create_table :sets do |t|
      t.string :set_id
      t.string :name
      t.string :set_type
    end
  end
end
