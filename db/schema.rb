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

ActiveRecord::Schema.define(version: 2024_07_10_093950) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "book_stores", force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "address", default: "", null: false
    t.string "telephone_number", default: "", null: false
    t.integer "age", null: false
    t.boolean "is_active", default: true, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reset_password_token"], name: "index_book_stores_on_reset_password_token", unique: true
  end

  create_table "book_stote_tags", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "book_store_id", null: false
    t.string "tag_name", default: "", null: false
  end

  create_table "customer_tags", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "customer_id", null: false
    t.string "tag_name", default: "", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.integer "age", null: false
    t.string "occupation", default: "", null: false
    t.string "address", default: "", null: false
    t.boolean "is_active", default: true, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "post_tags", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "customer_id", null: false
    t.integer "book_store_tag_id", null: false
    t.integer "review_id", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "book_store_id", null: false
    t.text "title", null: false
    t.text "content", null: false
  end

  create_table "request_comments", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "customer_id", null: false
    t.string "content", default: "", null: false
  end

  create_table "review_tags", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "book_store_id", null: false
    t.integer "customer_tag_id", null: false
    t.integer "review_id", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "customer_id", null: false
    t.integer "book_store_id", null: false
    t.string "thoughtse_comment", default: "", null: false
    t.float "evaluation_score", null: false
  end

  create_table "thoughtse_comments", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "customer_id", null: false
    t.integer "post_id", null: false
    t.float "evaluation_score", null: false
    t.string "content", default: "", null: false
  end

end
