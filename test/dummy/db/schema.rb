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

ActiveRecord::Schema.define(version: 20150115110106) do

  create_table "feeder_feed_sources", force: true do |t|
    t.string   "title",           null: false
    t.string   "url"
    t.string   "duration"
    t.datetime "last_check_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeder_feeds", force: true do |t|
    t.string   "title",                          null: false
    t.text     "content"
    t.string   "url"
    t.boolean  "analyzed",       default: false
    t.string   "language",       default: "f"
    t.integer  "feed_source_id"
    t.string   "entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeder_feeds", ["entry_id", "feed_source_id"], name: "index_feeder_feeds_on_entry_id_and_feed_source_id", unique: true

  create_table "feeder_feeds_sites", force: true do |t|
    t.integer "site_id"
    t.integer "feed_id"
  end

  create_table "feeder_sites", force: true do |t|
    t.string   "domain",      limit: 500,  null: false
    t.string   "title",       limit: 1000
    t.text     "description"
    t.text     "keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeder_sites_feeds", force: true do |t|
    t.integer  "site_id"
    t.integer  "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
