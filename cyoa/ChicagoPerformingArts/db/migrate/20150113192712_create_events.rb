class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, id: false do |t|
      t.integer :id
      t.text :placename
      t.text :cityname
      t.timestamps :activity_start_date
      t.timestamps :activity_end_date
      t.text :sales_status
      t.text :registration_url_adr
    end
    execute "alter table events add CONSTRAINT events_pkey PRIMARY KEY (id)"
  end
end
