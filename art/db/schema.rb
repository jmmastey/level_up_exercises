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

ActiveRecord::Schema.define(version: 20141023214703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "performances", force: true do |t|
    t.integer  "show_id"
    t.date     "performed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "performances", ["show_id"], name: "index_performances_on_show_id", using: :btree

  create_table "performers", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performers_shows", id: false, force: true do |t|
    t.integer "performer_id"
    t.integer "show_id"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "performance_id"
    t.integer  "rating"
    t.text     "review"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["performance_id"], name: "index_reviews_on_performance_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "shows", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.string   "director"
    t.string   "location"
    t.string   "theatre_company"
    t.text     "notes"
  end

  create_table "shows_performers", id: false, force: true do |t|
    t.integer "show_id"
    t.integer "performer_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "password"
    t.string   "profile_img_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
