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

ActiveRecord::Schema.define(version: 20180301003024) do

  create_table "categories", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "joke_categories", force: :cascade do |t|
    t.integer "joke_id"
    t.integer "category_id"
  end

  add_index "joke_categories", ["category_id"], name: "index_joke_categories_on_category_id"
  add_index "joke_categories", ["joke_id"], name: "index_joke_categories_on_joke_id"

  create_table "joke_tags", force: :cascade do |t|
    t.integer  "joke_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jokes", force: :cascade do |t|
    t.string   "content"
    t.integer  "point",      default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "trash",      default: false
    t.boolean  "published",  default: false
    t.string   "keyword",    default: ""
  end

  create_table "tags", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "jokes_count", default: 0
  end

  add_index "tags", ["content"], name: "index_tags_on_content", unique: true

end
