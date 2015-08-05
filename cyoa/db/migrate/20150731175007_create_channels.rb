class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|

      t.timestamps null: false
      t.string :name
    end
  end
end
