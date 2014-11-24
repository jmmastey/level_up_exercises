class CreateQuizActivities < ActiveRecord::Migration
  def change
    create_table :quiz_activities do |t|
      t.references :question, polymorphic: true, index: true

      t.timestamps
    end
  end
end
