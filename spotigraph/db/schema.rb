# encoding: UTF-8
ActiveRecord::Schema.define(version: 20150821215035) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "json"
    t.text     "related"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "graphs", force: :cascade do |t|
    t.string   "artist"
    t.integer  "depth"
    t.string   "nodes"
    t.string   "edges"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
