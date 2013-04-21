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

ActiveRecord::Schema.define(:version => 20130421221909) do

  create_table "line_items", :force => true do |t|
    t.integer  "line_itemable_id"
    t.integer  "product_id"
    t.integer  "amount"
    t.decimal  "unit_price"
    t.decimal  "discount"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.decimal  "subtotal"
    t.string   "line_itemable_type"
  end

  create_table "payment_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image_url"
    t.decimal  "list_price"
    t.decimal  "sell_price"
    t.integer  "stock"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.text     "comments"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "purchases", :force => true do |t|
    t.integer  "provider_id"
    t.date     "date"
    t.decimal  "amount"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sells", :force => true do |t|
    t.decimal  "amount"
    t.date     "date"
    t.string   "payment_type_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
