class CreateGoodDeeds < ActiveRecord::Migration
  def change
    create_table :good_deeds do |t|

      t.timestamps
    end
  end
end
