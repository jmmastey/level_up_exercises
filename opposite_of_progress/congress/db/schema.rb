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

ActiveRecord::Schema.define(version: 20141024155756) do

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
  end

end
