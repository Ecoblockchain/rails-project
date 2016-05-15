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

ActiveRecord::Schema.define(version: 20160401151724) do

  create_table "seals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "stamp"
    t.string   "text"
  end

  create_table "seals_users", id: false, force: :cascade do |t|
    t.integer "user_id",    null: false
    t.integer "seal_id",    null: false
    t.boolean "owner"
    t.boolean "terminator"
    t.boolean "verifier"
  end

  add_index "seals_users", ["user_id", "seal_id"], name: "index_seals_users_on_user_id_and_seal_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
