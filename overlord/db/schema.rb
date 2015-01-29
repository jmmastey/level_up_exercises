ActiveRecord::Schema.define(version: 20150118012407) do

  create_table "bombs", force: :cascade do |t|
    t.string   "activation_code",   default: "1234"
    t.string   "deactivation_code", default: "0000"
    t.integer  "detonation_time",   default: 60
    t.integer  "status"
    t.datetime "activated_time"
    t.integer  "failed_attempts"
  end

  create_table "wires", force: :cascade do |t|
    t.string  "color"
    t.boolean "diffuse", default: false
    t.integer "bomb_id"
  end

end
