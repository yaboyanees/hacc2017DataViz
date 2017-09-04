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

ActiveRecord::Schema.define(version: 20170901074056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grants", force: :cascade do |t|
<<<<<<< HEAD
    t.string "fiscal_year"
    t.string "grant_type"
    t.string "organization"
    t.text "project"
    t.decimal "amount", precision: 10, scale: 2
    t.string "location"
    t.string "strategic_priority"
    t.string "strategic_results"
=======
    t.integer "fiscal_year"
    t.text "grant_type"
    t.text "organization"
    t.text "project"
    t.decimal "amount", precision: 10, scale: 2
    t.text "location"
    t.text "strategic_priority"
    t.text "strategic_results"
>>>>>>> e98558437a7901ee9e387e4f89d25afb89cc82ea
    t.integer "total_served"
    t.integer "nh_served"
    t.integer "grantStatusID"
  end

  create_table "oha_data", id: false, force: :cascade do |t|
    t.integer "Fiscal_year"
    t.text "Grant_type"
    t.text "Organization"
    t.text "Project"
    t.float "Amount"
    t.text "Location"
    t.text "Strategic_priority"
    t.text "Strategic_results"
    t.integer "Total_served"
    t.integer "NH_Served"
    t.integer "Status"
  end

end
