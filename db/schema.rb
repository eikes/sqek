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

ActiveRecord::Schema.define(version: 2016_02_23_112353) do

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "external_url"
    t.integer "label_position"
    t.index ["slug"], name: "index_cities_on_slug", unique: true
  end

  create_table "cities_users", id: false, force: :cascade do |t|
    t.integer "city_id", null: false
    t.integer "user_id", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "email"
    t.boolean "published"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  end

  create_table "periods", force: :cascade do |t|
    t.integer "squat_id"
    t.integer "start_year"
    t.integer "start_month"
    t.integer "start_day"
    t.integer "end_year"
    t.integer "end_month"
    t.integer "end_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["squat_id"], name: "index_periods_on_squat_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures_squats", id: false, force: :cascade do |t|
    t.integer "picture_id", null: false
    t.integer "squat_id", null: false
  end

  create_table "squats", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.float "lat"
    t.float "lng"
    t.integer "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "address"
    t.text "link"
    t.text "tags"
    t.boolean "published"
    t.string "external_user_email"
    t.string "address_city"
    t.index ["city_id"], name: "index_squats_on_city_id"
    t.index ["slug"], name: "index_squats_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
