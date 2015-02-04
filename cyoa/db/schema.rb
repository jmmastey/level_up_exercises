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

ActiveRecord::Schema.define(version: 20150204031751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "points", force: :cascade do |t|
    t.decimal  "lat",                   precision: 6, scale: 4, null: false
    t.decimal  "lon",                   precision: 6, scale: 4, null: false
    t.string   "zip",        limit: 20,                         null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["lat", "lon"], :name => "index_points_on_lat_and_lon", :unique => true
  end

  create_table "forecasts", force: :cascade do |t|
    t.integer  "point_id",                null: false
    t.datetime "start_time",              null: false
    t.datetime "end_time",                null: false
    t.integer  "maxt"
    t.integer  "mint"
    t.integer  "cloud_cover"
    t.string   "icon_link",   limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["point_id", "start_time", "end_time"], :name => "index_forecasts_on_point_id_and_start_time_and_end_time", :unique => true
    t.index ["point_id"], :name => "fk__forecasts_point_id"
    t.foreign_key ["point_id"], "points", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_forecasts_point_id"
  end

  create_table "weather_types", force: :cascade do |t|
    t.string   "weather_type", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "forecast_weather_types", force: :cascade do |t|
    t.integer  "forecast_id",                 null: false
    t.integer  "weather_type_id",             null: false
    t.string   "additive",        limit: 100
    t.string   "coverage",        limit: 100
    t.string   "qualifier",       limit: 100
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["forecast_id", "weather_type_id"], :name => "index_forecast_weather_types_on_forecast_id_and_weather_type_id", :unique => true
    t.index ["forecast_id"], :name => "fk__forecast_weather_types_forecast_id"
    t.index ["weather_type_id"], :name => "fk__forecast_weather_types_weather_type_id"
    t.foreign_key ["forecast_id"], "forecasts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_forecast_weather_types_forecast_id"
    t.foreign_key ["weather_type_id"], "weather_types", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_forecast_weather_types_weather_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 100, default: "", null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",                  limit: 50
    t.index ["email"], :name => "index_users_on_email", :unique => true
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  end

  create_table "user_notifications", force: :cascade do |t|
    t.integer  "user_id",                           null: false
    t.time     "notification_time",                 null: false
    t.boolean  "active",            default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["user_id"], :name => "fk__user_notifications_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_user_notifications_user_id"
  end

end
