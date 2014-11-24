class CreateAliases < ActiveRecord::Migration
  def change
    create_table :aliases do |t|
      t.string :text
      t.belongs_to :fill_in_the_blank_answer, index: true

      t.timestamps
    end
  end
end
