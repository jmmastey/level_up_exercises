class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :location
      t.text :link
      t.boolean :haveapplied
      t.string :company
      t.boolean :interested
      t.string :referred

      t.timestamps
    end
  end
end
