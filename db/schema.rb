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

ActiveRecord::Schema[7.1].define(version: 2024_03_02_115838) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "library_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_id"], name: "index_bookmarks_on_library_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comments_body"
    t.integer "comments_seats_number"
    t.integer "comments_pc_available"
    t.integer "comments_wifi_available"
    t.integer "comments_power_available"
    t.bigint "library_id", null: false
    t.bigint "user_id", null: false
    t.index ["library_id"], name: "index_comments_on_library_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name", null: false
    t.string "prefecture", null: false
    t.integer "study_rooms"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.text "body"
    t.string "address"
    t.string "access"
    t.string "img"
    t.string "holiday"
    t.integer "seats_number"
    t.integer "pc_available"
    t.integer "wifi_available"
    t.integer "power_available"
    t.index ["user_id"], name: "index_libraries_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.bigint "user_id", null: false
    t.bigint "library_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_id"], name: "index_posts_on_library_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "avatar"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "avatar"
    t.string "user_prefecture"
    t.string "user_city"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "bookmarks", "libraries"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "comments", "libraries"
  add_foreign_key "comments", "users"
  add_foreign_key "libraries", "users"
  add_foreign_key "posts", "libraries"
  add_foreign_key "posts", "users"
  add_foreign_key "profiles", "users"
end
