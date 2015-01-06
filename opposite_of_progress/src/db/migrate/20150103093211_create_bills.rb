class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string      :bill_type
      t.string      :chamber
      t.integer     :congress
      t.integer     :number
      t.string      :url
      t.text        :summary
      t.boolean     :enacted
      t.datatime    :enacted_at
      t.datetime    :introduced_on
      t.datetime    :last_action_at
      t.timestamps
    end
  end
end
