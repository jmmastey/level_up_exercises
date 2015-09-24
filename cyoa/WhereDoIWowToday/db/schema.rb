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

ActiveRecord::Schema.define(version: 20150924160048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer "character_id"
    t.integer "category_id",  null: false
    t.integer "quest_id",     null: false
  end

  add_index "activities", ["category_id"], name: "index_activities_on_category_id", using: :btree
  add_index "activities", ["character_id"], name: "index_activities_on_character_id", using: :btree
  add_index "activities", ["quest_id"], name: "index_activities_on_quest_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "blizzard_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "categories_quests", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "quest_id",    null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.string   "realm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "characters", ["name", "realm"], name: "name_and_realm", unique: true, using: :btree

  create_table "owned_activities", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.boolean  "hidden",        default: false, null: false
    t.integer  "list_position"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "owned_activities", ["activity_id"], name: "index_owned_activities_on_activity_id", using: :btree
  add_index "owned_activities", ["user_id"], name: "index_owned_activities_on_user_id", using: :btree

  create_table "quests", force: :cascade do |t|
    t.integer  "blizzard_id_num", null: false
    t.string   "title",           null: false
    t.integer  "req_level"
    t.integer  "level"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "quests", ["blizzard_id_num"], name: "index_quests_on_blizzard_id_num", unique: true, using: :btree

  create_table "realms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "activities", "categories"
  add_foreign_key "activities", "characters"
  add_foreign_key "activities", "quests"
  add_foreign_key "owned_activities", "activities"
  add_foreign_key "owned_activities", "users"
end
