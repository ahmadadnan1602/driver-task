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

ActiveRecord::Schema[7.0].define(version: 2022_11_01_134704) do
  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "card_details", force: :cascade do |t|
    t.string "card_no"
    t.string "expiry_month"
    t.integer "expiry_year"
    t.boolean "is_active"
    t.boolean "is_default"
    t.integer "driver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_card_details_on_driver_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "licence_number"
    t.datetime "d_o_b"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_drivers_on_user_id"
  end

  create_table "fuels", force: :cascade do |t|
    t.float "amount"
    t.text "description"
    t.integer "transaction_type"
    t.integer "driver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_fuels_on_driver_id"
  end

  create_table "pay_laters", force: :cascade do |t|
    t.float "total_amount"
    t.boolean "is_active"
    t.integer "driver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_pay_laters_on_driver_id"
  end

  create_table "transaction_histories", force: :cascade do |t|
    t.float "amount"
    t.string "transaction_type"
    t.boolean "is_settle", default: false
    t.string "transactiontable_type", null: false
    t.integer "transactiontable_id", null: false
    t.integer "driver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_transaction_histories_on_driver_id"
    t.index ["transactiontable_type", "transactiontable_id"], name: "index_transaction_histories_on_transactiontable"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallet_histories", force: :cascade do |t|
    t.integer "wallet_id"
    t.float "total_amount"
    t.string "transaction_histories_ids"
    t.integer "driver_id", null: false
    t.integer "card_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_detail_id"], name: "index_wallet_histories_on_card_detail_id"
    t.index ["driver_id"], name: "index_wallet_histories_on_driver_id"
    t.index ["wallet_id"], name: "index_wallet_histories_on_wallet_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.float "total_amount"
    t.integer "wallet_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "card_details", "drivers"
  add_foreign_key "drivers", "users"
  add_foreign_key "fuels", "drivers"
  add_foreign_key "pay_laters", "drivers"
  add_foreign_key "transaction_histories", "drivers"
  add_foreign_key "wallet_histories", "card_details"
  add_foreign_key "wallet_histories", "drivers"
end
