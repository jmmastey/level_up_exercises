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

ActiveRecord::Schema.define(version: 20150909143835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.integer  "blizzard_id_num"
    t.string   "title"
    t.integer  "faction_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "category"
  end

  add_index "achievements", ["blizzard_id_num"], name: "index_achievements_on_blizzard_id_num", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "blizzard_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "character_zone_activities", force: :cascade do |t|
    t.integer "character_id"
    t.integer "category_id"
    t.integer "quest_id"
    t.integer "achievement_id"
  end

  add_index "character_zone_activities", ["achievement_id"], name: "index_character_zone_activities_on_achievement_id", using: :btree
  add_index "character_zone_activities", ["category_id"], name: "index_character_zone_activities_on_category_id", using: :btree
  add_index "character_zone_activities", ["character_id"], name: "index_character_zone_activities_on_character_id", using: :btree
  add_index "character_zone_activities", ["quest_id"], name: "index_character_zone_activities_on_quest_id", using: :btree

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.string   "realm"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "blizzard_faction_id_num", null: false
  end

  add_index "characters", ["name", "realm"], name: "name_and_realm", unique: true, using: :btree

  create_table "quests", force: :cascade do |t|
    t.integer  "blizzard_id_num"
    t.string   "title"
    t.string   "category"
    t.integer  "req_level"
    t.integer  "level"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "blizzard_faction_id_num"
  end

  add_index "quests", ["blizzard_id_num"], name: "index_quests_on_blizzard_id_num", unique: true, using: :btree

  create_table "realms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "character_zone_activities", "achievements"
  add_foreign_key "character_zone_activities", "categories"
  add_foreign_key "character_zone_activities", "characters"
  add_foreign_key "character_zone_activities", "quests"
end
