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

ActiveRecord::Schema.define(version: 20141020141604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forecast_requests", force: true do |t|
    t.date     "target_date"
    t.integer  "num_target_days"
    t.datetime "history_start_time"
    t.datetime "history_end_time"
    t.decimal  "min_price"
    t.decimal  "average_price"
    t.decimal  "max_price"
    t.integer  "item_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "forecast_requests", ["item_id"], name: "index_forecast_requests_on_item_id", using: :btree
  add_index "forecast_requests", ["target_date"], name: "index_forecast_requests_on_target_date", using: :btree

  create_table "forecasts", force: true do |t|
    t.date     "target_date"
    t.integer  "forecast_request_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.integer  "in_game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "items", ["in_game_id"], name: "index_items_on_in_game_id", unique: true, using: :btree

  create_table "orders", force: true do |t|
    t.integer  "in_game_id"
    t.decimal  "security"
    t.decimal  "price"
    t.string   "type"
    t.integer  "region_id"
    t.integer  "station_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders", ["in_game_id"], name: "index_orders_on_in_game_id", unique: true, using: :btree
  add_index "orders", ["item_id"], name: "index_orders_on_item_id", using: :btree
  add_index "orders", ["region_id", "station_id"], name: "index_orders_on_region_id_and_station_id", using: :btree
  add_index "orders", ["type"], name: "index_orders_on_type", using: :btree

  create_table "regions", force: true do |t|
    t.integer  "in_game_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "regions", ["in_game_id"], name: "index_regions_on_in_game_id", unique: true, using: :btree

  create_table "stations", force: true do |t|
    t.integer  "in_game_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stations", ["in_game_id"], name: "index_stations_on_in_game_id", unique: true, using: :btree

end
