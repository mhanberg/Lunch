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

ActiveRecord::Schema.define(version: 20171004211209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_users", force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "group_id", null: false
    t.integer "role"
    t.index ["user_id", "group_id"], name: "index_groups_users_on_user_id_and_group_id", unique: true, using: :btree
  end

  create_table "meals", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "category"
    t.integer  "group_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.date     "meal_date"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "meal_id"
    t.integer "user_id"
    t.integer "score"
    t.text    "comment"
    t.index ["meal_id", "user_id"], name: "index_ratings_on_meal_id_and_user_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "remember_digest"
    t.integer  "default_group_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
