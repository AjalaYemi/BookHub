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

ActiveRecord::Schema.define(version: 20151112115904) do

  create_table "book_exchanges", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.string   "transaction_type"
    t.datetime "initiated"
    t.datetime "accepted"
    t.datetime "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_exchanges", ["user_id", "book_id"], name: "index_book_exchanges_on_user_id_and_book_id"

  create_table "books", force: true do |t|
    t.string   "name"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "publisher",      default: ""
    t.date     "published_year"
    t.integer  "word_count"
    t.integer  "page_count"
    t.string   "isbn",           default: ""
    t.string   "url"
    t.string   "front_avatar"
    t.integer  "created_by",     default: 0
    t.integer  "updated_by",     default: 0
    t.text     "bio"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id"
  add_index "books", ["url"], name: "index_books_on_url"

  create_table "comments", force: true do |t|
    t.text     "comment",    limit: 250
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "review_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["book_id"], name: "index_comments_on_book_id"
  add_index "comments", ["event_id"], name: "index_comments_on_event_id"
  add_index "comments", ["review_id"], name: "index_comments_on_review_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "venue"
    t.string   "city"
    t.integer  "no_of_available_seats"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",            default: 0
    t.text     "description"
    t.string   "avatar"
    t.string   "url"
  end

  create_table "events_users", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "events_users", ["event_id", "user_id"], name: "index_events_users_on_event_id_and_user_id"

  create_table "profiles", force: true do |t|
    t.string   "name"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.text     "review"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "url"
  end

  add_index "reviews", ["book_id"], name: "index_reviews_on_book_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "first_name",             limit: 25
    t.string   "last_name",              limit: 50
    t.string   "email",                  limit: 100, default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 25
    t.string   "password_digest"
    t.string   "encrypted_password",                 default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                    default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "admin",                              default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username"

  Foreigner.load
end
