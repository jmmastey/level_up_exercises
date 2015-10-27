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

ActiveRecord::Schema.define(version: 20151027195645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "landmark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "external_id"
    t.string   "name"
    t.string   "description"
    t.integer  "merchant_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string   "external_id"
    t.string   "name"
    t.string   "phone"
    t.string   "description"
    t.integer  "location_id"
    t.decimal  "minimum_pickup"
    t.decimal  "minimum_delivery"
    t.decimal  "maximum_pickup"
    t.decimal  "maximum_delivery"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "external_id"
    t.string "email"
    t.string "last_name"
    t.string "first_name"
  end

  add_index "users", ["external_id"], name: "index_users_on_external_id", using: :btree

end
