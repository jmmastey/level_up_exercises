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

ActiveRecord::Schema.define(version: 20141015224825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airports", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
  end

  create_table "flights", force: true do |t|
    t.integer  "destination_airport_id"
    t.integer  "origin_airport_id"
    t.datetime "origin_date_time"
    t.datetime "destination_date_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flights_trips", id: false, force: true do |t|
    t.integer "trip_id",   null: false
    t.integer "flight_id", null: false
  end

  add_index "flights_trips", ["trip_id"], name: "index_flights_trips_on_trip_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: true do |t|
    t.datetime "start"
    t.decimal  "length"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
  end

  create_table "meetings_trips", id: false, force: true do |t|
    t.integer "trip_id",    null: false
    t.integer "meeting_id", null: false
  end

  add_index "meetings_trips", ["trip_id"], name: "index_meetings_trips_on_trip_id", using: :btree

  create_table "trips", force: true do |t|
    t.integer  "home_location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
