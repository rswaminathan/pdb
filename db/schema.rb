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

ActiveRecord::Schema.define(:version => 20110226074123) do

  create_table "admins", :force => true do |t|
    t.text      "email_list"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string    "body"
    t.integer   "user_id"
    t.integer   "project_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "likes", :force => true do |t|
    t.integer   "project_id"
    t.integer   "user_id"
    t.string    "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "pre_users", :force => true do |t|
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "facebook_id"
    t.string    "facebook"
  end

  create_table "pre_users_projects", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "pre_user_id"
  end

  create_table "profiles", :force => true do |t|
    t.text      "about"
    t.string    "institution"
    t.string    "occupation"
    t.integer   "year"
    t.text      "skills"
    t.string    "facebook"
    t.string    "twitter"
    t.string    "linked_in"
    t.string    "website"
    t.string    "other"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "photo_file_name"
    t.string    "photo_content_type"
    t.integer   "photo_file_size"
    t.string    "department"
    t.string    "top_tags"
    t.text      "quote"
    t.string    "interesting_photo_file_name"
    t.string    "interesting_photo_content_type"
    t.integer   "interesting_photo_file_size"
    t.string    "awesome_photo_file_name"
    t.string    "awesome_photo_content_type"
    t.integer   "awesome_photo_file_size"
  end

  create_table "project_pages", :force => true do |t|
    t.string    "title"
    t.text      "content"
    t.integer   "project_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.string    "kind"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "photo_file_name"
    t.string    "photo_content_type"
    t.integer   "photo_file_size"
    t.string    "abstract"
    t.integer   "count"
    t.string    "mainfile_file_name"
    t.string    "mainfile_content_type"
    t.integer   "mainfile_file_size"
  end

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  create_table "relationship_projects", :force => true do |t|
    t.integer   "follower_id"
    t.integer   "followed_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "relationship_projects", ["followed_id"], :name => "index_relationship_projects_on_followed_id"
  add_index "relationship_projects", ["follower_id", "followed_id"], :name => "index_relationship_projects_on_follower_id_and_followed_id", :unique => true
  add_index "relationship_projects", ["follower_id"], :name => "index_relationship_projects_on_follower_id"

  create_table "relationship_users", :force => true do |t|
    t.integer   "follower_id"
    t.integer   "followed_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "relationship_users", ["followed_id"], :name => "index_relationship_users_on_followed_id"
  add_index "relationship_users", ["follower_id", "followed_id"], :name => "index_relationship_users_on_follower_id_and_followed_id", :unique => true
  add_index "relationship_users", ["follower_id"], :name => "index_relationship_users_on_follower_id"

  create_table "sections", :force => true do |t|
    t.string    "title"
    t.text      "content"
    t.string    "photo_file_name"
    t.string    "photo_content_type"
    t.integer   "photo_file_size"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "project_page_id"
  end

  add_index "sections", ["project_page_id"], :name => "index_sections_on_project_page_id"

  create_table "taggings", :force => true do |t|
    t.integer   "tag_id"
    t.integer   "taggable_id"
    t.string    "taggable_type"
    t.integer   "tagger_id"
    t.string    "tagger_type"
    t.string    "context"
    t.timestamp "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "encrypted_password"
    t.string    "salt"
    t.string    "facebook_token"
    t.string    "uid"
    t.string    "provider"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
