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

ActiveRecord::Schema.define(version: 20160611113049) do

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "last_name",           null: false
    t.string   "first_name",          null: false
    t.string   "middle_name"
    t.string   "email",               null: false
    t.integer  "gender",              null: false
    t.date     "birth_date",          null: false
    t.string   "password_digest",     null: false
    t.string   "remember_digest"
    t.integer  "role",                null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "deleted_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "deleter_id"
  end

  add_index "users", ["creator_id"], name: "index_users_on_creator_id"
  add_index "users", ["deleter_id"], name: "index_users_on_deleter_id"
  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["updater_id"], name: "index_users_on_updater_id"

end
