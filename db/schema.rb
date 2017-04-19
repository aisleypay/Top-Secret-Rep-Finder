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

ActiveRecord::Schema.define(version: 20170419004317) do

  create_table "office_senators", force: :cascade do |t|
    t.integer "senator_id"
    t.integer "office_id"
  end

  create_table "offices", force: :cascade do |t|
    t.string "position"
    t.string "level"
  end

  create_table "senators", force: :cascade do |t|
    t.string  "name"
    t.string  "address"
    t.string  "party"
    t.string  "phones"
    t.string  "urls"
    t.string  "photoUrl"
    t.string  "Facebook"
    t.string  "Twitter"
    t.string  "YouTube"
    t.integer "state_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "abbreviation"
    t.string "full_name"
  end

end