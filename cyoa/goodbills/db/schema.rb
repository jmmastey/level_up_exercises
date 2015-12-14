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

ActiveRecord::Schema.define(version: 20151214153540) do

  create_table "bills", force: :cascade do |t|
    t.string   "official_title"
    t.string   "popular_title"
    t.string   "short_title"
    t.string   "nickname"
    t.text     "summary"
    t.string   "bill_id"
    t.string   "bill_type"
    t.integer  "number"
    t.integer  "congress"
    t.string   "chamber"
    t.date     "introduced_on"
    t.date     "last_action_at"
    t.datetime "last_vote_at"
    t.date     "last_version_on"
    t.string   "congress_url"
    t.boolean  "enacted"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "score",           default: 0
    t.integer  "num_voted",       default: 0
  end

  add_index "bills", ["num_voted"], name: "index_bills_on_num_voted"
  add_index "bills", ["score"], name: "index_bills_on_score"

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
