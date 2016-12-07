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

ActiveRecord::Schema.define(version: 20141121033639) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
    t.string   "image"
    t.string   "description"
  end

  add_index "events", ["name", "location", "link"], name: "index_events_on_name_and_location_and_link", unique: true

  create_table "scrape_times", force: true do |t|
    t.string   "source"
    t.datetime "last_scrape_at"
    t.time     "inter_scrape_delay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scrape_times", ["source"], name: "index_scrape_times_on_source", unique: true

  create_table "showings", force: true do |t|
    t.integer  "event_id"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "showings_users", id: false, force: true do |t|
    t.integer "user_id",    null: false
    t.integer "showing_id", null: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
