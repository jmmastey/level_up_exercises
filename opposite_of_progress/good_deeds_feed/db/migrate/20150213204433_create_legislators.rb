class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.date :birthday
      t.string :gender
      t.string :first_name
      t.string :last_name
      t.string :state_name
      t.date :term_state
      t.date :term_end
      t.string :title
      t.string :website

      t.timestamps null: false
    end
  end
end
