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

ActiveRecord::Schema[7.0].define(version: 2023_09_07_035008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "event_visibilities", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_visibilities_on_event_id"
    t.index ["user_id"], name: "index_event_visibilities_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "event_type"
    t.string "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text "content"
    t.integer "visibility"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name", null: false
    t.date "established_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_id"
    t.index ["admin_id"], name: "index_families_on_admin_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "token"
    t.bigint "family_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expires_at"
    t.index ["family_id"], name: "index_invitations_on_family_id"
  end

  create_table "memories", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "date"
    t.string "title"
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_memories_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "family_id"
    t.string "relationship"
    t.date "birthdate"
    t.integer "age"
    t.string "constellation"
    t.string "blood_type"
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["family_id"], name: "index_users_on_family_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "event_visibilities", "events"
  add_foreign_key "event_visibilities", "users"
  add_foreign_key "events", "users"
  add_foreign_key "families", "users", column: "admin_id"
  add_foreign_key "invitations", "families"
  add_foreign_key "memories", "events"
  add_foreign_key "users", "families"
end
