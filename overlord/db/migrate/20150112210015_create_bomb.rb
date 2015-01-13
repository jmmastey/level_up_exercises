class CreateBomb < ActiveRecord::Migration
  def change
    create_table :bombs do |t|
      t.string  :activation_code, default: '1234'
      t.string  :deactivation_code, default: '0000'
      t.integer :detonation_time, default: 60
      t.integer :status
    end
  end
end
