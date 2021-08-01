# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_29_022238) do

  create_table "billing_addresses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "shipping_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_billing_addresses_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "title", null: false
    t.decimal "price", null: false
    t.decimal "dis_price"
    t.string "slug"
    t.string "description", null: false
    t.string "picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "item_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "ordered_boolean", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "billing_address_id"
    t.index ["billing_address_id"], name: "index_orders_on_billing_address_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "billing_addresses", "users"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "billing_addresses"
  add_foreign_key "orders", "users"
end
