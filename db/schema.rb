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

ActiveRecord::Schema[7.0].define(version: 20_220_427_075_106) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'task_ranges', force: :cascade do |t|
    t.string 'from'
    t.string 'to'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'task_id', null: false
    t.index ['task_id'], name: 'index_task_ranges_on_task_id'
  end

  create_table 'tasks', force: :cascade do |t|
    t.string 'task_name'
    t.string 'task_category'
    t.string 'task_ranges'
    t.string 'task_status'
    t.integer 'cost'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_tasks_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'password_digest'
    t.uuid 'uuid', default: -> { 'gen_random_uuid()' }
    t.string 'tasks'
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'task_ranges', 'tasks'
  add_foreign_key 'tasks', 'users'
end
