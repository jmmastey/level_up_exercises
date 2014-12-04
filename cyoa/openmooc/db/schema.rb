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

ActiveRecord::Schema.define(version: 20141202180723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aliases", force: true do |t|
    t.string   "text"
    t.integer  "fill_in_the_blank_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aliases", ["fill_in_the_blank_answer_id"], name: "index_aliases_on_fill_in_the_blank_answer_id", using: :btree

  create_table "contents", force: true do |t|
    t.integer  "page_content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["page_content_id"], name: "index_contents_on_page_content_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "title"
    t.string   "subject"
    t.string   "topic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "page_content_id"
  end

  add_index "courses", ["page_content_id"], name: "index_courses_on_page_content_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "fill_in_the_blank_answers", force: true do |t|
    t.string   "text"
    t.integer  "fill_in_the_blank_question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fill_in_the_blank_answers", ["fill_in_the_blank_question_id"], name: "fitb_answer_belongs_to_fill_in_the_blank_question_index", using: :btree

  create_table "fill_in_the_blank_questions", force: true do |t|
    t.integer  "page_content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fill_in_the_blank_questions", ["page_content_id"], name: "index_fill_in_the_blank_questions_on_page_content_id", using: :btree

  create_table "lessons", force: true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lessons", ["course_id"], name: "index_lessons_on_course_id", using: :btree

  create_table "multiple_choice_answers", force: true do |t|
    t.integer  "multiple_choice_question_id"
    t.string   "text"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "multiple_choice_answers", ["multiple_choice_question_id"], name: "index_multiple_choice_answers_on_multiple_choice_question_id", using: :btree

  create_table "multiple_choice_questions", force: true do |t|
    t.integer  "page_content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "multiple_choice_questions", ["page_content_id"], name: "index_multiple_choice_questions_on_page_content_id", using: :btree

  create_table "page_contents", force: true do |t|
    t.text     "content"
    t.text     "html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "type"
    t.integer  "lesson_id"
    t.integer  "position"
    t.integer  "content_id"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["content_id", "content_type"], name: "index_pages_on_content_id_and_content_type", using: :btree
  add_index "pages", ["lesson_id"], name: "index_pages_on_lesson_id", using: :btree

  create_table "quiz_activities", force: true do |t|
    t.integer  "question_id"
    t.string   "question_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quiz_activities", ["question_id", "question_type"], name: "index_quiz_activities_on_question_id_and_question_type", using: :btree

  create_table "users", force: true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
