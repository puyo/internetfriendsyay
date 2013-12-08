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

ActiveRecord::Schema.define(version: 20110621125153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "schedules", force: true do |t|
    t.string   "uuid",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.integer  "schedule_id"
    t.string   "name",        null: false
    t.string   "timezone",    null: false
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["schedule_id"], :name => "fk__people_schedule_id"
    t.index ["schedule_id"], :name => "index_people_on_schedule_id"
    t.foreign_key ["schedule_id"], "schedules", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_people_schedule_id"
  end

end
