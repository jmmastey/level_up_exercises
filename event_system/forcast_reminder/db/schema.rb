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

ActiveRecord::Schema.define(version: 20141117170913) do

  create_table "current_weathers", force: true do |t|
    t.integer  "temperature"
    t.string   "condition"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "station_id"
    t.string   "location_name"
    t.string   "observation_time"
    t.string   "wind"
    t.float    "pressure"
    t.integer  "dew_point"
    t.integer  "wind_chill"
    t.float    "visibility"
    t.string   "icon_url"
    t.string   "history_url"
    t.integer  "humidity"
  end

  create_table "forecasts", force: true do |t|
    t.integer  "zip_code"
    t.datetime "time"
    t.integer  "temperature"
    t.string   "condition"
    t.integer  "precipitation"
    t.string   "icon_url"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "date_description"
  end

  create_table "hourly_forecasts", force: true do |t|
    t.datetime "time"
    t.integer  "temperature"
    t.integer  "dew_point"
    t.float    "precipitation"
    t.integer  "wind_speed"
    t.integer  "wind_direction"
    t.integer  "cloud_cover"
    t.string   "hazard"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "zip_code"
    t.string   "icon_url"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.integer  "zip_code",               default: 60606,  null: false
    t.string   "station_id",             default: "KMDW", null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "send_reminder"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
