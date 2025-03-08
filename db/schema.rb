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

ActiveRecord::Schema[8.0].define(version: 2025_03_06_172657) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "influencers", force: :cascade do |t|
    t.string "external_id"
    t.boolean "is_manual", default: true, null: false
    t.string "username", null: false
    t.string "fullname", null: false
    t.string "picture", null: false
    t.integer "followers", null: false
    t.boolean "is_verified", null: false
    t.integer "platform", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id", "platform"], name: "index_influencers_on_external_id_and_platform", unique: true
    t.index ["username", "platform"], name: "index_influencers_on_username_and_platform", unique: true
  end
end
