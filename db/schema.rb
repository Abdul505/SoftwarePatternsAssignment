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

ActiveRecord::Schema.define(version: 20170416194231) do

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "star"
    t.integer  "customer_id"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "l_name"
    t.string   "f_name"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "level"
    t.integer  "discount"
  end

  create_table "lineitems", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "paymethod"
    t.integer  "total"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_name"
    t.string   "product_pic"
    t.text     "description"
    t.string   "colour"
    t.string   "size"
    t.integer  "price"
    t.string   "product_number"
    t.integer  "quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
