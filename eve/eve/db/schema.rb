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

ActiveRecord::Schema.define(version: 20141124163400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.datetime "expires"
    t.datetime "date_pulled"
    t.integer  "region_id"
    t.integer  "station_id"
    t.integer  "item_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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

  create_table "regions_watches", id: false, force: true do |t|
    t.integer "region_id", null: false
    t.integer "watch_id",  null: false
  end

  add_index "regions_watches", ["region_id", "watch_id"], name: "index_regions_watches_on_region_id_and_watch_id", using: :btree
  add_index "regions_watches", ["watch_id", "region_id"], name: "index_regions_watches_on_watch_id_and_region_id", using: :btree

  create_table "stations", force: true do |t|
    t.integer  "in_game_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stations", ["in_game_id"], name: "index_stations_on_in_game_id", unique: true, using: :btree

  create_table "stations_watches", id: false, force: true do |t|
    t.integer "station_id", null: false
    t.integer "watch_id",   null: false
  end

  add_index "stations_watches", ["station_id", "watch_id"], name: "index_stations_watches_on_station_id_and_watch_id", using: :btree
  add_index "stations_watches", ["watch_id", "station_id"], name: "index_stations_watches_on_watch_id_and_station_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "watches", force: true do |t|
    t.string   "nickname"
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "watches", ["item_id"], name: "index_watches_on_item_id", using: :btree
  add_index "watches", ["user_id"], name: "index_watches_on_user_id", using: :btree

end
