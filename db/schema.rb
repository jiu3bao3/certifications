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

ActiveRecord::Schema[7.1].define(version: 2023_12_30_025043) do
  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", comment: "カテゴリー", force: :cascade do |t|
    t.string "name_ja", null: false, comment: "カテゴリー名"
    t.string "name_en", comment: "カテゴリー英語名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "certificaters", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", comment: "認定者", force: :cascade do |t|
    t.string "name_ja", null: false, comment: "認定者名"
    t.string "name_en", comment: "認定者英語名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "examiners", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", comment: "試験実施者", force: :cascade do |t|
    t.string "name", null: false, comment: "試験実施者名"
    t.bigint "corporate_number", comment: "法人番号"
    t.string "zipcode", comment: "郵便番号"
    t.string "address", comment: "所在地"
    t.string "url", comment: "URL"
    t.string "tel", comment: "電話番号"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grades", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", comment: "グレード", force: :cascade do |t|
    t.bigint "qualification_id", null: false, comment: "資格ID"
    t.string "grade_name", comment: "グレード"
    t.integer "display_order", default: 0, null: false, comment: "表示順"
    t.string "description", comment: "説明"
    t.bigint "certificater_id", null: false, comment: "認定者"
    t.bigint "examiner_id", comment: "試験実施者"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["certificater_id"], name: "index_grades_on_certificater_id"
    t.index ["examiner_id"], name: "index_grades_on_examiner_id"
    t.index ["qualification_id", "grade_name"], name: "index_grades_on_qualification_id_and_grade_name", unique: true
    t.index ["qualification_id"], name: "index_grades_on_qualification_id"
  end

  create_table "qualifications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", comment: "資格", force: :cascade do |t|
    t.string "name_ja", null: false, comment: "資格名"
    t.string "name_en", comment: "資格英語名"
    t.integer "classification", default: 0, null: false, comment: "区分"
    t.text "description", comment: "説明"
    t.bigint "category_id", null: false, comment: "カテゴリー"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_qualifications_on_category_id"
  end

  add_foreign_key "grades", "certificaters"
  add_foreign_key "grades", "examiners"
  add_foreign_key "grades", "qualifications"
  add_foreign_key "qualifications", "categories"
end
