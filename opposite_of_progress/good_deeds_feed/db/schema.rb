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

ActiveRecord::Schema.define(version: 20150218231256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "legislator_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "favorites", ["legislator_id"], name: "index_favorites_on_legislator_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "good_deeds", force: :cascade do |t|
    t.integer  "congress_number"
    t.string   "congress_url"
    t.string   "short_title"
    t.text     "official_title"
    t.date     "introduced_on"
    t.integer  "legislator_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "good_deeds", ["legislator_id"], name: "index_good_deeds_on_legislator_id", using: :btree

  create_table "legislators", force: :cascade do |t|
    t.string   "title"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "bioguide_id"
    t.string   "party"
    t.string   "state"
    t.string   "gender"
    t.string   "website"
    t.string   "twitter_id"
    t.date     "birthdate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "notified",    default: true
  end

  add_index "legislators", ["bioguide_id"], name: "index_legislators_on_bioguide_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "good_deeds", "legislators"
end
