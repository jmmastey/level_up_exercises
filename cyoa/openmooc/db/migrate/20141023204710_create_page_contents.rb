class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.text :content, limit: 1500
      t.text :html, limit: 3000

      t.timestamps
    end
  end
end
