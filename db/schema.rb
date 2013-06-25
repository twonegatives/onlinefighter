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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130625140525) do

  create_table "character_types", :force => true do |t|
    t.integer  "max_health"
    t.integer  "attack"
    t.integer  "defence"
    t.integer  "magic"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "characters", :force => true do |t|
    t.integer  "character_type_id"
    t.integer  "health"
    t.integer  "experience",        :default => 0
    t.integer  "won",               :default => 0
    t.integer  "lost",              :default => 9
    t.integer  "defence"
    t.integer  "attack"
    t.integer  "magick"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "character_type_id"
    t.integer  "increasable_id"
    t.integer  "increase_value"
    t.integer  "character_id"
    t.integer  "item_type_id"
    t.boolean  "is_equipped",       :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

end
