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

ActiveRecord::Schema.define(version: 20150630220341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tweets", force: :cascade do |t|
    t.decimal  "tweet_id_from_twitter",             precision: 18,                       null: false
    t.string   "author_screen_name",    limit: 50,                                       null: false
    t.string   "tweet_text",            limit: 255,                                      null: false
    t.integer  "retweet_count",                                              default: 0, null: false
    t.decimal  "latitude",                          precision: 10, scale: 6,             null: false
    t.decimal  "longitude",                         precision: 10, scale: 6,             null: false
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.datetime "tweet_created_at",                                                       null: false
    t.string   "author_name",           limit: 50,                                       null: false
    t.integer  "favorite_count",                                             default: 0, null: false
  end

  add_index "tweets", ["tweet_id_from_twitter"], name: "index_tweets_on_tweet_id_from_twitter", unique: true, using: :btree

  create_table "user_sessions", force: :cascade do |t|
    t.string   "session_key",   limit: 40
    t.datetime "last_activity"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.decimal  "latitude",                 precision: 10, scale: 6, null: false
    t.decimal  "longitude",                precision: 10, scale: 6, null: false
    t.decimal  "miles_radius",             precision: 10, scale: 6, null: false
  end

  add_index "user_sessions", ["session_key"], name: "index_user_sessions_on_session_key", unique: true, using: :btree

end
