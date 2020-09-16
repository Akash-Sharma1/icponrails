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

ActiveRecord::Schema.define(version: 20200916092144) do

  create_table "interviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
    t.datetime "startTime", null: false
    t.datetime "endTime", null: false
    t.bigint "participant1_id", null: false
    t.bigint "participant2_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["participant1_id"], name: "index_interviews_on_participant1_id"
    t.index ["participant2_id"], name: "index_interviews_on_participant2_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci" do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resume_file_name"
    t.string "resume_content_type"
    t.bigint "resume_file_size"
    t.datetime "resume_updated_at"
    t.string "usertype", null: false
  end

  add_foreign_key "interviews", "users", column: "participant1_id"
  add_foreign_key "interviews", "users", column: "participant2_id"
end
