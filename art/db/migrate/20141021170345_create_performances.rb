class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.references :show, index: true
      t.date :performed_on

      t.timestamps
    end
  end
end
