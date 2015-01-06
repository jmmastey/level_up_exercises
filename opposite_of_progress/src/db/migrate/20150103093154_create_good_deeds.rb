class CreateGoodDeeds < ActiveRecord::Migration
  def change
    create_table :good_deeds do |t|
      t.string     :action
      t.belongs_to :bill
      t.belongs_to :legislator
      t.string     :chamber
      t.string     :text
      t.date       :acted_at
      t.timestamps
    end
  end
end
