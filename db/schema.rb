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

ActiveRecord::Schema.define(version: 20180403232331) do

  create_table "notes", force: :cascade do |t|
    t.integer "script_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lineNum"
    t.integer "location"
    t.text "cueType"
    t.text "cueLabel"
    t.text "cueDescription"
  end

  create_table "scripts", force: :cascade do |t|
    t.text "script_name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "filename"
  end

  create_table "users", force: :cascade do |t|
    t.text "email"
    t.text "username"
    t.text "password"
    t.text "first_name"
    t.text "last_name"
    t.text "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
