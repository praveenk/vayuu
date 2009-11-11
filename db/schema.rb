# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091111032005) do

  create_table "airports", :force => true do |t|
    t.string  "airport_id"
    t.string  "airport_type"
    t.string  "manager_ph"
    t.integer "lat_deg"
    t.integer "lat_min"
    t.float   "lat_sec"
    t.float   "latitude"
    t.integer "long_deg"
    t.integer "long_min"
    t.float   "long_sec"
    t.float   "longitude"
    t.integer "airport_elev"
    t.string  "chart_name",        :limit => 100, :default => ""
    t.string  "airport_name",      :limit => 100, :default => ""
    t.string  "city",              :limit => 100, :default => ""
    t.string  "state",             :limit => 5,   :default => ""
    t.string  "fuel_types",        :limit => 100, :default => ""
    t.string  "airport_ownership", :limit => 100, :default => ""
  end

  add_index "airports", ["airport_id"], :name => "index_airports_on_airport_id"

  create_table "miscreviews", :force => true do |t|
    t.string   "airport_id"
    t.string   "pilotname"
    t.string   "reviewcontent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userreviews", :force => true do |t|
    t.string   "username"
    t.string   "airport_code"
    t.text     "review_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
