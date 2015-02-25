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

ActiveRecord::Schema.define(version: 20150218174958) do

  create_table "stocks", force: :cascade do |t|
    t.string   "symbol"
    t.string   "name"
    t.string   "sector"
    t.string   "industry"
    t.float    "asking_price"
    t.float    "bid_price"
    t.string   "ticker_trend"
    t.float    "moving_average_200_day"
    t.float    "moving_average_50_day"
    t.float    "pe_ratio"
    t.float    "peg_ratio"
    t.string   "market_cap"
    t.float    "rating"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "stocks_users", id: false, force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "stock_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stocks_users", ["stock_id", "user_id"], name: "index_stocks_users_on_stock_id_and_user_id"
  add_index "stocks_users", ["user_id", "stock_id"], name: "index_stocks_users_on_user_id_and_stock_id"

  create_table "users", force: :cascade do |t|
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
