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

ActiveRecord::Schema.define(:version => 20130213155006) do

  create_table "bands", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.decimal  "average_rating", :precision => 3, :scale => 2
    t.string   "location"
    t.string   "url"
    t.decimal  "popularity",     :precision => 8, :scale => 5
  end

  create_table "bands_festivals", :id => false, :force => true do |t|
    t.integer "band_id"
    t.integer "festival_id"
  end

  create_table "festivals", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "date"
  end

  create_table "lineups", :force => true do |t|
    t.integer  "band_id"
    t.integer  "festival_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "lineups", ["band_id"], :name => "index_lineups_on_band_id"
  add_index "lineups", ["festival_id"], :name => "index_lineups_on_festival_id"

  create_table "ratings", :force => true do |t|
    t.integer  "rating"
    t.integer  "band_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ratings", ["band_id"], :name => "index_ratings_on_band_id"
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "name"
    t.text     "description"
    t.boolean  "admin",           :default => false
    t.boolean  "reviewer",        :default => false
  end

end
