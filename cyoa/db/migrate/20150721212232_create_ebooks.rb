class CreateEbooks < ActiveRecord::Migration
  def change
    create_table :ebooks do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :version
      t.text :url
      t.boolean :generated
      t.string :language
      t.string :publisher
      t.string :subject
      t.string :rights
      t.boolean :readability
      t.text :markdown
      t.binary :epub

      t.timestamps null: false
    end
  end
end
