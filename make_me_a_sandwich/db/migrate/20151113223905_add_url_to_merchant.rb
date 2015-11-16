class AddUrlToMerchant < ActiveRecord::Migration
  def change
    change_table :merchants do |t|
      t.string :website_url
      t.string :menu_url
    end
  end
end
