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

ActiveRecord::Schema.define(version: 20151123200450) do

  create_table "airports", force: :cascade do |t|
    t.string   "code",       limit: 3
    t.string   "city",       limit: 20
    t.integer  "capacity"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "components", force: :cascade do |t|
    t.string   "name",       limit: 100
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "flights", force: :cascade do |t|
    t.integer  "plane_id"
    t.datetime "departure_time"
    t.string   "departure_airport", limit: 3
    t.datetime "arrival_time"
    t.string   "arrival_airport",   limit: 3
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "flights", ["plane_id"], name: "index_flights_on_plane_id"

  create_table "flights_passengers", id: false, force: :cascade do |t|
    t.integer "flight_id",    null: false
    t.integer "passenger_id", null: false
  end

  add_index "flights_passengers", ["flight_id", "passenger_id"], name: "index_flights_passengers_on_flight_id_and_passenger_id"
  add_index "flights_passengers", ["passenger_id", "flight_id"], name: "index_flights_passengers_on_passenger_id_and_flight_id"

  create_table "passengers", force: :cascade do |t|
    t.string   "name"
    t.string   "seating_preference"
    t.string   "meal_preference"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "plane_components", force: :cascade do |t|
    t.integer  "plane_id"
    t.integer  "component_id"
    t.date     "installation_date"
    t.text     "log"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "plane_components", ["component_id"], name: "index_plane_components_on_component_id"
  add_index "plane_components", ["plane_id"], name: "index_plane_components_on_plane_id"

  create_table "plane_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "seat_count", limit: 3
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "planes", force: :cascade do |t|
    t.integer  "plane_type_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "planes", ["plane_type_id"], name: "index_planes_on_plane_type_id"

end
