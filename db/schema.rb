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

ActiveRecord::Schema.define(version: 20140606193347) do

  create_table "stamps", id: false, force: true do |t|
    t.string  "id",            null: false
    t.string  "text"
    t.string  "url_small"
    t.integer "width_small"
    t.integer "height_small"
    t.string  "url_medium"
    t.integer "width_medium"
    t.integer "height_medium"
    t.string  "url_large"
    t.integer "width_large"
    t.integer "height_large"
  end

  create_table "tags", force: true do |t|
    t.string "id_stamp"
    t.string "tag"
  end

end
