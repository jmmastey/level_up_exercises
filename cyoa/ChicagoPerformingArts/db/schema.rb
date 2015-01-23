# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150113192712) do
  create_table "events", force: true do |t|
      t.integer     "id"
      t.text        "placename"
      t.text        "cityname"
      t.timestamps  "activity_start_date"
      t.timestamps  "activity_end_date"
      t.text        "sales_status"
      t.text        "registration_url_adr"
    end
    execute "alter table events add CONSTRAINT events_pkey PRIMARY KEY (id)"
  end
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  end
end
