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

ActiveRecord::Schema.define(version: 20150806170407) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_actions", force: :cascade do |t|
    t.string   "text"
    t.date     "date"
    t.integer  "bill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "result"
    t.string   "chamber"
  end

  create_table "bill_tags", force: :cascade do |t|
    t.integer  "bill_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bills", force: :cascade do |t|
    t.string   "bill_id"
    t.string   "bill_type"
    t.string   "chamber"
    t.integer  "congress"
    t.integer  "cosponsors_count"
    t.date     "introduced_on"
    t.string   "official_title"
    t.string   "popular_title"
    t.string   "short_title"
    t.text     "summary_short"
    t.string   "url"
    t.date     "last_action_at"
    t.string   "last_version_pdf"
    t.integer  "legislator_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "congressional_districts", force: :cascade do |t|
    t.string   "zipcode"
    t.string   "state"
    t.integer  "congressional_district_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "congressional_districts", ["state"], name: "index_congressional_districts_on_state", using: :btree
  add_index "congressional_districts", ["zipcode"], name: "index_congressional_districts_on_zipcode", using: :btree

  create_table "legislators", force: :cascade do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "name_suffix"
    t.string   "nickname"
    t.string   "party"
    t.string   "state"
    t.string   "district"
    t.string   "gender"
    t.string   "phone"
    t.string   "fax"
    t.string   "website"
    t.string   "contact_form"
    t.string   "office"
    t.string   "bioguide_id"
    t.string   "votesmart_id"
    t.string   "govtrack_id"
    t.string   "crp_id"
    t.string   "twitter_id"
    t.string   "youtube_id"
    t.string   "facebook_id"
    t.string   "birthday"
    t.string   "oc_email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "term_start"
    t.string   "term_end"
    t.string   "leadership_role"
    t.boolean  "in_office"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_bills", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_tags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "zipcode"
    t.string   "political_party"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
