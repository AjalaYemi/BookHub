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

ActiveRecord::Schema.define(version: 20151002133717) do

  create_table "authors", force: true do |t|
    t.string   "first_name", limit: 25,              null: false
    t.string   "last_name",  limit: 25, default: ""
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors_books", id: false, force: true do |t|
    t.integer "author_id"
    t.integer "book_id"
  end

  add_index "authors_books", ["author_id", "book_id"], name: "index_authors_books_on_author_id_and_book_id"

  create_table "authors_events", id: false, force: true do |t|
    t.integer "author_id"
    t.integer "event_id"
  end

  add_index "authors_events", ["author_id", "event_id"], name: "index_authors_events_on_author_id_and_event_id"

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
    t.string   "permalink"
    t.string   "front_avatar"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id"
  add_index "books", ["permalink"], name: "index_books_on_permalink"

  create_table "books_genres", id: false, force: true do |t|
    t.integer "book_id"
    t.integer "genre_id"
  end

  add_index "books_genres", ["book_id", "genre_id"], name: "index_books_genres_on_book_id_and_genre_id"

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

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "venue"
    t.string   "city"
    t.integer  "no_of_available_seats"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "genres", force: true do |t|
    t.string   "genre"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  add_index "reviews", ["book_id"], name: "index_reviews_on_book_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 50
    t.string   "email",           limit: 100, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",        limit: 25
    t.string   "password_digest"
  end

  add_index "users", ["username"], name: "index_users_on_username"

end
