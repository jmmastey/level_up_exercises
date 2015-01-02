class CreatePerformersShows < ActiveRecord::Migration
  def change
    create_table :performers_shows, id: false do |t|
      t.integer :performer_id
      t.integer :show_id
    end
  end
end
