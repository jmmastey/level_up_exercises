class CreateBombs < ActiveRecord::Migration
  def change
    create_table :bombs do |t|
      t.string :status
      t.string :activation_code
      t.string :deactivation_code
    end
  end
end
