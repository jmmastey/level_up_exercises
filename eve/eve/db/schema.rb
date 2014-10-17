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

ActiveRecord::Schema.define(version: 20141016222241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: true do |t|
    t.string   "name"
    t.integer  "in_game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "items", ["in_game_id"], name: "index_items_on_in_game_id", unique: true, using: :btree

  create_table "locations", force: true do |t|
    t.string   "name"
    t.integer  "in_game_id"
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "locations", ["in_game_id"], name: "index_locations_on_in_game_id", unique: true, using: :btree

  create_table "orders", force: true do |t|
    t.integer  "in_game_id"
    t.integer  "region_id"
    t.integer  "station_id"
    t.decimal  "security"
    t.decimal  "price"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders", ["in_game_id"], name: "index_orders_on_in_game_id", unique: true, using: :btree
  add_index "orders", ["region_id", "station_id"], name: "index_orders_on_region_id_and_station_id", using: :btree
  add_index "orders", ["type"], name: "index_orders_on_type", using: :btree

  create_table "regions", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
