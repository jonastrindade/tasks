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

ActiveRecord::Schema.define(version: 2021_03_15_045546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_account_entities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "name"
    t.string "cpf"
    t.index ["active"], name: "index_user_account_entities_on_active"
    t.index ["cpf"], name: "index_user_account_entities_on_cpf"
    t.index ["name"], name: "index_user_account_entities_on_name"
  end

  create_table "user_work_tracker_journeys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "project_id"
    t.string "results"
    t.datetime "date"
    t.index ["active"], name: "index_user_work_tracker_journeys_on_active"
    t.index ["date"], name: "index_user_work_tracker_journeys_on_date"
    t.index ["project_id"], name: "index_user_work_tracker_journeys_on_project_id"
  end

  create_table "user_work_tracker_projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.string "name"
    t.string "token"
    t.string "slug"
    t.string "description"
    t.integer "unit"
    t.integer "status"
    t.integer "total_tickets"
    t.integer "total_comments"
    t.integer "total_delays"
    t.integer "total_in_process"
    t.index ["slug"], name: "index_user_work_tracker_projects_on_slug", unique: true
    t.index ["status"], name: "index_user_work_tracker_projects_on_status"
    t.index ["token"], name: "index_user_work_tracker_projects_on_token", unique: true
    t.index ["unit"], name: "index_user_work_tracker_projects_on_unit"
  end

  create_table "user_work_tracker_relations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "precedent_id"
    t.bigint "dependent_id"
    t.string "name"
    t.boolean "status", default: false
    t.index ["dependent_id"], name: "index_user_work_tracker_relations_on_dependent_id"
    t.index ["precedent_id"], name: "index_user_work_tracker_relations_on_precedent_id"
    t.index ["status"], name: "index_user_work_tracker_relations_on_status"
  end

  create_table "user_work_tracker_squads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "project_id"
    t.bigint "team_id"
    t.string "team_name"
    t.integer "role"
    t.index ["project_id"], name: "index_user_work_tracker_squads_on_project_id"
    t.index ["role"], name: "index_user_work_tracker_squads_on_role"
    t.index ["team_id"], name: "index_user_work_tracker_squads_on_team_id"
  end

  create_table "user_work_tracker_stories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.bigint "project_id"
    t.string "name"
    t.string "description"
    t.string "token"
    t.string "slug"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer "stage"
    t.integer "status"
    t.integer "total_tickets"
    t.integer "total_comments"
    t.integer "total_delays"
    t.integer "total_in_process"
    t.index ["finished_at"], name: "index_user_work_tracker_stories_on_finished_at"
    t.index ["project_id"], name: "index_user_work_tracker_stories_on_project_id"
    t.index ["slug"], name: "index_user_work_tracker_stories_on_slug", unique: true
    t.index ["stage"], name: "index_user_work_tracker_stories_on_stage"
    t.index ["started_at"], name: "index_user_work_tracker_stories_on_started_at"
    t.index ["status"], name: "index_user_work_tracker_stories_on_status"
    t.index ["token"], name: "index_user_work_tracker_stories_on_token", unique: true
  end

  add_foreign_key "user_work_tracker_journeys", "user_work_tracker_projects", column: "project_id"
  add_foreign_key "user_work_tracker_relations", "user_work_tracker_stories", column: "dependent_id"
  add_foreign_key "user_work_tracker_relations", "user_work_tracker_stories", column: "precedent_id"
  add_foreign_key "user_work_tracker_squads", "user_account_entities", column: "team_id"
  add_foreign_key "user_work_tracker_squads", "user_work_tracker_projects", column: "project_id"
  add_foreign_key "user_work_tracker_stories", "user_work_tracker_projects", column: "project_id"
end
