class RenameUserBillsToBookmarks < ActiveRecord::Migration
  def change
    rename_table :user_bills, :bookmarks
  end
end
