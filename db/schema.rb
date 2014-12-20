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

ActiveRecord::Schema.define(version: 20141216234853) do

  create_table "actionable_dates", force: true do |t|
    t.datetime "day"
    t.string   "action"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.string   "icon_type",      default: "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["trackable_id"], name: "index_activities_on_trackable_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "auctions", force: true do |t|
    t.string   "patent_id"
    t.decimal  "price",            precision: 10, scale: 0
    t.decimal  "auction_price",    precision: 10, scale: 0
    t.integer  "business_won"
    t.integer  "business_winning"
    t.boolean  "paid",                                      default: false
    t.datetime "finish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "auto_responders", force: true do |t|
    t.text     "response"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "avatars", force: true do |t|
    t.string   "img_url"
    t.integer  "user_id"
    t.integer  "business_id"
    t.integer  "lawyer_id"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "main",             default: false
    t.integer  "patent_id"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
  end

  create_table "billings", force: true do |t|
    t.string   "stripe_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subscription_id"
  end

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.integer  "patents_bought"
    t.integer  "patents_licensed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "businesses", ["email"], name: "index_businesses_on_email", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "type"
    t.integer  "patent_total", default: 0
    t.integer  "user_total",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "patent_id"
    t.text     "content"
    t.integer  "business_id"
    t.integer  "lawyer_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.integer  "first_user_id"
    t.integer  "second_user_id"
    t.string   "conversation_subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_user_name"
    t.string   "second_user_name"
  end

  create_table "descriptions", force: true do |t|
    t.integer  "patent_id"
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ula_id"
  end

  create_table "file_offers", force: true do |t|
    t.integer  "user_id"
    t.integer  "patent_id"
    t.string   "offer"
    t.string   "note"
    t.boolean  "user_accept",   default: false
    t.boolean  "lawyer_accept", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "firms", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hint_boxes", force: true do |t|
    t.string   "page"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "publishable_key"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "invoices", force: true do |t|
    t.integer  "payer_id"
    t.integer  "payee_id"
    t.decimal  "pay_amount",   precision: 10, scale: 0, default: 0
    t.integer  "patent_id"
    t.string   "file_or_sell",                          default: "File"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "subtotal",     precision: 10, scale: 0, default: 0
    t.decimal  "fee",          precision: 10, scale: 0, default: 0
    t.string   "note"
    t.decimal  "hours",        precision: 10, scale: 0, default: 0
    t.boolean  "paid",                                  default: false
  end

  create_table "lawyer_offers", force: true do |t|
    t.integer  "patent_id"
    t.integer  "lawyer_id"
    t.string   "note"
    t.decimal  "amount",     precision: 10, scale: 0
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "notify",                              default: false
  end

  create_table "messengers", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.text     "message"
    t.boolean  "trash",                   default: false
    t.boolean  "seen",                    default: false
    t.boolean  "notify_seen",             default: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conversation_id"
    t.string   "sender_user_name"
    t.string   "receiver_user_name"
  end

  create_table "notices", force: true do |t|
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patents", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "lawyer_id"
    t.integer  "business_id"
    t.string   "patent_number"
    t.boolean  "created",                                 default: false
    t.boolean  "selling",                                 default: false
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category",                                default: ""
    t.boolean  "visible",                                 default: true
    t.string   "tags",                                    default: ""
    t.boolean  "live",                                    default: false
    t.boolean  "provisional"
    t.decimal  "billable_hours", precision: 10, scale: 0, default: 0
    t.string   "lawyer_accept",                           default: ""
    t.boolean  "name_visible",                            default: false
  end

  create_table "payments", force: true do |t|
    t.integer  "user_id"
    t.integer  "lawyer_id"
    t.integer  "patent_id"
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid",                                  default: false
    t.decimal  "amount",       precision: 10, scale: 0, default: 0
    t.datetime "payment_date"
  end

  create_table "potentials", force: true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "telephone"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "verify_token"
    t.boolean  "verified",     default: false
  end

  create_table "searches", force: true do |t|
    t.string  "term"
    t.integer "user_id"
  end

  create_table "sell_offers", force: true do |t|
    t.integer  "user_id"
    t.integer  "paent_id"
    t.string   "offer"
    t.string   "note"
    t.boolean  "user_accept",     default: false
    t.boolean  "business_accept", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_numbers", force: true do |t|
    t.integer  "hit_count",           default: 0
    t.integer  "total_sign_in_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stars", force: true do |t|
    t.float    "number",     limit: 24
    t.integer  "user_id"
    t.integer  "master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.string   "request_type"
    t.string   "mood"
    t.integer  "user_id"
    t.text     "msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ulas", force: true do |t|
    t.integer  "patent_id"
    t.integer  "user_id"
    t.integer  "lawyer_id"
    t.boolean  "lawyer_accept"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                                      default: "",    null: false
    t.string   "encrypted_password",                                         default: "",    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                              default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                                                      default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "lawyer",                                                     default: false
    t.boolean  "business",                                                   default: false
    t.string   "phone"
    t.string   "firm_name"
    t.string   "business_name"
    t.string   "job_title"
    t.string   "middle_name"
    t.integer  "firm_id"
    t.integer  "business_id"
    t.string   "birthdate"
    t.string   "state"
    t.string   "address"
    t.string   "address_two"
    t.string   "city"
    t.string   "fax"
    t.string   "phone_type"
    t.string   "fax_type"
    t.string   "country"
    t.integer  "hit_count",                                                  default: 0
    t.boolean  "sell_patent",                                                default: false
    t.boolean  "new_patent",                                                 default: false
    t.float    "star_score",             limit: 24,                          default: 0.0
    t.integer  "star_count",                                                 default: 0
    t.text     "facebook_token"
    t.text     "twitter_token"
    t.text     "linked_in_token"
    t.datetime "facebook_expires_at"
    t.datetime "twitter_expires_at"
    t.datetime "linked_in_expires_at"
    t.decimal  "bill_per_hour",                     precision: 10, scale: 0, default: 0
    t.boolean  "first_time",                                                 default: true
    t.string   "monthly_or_fee"
    t.string   "authentication_token"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.integer  "patent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
