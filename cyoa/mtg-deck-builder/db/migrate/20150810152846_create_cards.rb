class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string  :name
      t.integer :cmc
      t.string  :cost
      t.string  :colors
      t.string  :types
      t.string  :supertypes
      t.string  :subtypes
      t.text    :text 
      t.integer :power
      t.integer :toughness
      t.string  :image_url
    end
  end
end
