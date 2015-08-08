class CreateLibraryItems < ActiveRecord::Migration
  def change
    create_table :library_items do |t|
      t.string :view_status
      t.integer :user_rating
      t.boolean :public
      t.belongs_to :anime
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
