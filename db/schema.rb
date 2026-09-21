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

ActiveRecord::Schema[8.1].define(version: 2026_09_21_133945) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "addr1"
    t.string "addr2"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.string "name"
    t.jsonb "settings", default: {}, null: false
    t.string "state"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "zip"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.datetime "invitation_accepted_at"
    t.datetime "invitation_created_at"
    t.bigint "invited_by_id"
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "role", default: "user", null: false
    t.string "time_zone"
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "users", "accounts"
  add_foreign_key "users", "users", column: "invited_by_id"
end
