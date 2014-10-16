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

ActiveRecord::Schema.define(version: 20141016220008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grooveshark_id"
    t.integer  "nbs_id"
    t.string   "music_brainz_id"
  end

  add_index "artists", ["name"], name: "index_artists_on_name", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "chart_songs", force: true do |t|
    t.integer  "chart_id"
    t.integer  "song_id"
    t.integer  "popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "charts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_id"
    t.datetime "recorded_on"
    t.string   "scope"
    t.json     "raw_data"
  end

  create_table "metrics", force: true do |t|
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_id"
    t.integer  "value",       limit: 8
    t.string   "nbs_date"
    t.integer  "category_id"
    t.date     "recorded_on"
  end

  add_index "metrics", ["artist_id"], name: "index_metrics_on_artist_id", using: :btree
  add_index "metrics", ["category_id"], name: "index_metrics_on_category_id", using: :btree
  add_index "metrics", ["recorded_on"], name: "index_metrics_on_recorded_on", using: :btree

  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["name"], name: "index_services_on_name", using: :btree

  create_table "songs", force: true do |t|
    t.string   "name"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grooveshark_id"
  end

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

end
