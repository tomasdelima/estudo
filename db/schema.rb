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

ActiveRecord::Schema.define(version: 20140102132959) do

  create_table "carts", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["product_id"], name: "index_carts_on_product_id"
  add_index "carts", ["user_id"], name: "index_carts_on_user_id"

  create_table "carts_products", force: true do |t|
    t.integer "cart_id"
    t.integer "product_id"
    t.integer "quantity"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "orders_products", force: true do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "quantity"
  end

  add_index "orders_products", ["order_id"], name: "index_orders_products_on_order_id"
  add_index "orders_products", ["product_id"], name: "index_orders_products_on_product_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.float    "price"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products_tags", force: true do |t|
    t.integer "tag_id"
    t.integer "product_id"
  end

  add_index "products_tags", ["product_id"], name: "index_products_tags_on_product_id"
  add_index "products_tags", ["tag_id"], name: "index_products_tags_on_tag_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags_products", force: true do |t|
    t.integer "product_id"
    t.integer "tag_id"
  end

  add_index "tags_products", ["product_id"], name: "index_tags_products_on_product_id"
  add_index "tags_products", ["tag_id"], name: "index_tags_products_on_tag_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin"
    t.integer  "cart_id"
  end

  add_index "users", ["cart_id"], name: "index_users_on_cart_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
