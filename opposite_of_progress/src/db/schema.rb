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

ActiveRecord::Schema.define(version: 20150113233907) do

  create_table "bills", force: true do |t|
    t.string   "bill_type"
    t.string   "official_title"
    t.string   "chamber"
    t.integer  "congress"
    t.integer  "number"
    t.string   "url"
    t.text     "summary"
    t.boolean  "enacted"
    t.datetime "enacted_at"
    t.datetime "introduced_on"
    t.datetime "last_action_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "enacted_as"
    t.string   "latest_version_pdf"
    t.boolean  "active"
    t.string   "official_id"
  end

  create_table "favorite_bills", force: true do |t|
    t.integer  "user_id"
    t.integer  "bill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_legislators", force: true do |t|
    t.integer  "user_id"
    t.integer  "legislator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "good_deeds", force: true do |t|
    t.string   "action"
    t.integer  "bill_id"
    t.integer  "legislator_id"
    t.string   "chamber"
    t.string   "text"
    t.date     "acted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legislators", force: true do |t|
    t.string   "bioguide_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "name_suffix"
    t.string   "title"
    t.string   "chamber"
    t.string   "party"
    t.string   "state"
    t.integer  "district"
    t.string   "state_rank"
    t.string   "phone"
    t.string   "youtube_id"
    t.string   "facebook_id"
    t.string   "twitter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "website"
  end

  add_index "legislators", ["bioguide_id"], name: "index_legislators_on_bioguide_id", unique: true

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
