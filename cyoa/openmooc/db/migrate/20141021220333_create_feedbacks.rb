class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :user, index: true
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
