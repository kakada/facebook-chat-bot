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

ActiveRecord::Schema.define(version: 20190501014157) do

  create_table "aggregations", force: true do |t|
    t.string   "name"
    t.decimal  "score_from", precision: 10, scale: 0
    t.decimal  "score_to",   precision: 10, scale: 0
    t.string   "result"
    t.integer  "bot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bots", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "facebook_page_id"
    t.string   "facebook_page_access_token"
    t.string   "google_access_token"
    t.datetime "google_token_expires_at"
    t.string   "google_refresh_token"
    t.string   "google_spreadsheet_key"
    t.string   "google_spreadsheet_title"
    t.boolean  "published",                  default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "restart_msg"
    t.text     "greeting_msg"
  end

  create_table "choices", force: true do |t|
    t.integer  "question_id"
    t.string   "name"
    t.string   "label"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: true do |t|
    t.integer  "bot_id"
    t.string   "type"
    t.string   "select_name"
    t.string   "name"
    t.string   "label"
    t.integer  "relevant_id"
    t.string   "operator"
    t.string   "relevant_value"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "media_image"
    t.text     "description"
  end

  create_table "respondents", force: true do |t|
    t.string   "user_session_id"
    t.integer  "current_question_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "bot_id"
    t.integer  "version"
    t.string   "state"
  end

  create_table "surveys", force: true do |t|
    t.integer  "question_id"
    t.string   "value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "respondent_id"
  end

  add_index "surveys", ["respondent_id"], name: "index_surveys_on_respondent_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "published",              default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
