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

ActiveRecord::Schema.define(version: 20150814213855) do

  create_table "cards", force: :cascade do |t|
    t.string  "name"
    t.integer "cmc"
    t.string  "cost"
    t.string  "colors"
    t.string  "supertypes"
    t.string  "subtypes"
    t.text    "text"
    t.integer "power"
    t.integer "toughness"
    t.string  "image_url"
    t.string  "rarity"
  end

  create_table "cards_decks", force: :cascade do |t|
    t.integer "card_id"
    t.integer "deck_id"
    t.integer "number_in_deck", default: 0
  end

  create_table "cards_types", id: false, force: :cascade do |t|
    t.integer "card_id"
    t.integer "type_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "decks", ["user_id", "created_at"], name: "index_decks_on_user_id_and_created_at"
  add_index "decks", ["user_id"], name: "index_decks_on_user_id"

  create_table "types", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
