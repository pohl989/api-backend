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

ActiveRecord::Schema.define(version: 2020_08_11_152949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "condos", force: :cascade do |t|
    t.decimal "price", default: "300000.0"
    t.decimal "hoa", default: "400.0"
    t.decimal "tax"
    t.decimal "insurance"
    t.string "name"
    t.string "notes"
    t.bigint "mortgage_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mortgage_id"], name: "index_condos_on_mortgage_id"
  end

  create_table "mortgages", force: :cascade do |t|
    t.decimal "rate", default: "2.875"
    t.integer "years", default: 30
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["status"], name: "index_projects_on_status"
  end

  create_table "stations", force: :cascade do |t|
    t.integer "stop_id"
    t.string "direction_id"
    t.string "stop_name"
    t.string "station_name"
    t.string "station_descriptive_name"
    t.integer "map_id"
    t.boolean "ada"
    t.boolean "red"
    t.boolean "blue"
    t.boolean "g"
    t.boolean "brn"
    t.boolean "p"
    t.boolean "pexp"
    t.boolean "y"
    t.boolean "pnk"
    t.boolean "o"
    t.jsonb "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
