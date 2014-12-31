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

ActiveRecord::Schema.define(version: 20141231164253) do

  create_table "artists", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "biography"
    t.string   "nationality"
    t.text     "analysis"
    t.string   "thumbnail"
    t.string   "api_id"
    t.string   "birthyear"
  end

  create_table "artworks", force: true do |t|
    t.string   "title"
    t.string   "date"
    t.integer  "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "thumbnail"
  end

  add_index "artworks", ["artist_id"], name: "index_artworks_on_artist_id"

  create_table "users", force: true do |t|
    t.string   "email",              default: "",    null: false
    t.string   "encrypted_password", default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
