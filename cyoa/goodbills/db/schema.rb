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

ActiveRecord::Schema.define(version: 20151210225802) do

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

end
