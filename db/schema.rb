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

ActiveRecord::Schema.define(version: 2022_08_06_013150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coins", force: :cascade do |t|
    t.integer "chain_id"
    t.string "symbol"
    t.string "name"
    t.string "logo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chain_id"], name: "index_coins_on_chain_id"
    t.index ["symbol"], name: "index_coins_on_symbol"
  end

  create_table "user_coins", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coin_id"
    t.boolean "is_hold"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "coin_id"], name: "index_user_coins_on_user_id_and_coin_id"
  end

  create_table "user_comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coin_id"
    t.integer "rating"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "coin_id"], name: "index_user_comments_on_user_id_and_coin_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address"], name: "index_users_on_address"
  end

end
