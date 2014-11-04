class AddFieldsToShow < ActiveRecord::Migration
  def change
    add_column :shows, :year, :integer
    add_column :shows, :director, :string
    add_column :shows, :location, :string
    add_column :shows, :theatre_company, :string
    add_column :shows, :notes, :text
  end
end
