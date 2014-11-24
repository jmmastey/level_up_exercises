class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :type

      t.belongs_to :section, index: true
      t.integer :position
      t.references :activity, polymorphic: true, index: true

      t.timestamps
    end
  end
end
