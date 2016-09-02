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

ActiveRecord::Schema.define(version: 20160902004709) do

  create_table "locations", force: :cascade do |t|
    t.string   "barcode",                                 null: false
    t.string   "name",       default: "Unnamed Location", null: false
    t.text     "address"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "delivery_name"
    t.text     "delivery_address"
    t.text     "order_updates"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "price"
    t.integer  "stock"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "barcode"
    t.string   "picture"
    t.index ["barcode"], name: "index_products_on_barcode"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "location_id"
    t.integer  "product_id"
    t.text     "details"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["location_id"], name: "index_stocks_on_location_id"
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.string   "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_transactions_on_order_id"
    t.index ["product_id"], name: "index_transactions_on_product_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "from_location_id"
    t.integer  "to_location_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.text     "details"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["from_location_id"], name: "index_transfers_on_from_location_id"
    t.index ["product_id"], name: "index_transfers_on_product_id"
    t.index ["to_location_id"], name: "index_transfers_on_to_location_id"
    t.index ["user_id"], name: "index_transfers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "role",            default: 0, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
