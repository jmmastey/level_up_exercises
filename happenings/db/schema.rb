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

ActiveRecord::Schema.define(version: 20140926185805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
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

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "event_dates", force: true do |t|
    t.integer  "venue_id"
    t.datetime "date_time"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_dates", ["event_id"], name: "index_event_dates_on_event_id", using: :btree
  add_index "event_dates", ["venue_id"], name: "index_event_dates_on_venue_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.integer  "venue_id"
    t.text     "description"
    t.string   "price"
    t.string   "show_type"
    t.string   "phone_number"
    t.string   "running_time"
    t.string   "event_url"
    t.string   "ticket_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

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

  create_table "venue_events", force: true do |t|
    t.integer  "events_id"
    t.integer  "event_dates_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venue_events", ["event_dates_id"], name: "index_venue_events_on_event_dates_id", using: :btree
  add_index "venue_events", ["events_id"], name: "index_venue_events_on_events_id", using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "zipcode"
    t.text     "description"
    t.string   "phone_number"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
