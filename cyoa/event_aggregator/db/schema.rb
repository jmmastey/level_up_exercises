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

ActiveRecord::Schema.define(version: 20150112021738) do

  create_table "calendar_events", force: true do |t|
    t.string   "title",           limit: 256,  null: false
    t.datetime "start_time",                   null: false
    t.datetime "end_time",                     null: false
    t.text     "description",     limit: 1024
    t.string   "event_hash",      limit: 64
    t.string   "family_hash",     limit: 64
    t.string   "location",        limit: 256
    t.string   "host",            limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_source_id"
  end

  add_index "calendar_events", ["end_time"], name: "index_calendar_events_on_end_time"
  add_index "calendar_events", ["event_hash"], name: "index_calendar_events_on_event_hash", unique: true
  add_index "calendar_events", ["family_hash"], name: "index_calendar_events_on_family_hash"
  add_index "calendar_events", ["start_time"], name: "index_calendar_events_on_start_time"

  create_table "calendar_events_feeds", force: true do |t|
    t.integer "calendar_event_id"
    t.integer "feed_id"
  end

  create_table "event_sources", force: true do |t|
    t.string   "name",         null: false
    t.string   "source_type",  null: false
    t.string   "uri"
    t.integer  "frequency"
    t.datetime "last_harvest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_sources_feeds", force: true do |t|
    t.integer "event_source_id"
    t.integer "feed_id"
  end

  add_index "event_sources_feeds", ["event_source_id"], name: "index_event_sources_feeds_on_event_source_id"
  add_index "event_sources_feeds", ["feed_id"], name: "index_event_sources_feeds_on_feed_id"

  create_table "feeds", force: true do |t|
    t.integer  "user_id"
    t.string   "title",        limit: 128,                  null: false
    t.text     "description",  limit: 2048
    t.boolean  "public",                    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "evaluated_at"
  end

  add_index "feeds", ["evaluated_at"], name: "index_feeds_on_evaluated_at"
  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id"

  create_table "selection_criteria", force: true do |t|
    t.string   "implementation_class", null: false
    t.text     "configuration"
    t.string   "sql_expression"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feed_id",              null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
