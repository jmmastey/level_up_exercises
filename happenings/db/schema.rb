ActiveRecord::Schema.define do
  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "name"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title",                  null: false
    t.date     "date",                   null: false
    t.time     "time",                   null: false
    t.string   "description",            null: false
    t.integer  "event_source_id",        null: false
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_sources", force: true do |t|
    t.string "event_source"
    t.string "description"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  add_foreign_key "events", "event_sources",  name: "events_event_source_id_fk"
end
