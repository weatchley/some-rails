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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "associates", :force => true do |t|
    t.integer "company_id", :null => false
    t.integer "user_id",    :null => false
  end

  create_table "calendar", :force => true do |t|
    t.integer "company_id",                    :null => false
    t.integer "client_id"
    t.boolean "showed_up",  :default => false, :null => false
    t.date    "event_date",                    :null => false
    t.time    "begin",                         :null => false
    t.time    "end",                           :null => false
    t.string  "notes"
  end

  create_table "clients", :force => true do |t|
    t.integer  "company_id",                    :null => false
    t.string   "last_name",                     :null => false
    t.string   "first_name",                    :null => false
    t.string   "middle_name"
    t.boolean  "active",      :default => true, :null => false
    t.string   "occupation"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "fax"
    t.datetime "last_seen"
    t.integer  "location_id"
    t.string   "notes"
  end

  create_table "companies", :force => true do |t|
    t.string  "company_name"
    t.boolean "active",       :default => true, :null => false
    t.string  "address",                        :null => false
    t.string  "city",                           :null => false
    t.string  "state",                          :null => false
    t.string  "zip",                            :null => false
    t.string  "phone"
    t.string  "fax"
    t.string  "web_site"
  end

  create_table "invoice_ids", :force => true do |t|
    t.integer "company_id",                  :null => false
    t.date    "invoice_date",                :null => false
    t.integer "invoice_id",   :default => 1, :null => false
  end

  create_table "invoices", :force => true do |t|
    t.integer  "company_id",   :null => false
    t.integer  "invoice_id",   :null => false
    t.integer  "client_id",    :null => false
    t.datetime "invoice_date", :null => false
    t.string   "status",       :null => false
    t.string   "data",         :null => false
  end

  create_table "locations", :force => true do |t|
    t.integer "company_id",  :null => false
    t.string  "description"
  end

  create_table "privs", :force => true do |t|
    t.string "description"
  end

  create_table "user_privs", :force => true do |t|
    t.integer "company_id", :null => false
    t.integer "user_id",    :null => false
    t.integer "priv_id",    :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "company_id",                           :null => false
    t.string   "username",                             :null => false
    t.boolean  "active",             :default => true, :null => false
    t.string   "email",                                :null => false
    t.string   "password",                             :null => false
    t.string   "first_name",                           :null => false
    t.string   "last_name",                            :null => false
    t.string   "phone"
    t.integer  "failed_login_count", :default => 0,    :null => false
    t.datetime "last_attempt"
    t.string   "security_question",                    :null => false
    t.string   "security_answer",                      :null => false
    t.datetime "last_login"
    t.datetime "date_created"
    t.datetime "date_canceled"
  end

end
