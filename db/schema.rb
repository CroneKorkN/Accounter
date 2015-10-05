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

ActiveRecord::Schema.define(version: 20151005095413) do

  create_table "account_templates", primary_key: "number", force: :cascade do |t|
    t.string   "name",             limit: 255, default: ""
    t.string   "close_via_number", limit: 255
    t.boolean  "has_initial",      limit: 1,   default: false
    t.integer  "order",            limit: 4,   default: 0
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "account_templates", ["close_via_number"], name: "index_account_templates_on_close_via_number", using: :btree
  add_index "account_templates", ["has_initial"], name: "index_account_templates_on_has_initial", using: :btree
  add_index "account_templates", ["name"], name: "index_account_templates_on_name", using: :btree
  add_index "account_templates", ["number"], name: "index_account_templates_on_number", using: :btree
  add_index "account_templates", ["order"], name: "index_account_templates_on_order", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.string   "number",     limit: 255
    t.integer  "task_id",    limit: 4
    t.decimal  "initial",                precision: 15, scale: 2, default: 0.0
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.boolean  "show",       limit: 1,                            default: false
  end

  add_index "accounts", ["number"], name: "index_accounts_on_number", using: :btree
  add_index "accounts", ["show"], name: "index_accounts_on_show", using: :btree
  add_index "accounts", ["task_id"], name: "index_accounts_on_task_id", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer  "record_id",        limit: 4
    t.integer  "account_id",       limit: 4
    t.decimal  "value",                      precision: 15, scale: 2, default: 0.0
    t.boolean  "debit_not_credit", limit: 1,                          default: true
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
  end

  add_index "entries", ["account_id"], name: "index_entries_on_account_id", using: :btree
  add_index "entries", ["record_id"], name: "index_entries_on_record_id", using: :btree

  create_table "observers", force: :cascade do |t|
    t.string   "session_id", limit: 255
    t.integer  "task_id",    limit: 4
    t.datetime "updated_at"
  end

  add_index "observers", ["session_id"], name: "index_observers_on_session_id", using: :btree
  add_index "observers", ["task_id"], name: "index_observers_on_task_id", using: :btree

  create_table "patches", force: :cascade do |t|
    t.integer "observer_id",    limit: 4
    t.integer "patchable_id",   limit: 4
    t.string  "patchable_type", limit: 255
    t.integer "method_id",      limit: 4
    t.integer "user_id",        limit: 4
  end

  add_index "patches", ["observer_id"], name: "index_patches_on_observer_id", using: :btree
  add_index "patches", ["patchable_type", "patchable_id"], name: "index_patches_on_patchable_type_and_patchable_id", using: :btree
  add_index "patches", ["user_id"], name: "index_patches_on_user_id", using: :btree

  create_table "records", force: :cascade do |t|
    t.integer  "task_id",    limit: 4
    t.integer  "order",      limit: 4, default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "records", ["order"], name: "index_records_on_order", using: :btree
  add_index "records", ["task_id"], name: "index_records_on_task_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name",       limit: 255, default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "current_task_id", limit: 4
  end

  add_index "users", ["current_task_id"], name: "index_users_on_current_task_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree

  add_foreign_key "accounts", "tasks"
  add_foreign_key "entries", "accounts"
  add_foreign_key "entries", "records"
  add_foreign_key "observers", "tasks"
  add_foreign_key "patches", "observers"
  add_foreign_key "patches", "users"
  add_foreign_key "records", "tasks"
  add_foreign_key "tasks", "users"
  add_foreign_key "users", "tasks", column: "current_task_id"
end
