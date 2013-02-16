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

ActiveRecord::Schema.define(:version => 20130210153910) do

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "sub_domain"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.text     "welcome_message"
    t.string   "heading1"
    t.string   "heading2"
    t.string   "heading3"
    t.text     "message1"
    t.text     "message2"
    t.text     "message3"
    t.integer  "token_id"
    t.integer  "subscription_id"
    t.boolean  "active"
    t.text     "about"
    t.string   "oath_token"
    t.string   "oath_token_secret"
    t.integer  "fee"
    t.string   "stripe_publishable_key"
    t.string   "stripe_api_key"
    t.string   "contact_email"
    t.text     "terms_and_conditions"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.boolean  "all_day",     :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "club_id"
    t.string   "title"
    t.text     "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "limit"
  end

  add_index "events", ["club_id"], :name => "events_club_idx"

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "club_id"
    t.boolean  "admin"
  end

  add_index "forums", ["club_id"], :name => "forums_club_idx"

  create_table "forums_users", :id => false, :force => true do |t|
    t.integer "forum_id"
    t.integer "user_id"
  end

  add_index "forums_users", ["forum_id"], :name => "index_forums_users_on_forum_id"
  add_index "forums_users", ["user_id"], :name => "index_forums_users_on_user_id"

  create_table "lists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "lists", ["event_id"], :name => "lists_event_idx"
  add_index "lists", ["user_id"], :name => "lists_user_idx"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "notices", :force => true do |t|
    t.string   "content"
    t.integer  "club_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notices", ["club_id"], :name => "notices_club_idx"

  create_table "posts", :force => true do |t|
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "topic_id"
    t.integer  "user_id"
    t.integer  "club_id"
  end

  add_index "posts", ["club_id"], :name => "posts_club_idx"
  add_index "posts", ["topic_id"], :name => "posts_topic_idx"
  add_index "posts", ["user_id"], :name => "posts_user_idx"

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "age"
    t.text     "bio"
    t.string   "blog"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "econtact_name"
    t.string   "econtact_number"
  end

  add_index "profiles", ["user_id"], :name => "profiles_user_idx"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "sponsors", :force => true do |t|
    t.integer  "club_id"
    t.string   "name"
    t.string   "image_name"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  add_index "sponsors", ["club_id"], :name => "sponsors_club_idx"

  create_table "subscriptions", :force => true do |t|
    t.string   "email"
    t.string   "stripe_customer_token"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "tokens", :force => true do |t|
    t.string   "api_token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "club_id"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.integer  "last_poster_id"
    t.datetime "last_post_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "forum_id"
    t.integer  "user_id"
  end

  add_index "topics", ["forum_id"], :name => "topics_forum_idx"
  add_index "topics", ["user_id"], :name => "topics_user_idx"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  :default => false
    t.boolean  "forum",                  :default => false
    t.string   "reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "club_id"
    t.boolean  "active",                 :default => false
    t.string   "confirm_token"
    t.datetime "anniversary"
    t.string   "stripe_id"
    t.integer  "referral_count"
  end

  add_index "users", ["club_id"], :name => "users_club_idx"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
