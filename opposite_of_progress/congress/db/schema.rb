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

ActiveRecord::Schema.define(version: 20141121151055) do

  create_table "bills", force: true do |t|
    t.string   "bill_id"
    t.string   "bill_type"
    t.integer  "number"
    t.integer  "congress"
    t.string   "chamber"
    t.date     "introduced_on"
    t.date     "last_action_at"
    t.date     "last_vote_at"
    t.date     "last_version_on"
    t.string   "official_title"
    t.string   "short_title"
    t.string   "summary"
    t.string   "summary_short"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sponsor_id"
    t.date     "enacted_at"
  end

  create_table "deeds", force: true do |t|
    t.string   "bioguide_id"
    t.string   "bill_id"
    t.string   "deed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
  end

  create_table "legislators", force: true do |t|
    t.string   "bioguide_id"
    t.date     "birthday"
    t.string   "chamber"
    t.string   "party"
    t.string   "title"
    t.date     "term_start"
    t.date     "term_end"
    t.string   "gender"
    t.string   "first_name"
    t.string   "nickname"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "state"
    t.string   "twitter_id"
    t.string   "facebook_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "website"
    t.string   "office"
    t.string   "contact_form"
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
    t.boolean  "email_preferences"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
