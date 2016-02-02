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

ActiveRecord::Schema.define(version: 20160126204519) do

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.integer  "menu_item_id"
  end

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

  create_table "menu_items", force: :cascade do |t|
    t.string   "external_id"
    t.string   "name"
    t.string   "menu_group"
    t.string   "menu_subgroup"
    t.string   "description"
    t.decimal  "price",         precision: 8, scale: 2
    t.boolean  "active",                                default: true
    t.integer  "menu_id"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "favorite_id"
  end

  add_index "menu_items", ["favorite_id"], name: "index_menu_items_on_favorite_id"

  create_table "menus", force: :cascade do |t|
    t.string   "external_id"
    t.string   "name"
    t.string   "description"
    t.string   "price_unit",  limit: 1, default: "$"
    t.integer  "merchant_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.string   "website_url"
    t.string   "menu_url"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "phone"
    t.string   "about"
    t.integer  "location_id"
    t.boolean  "profile_visible",        default: false
    t.integer  "favorite_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["favorite_id"], name: "index_users_on_favorite_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
