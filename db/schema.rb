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

ActiveRecord::Schema.define(version: 2020_03_30_212804) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "request_logs", force: :cascade do |t|
    t.string "request_path", null: false
    t.text "request_body"
    t.string "response_code"
    t.text "response_body"
    t.boolean "success"
    t.bigint "response_template_id"
    t.string "error_text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["response_template_id"], name: "index_request_logs_on_response_template_id"
  end

  create_table "response_rules", force: :cascade do |t|
    t.string "name"
    t.string "path"
    t.bigint "response_template_id", null: false
    t.integer "response_code"
    t.text "conditions"
    t.integer "sleep"
    t.boolean "raise_error"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["response_template_id"], name: "index_response_rules_on_response_template_id"
  end

  create_table "response_templates", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "request_logs", "response_templates"
  add_foreign_key "response_rules", "response_templates"
end
