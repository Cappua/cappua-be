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

ActiveRecord::Schema.define(version: 2021_03_01_023212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.string "track_path"
    t.integer "month"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "genre"
    t.string "rules"
    t.string "image", default: "null"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_sub"
    t.string "image", default: "null"
  end

  create_table "verses", force: :cascade do |t|
    t.string "audio_path"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.bigint "competition_id"
    t.index ["competition_id"], name: "index_verses_on_competition_id"
    t.index ["user_id"], name: "index_verses_on_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "verse_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["verse_id"], name: "index_votes_on_verse_id"
  end

  add_foreign_key "verses", "competitions"
  add_foreign_key "verses", "users"
  add_foreign_key "votes", "users"
  add_foreign_key "votes", "verses"
end
