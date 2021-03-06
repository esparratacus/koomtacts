# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_09_004528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.date "dob"
    t.string "phone_number"
    t.string "address"
    t.string "cc_4_digits"
    t.string "cc_number"
    t.string "franchise"
    t.string "email"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "contacts_files", force: :cascade do |t|
    t.string "contacts"
    t.jsonb "header_mappings"
    t.string "status"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_contacts_files_on_user_id"
  end

  create_table "importer_logs", force: :cascade do |t|
    t.bigint "contacts_file_id"
    t.jsonb "candidate"
    t.jsonb "error_log"
    t.index ["contacts_file_id"], name: "index_importer_logs_on_contacts_file_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "contacts_files", "users"
end
