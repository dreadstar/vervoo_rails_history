# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110204150854) do

  create_table "activities", :force => true do |t|
    t.string   "name",               :limit => 50,                                                    :null => false
    t.string   "description",        :limit => 500,                                                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",                                                          :default => false
    t.integer  "created_by_user_id",                                               :default => 1
    t.integer  "activity_type_id"
    t.decimal  "amt",                               :precision => 10, :scale => 2,                    :null => false
  end

  add_index "activities", ["created_by_user_id"], :name => "fk_activities_created_by_user_id"

  create_table "activity_tags", :force => true do |t|
    t.integer  "activity_id", :null => false
    t.integer  "tag_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_tags", ["activity_id"], :name => "fk_activity_tags_activity_id"
  add_index "activity_tags", ["tag_id"], :name => "fk_activity_tags_tag_id"

  create_table "bak_banner", :primary_key => "bid", :force => true do |t|
    t.integer  "cid",                             :default => 0,        :null => false
    t.string   "type",             :limit => 30,  :default => "banner", :null => false
    t.string   "name",                            :default => "",       :null => false
    t.string   "alias",                           :default => "",       :null => false
    t.integer  "imptotal",                        :default => 0,        :null => false
    t.integer  "impmade",                         :default => 0,        :null => false
    t.integer  "clicks",                          :default => 0,        :null => false
    t.string   "imageurl",         :limit => 100, :default => "",       :null => false
    t.string   "clickurl",         :limit => 200, :default => "",       :null => false
    t.datetime "date"
    t.boolean  "showBanner",                      :default => false,    :null => false
    t.boolean  "checked_out",                     :default => false,    :null => false
    t.datetime "checked_out_time",                                      :null => false
    t.string   "editor",           :limit => 50
    t.text     "custombannercode"
    t.integer  "catid",                           :default => 0,        :null => false
    t.text     "description",                                           :null => false
    t.boolean  "sticky",                          :default => false,    :null => false
    t.integer  "ordering",                        :default => 0,        :null => false
    t.datetime "publish_up",                                            :null => false
    t.datetime "publish_down",                                          :null => false
    t.text     "tags",                                                  :null => false
    t.text     "params",                                                :null => false
  end

  add_index "bak_banner", ["catid"], :name => "idx_banner_catid"
  add_index "bak_banner", ["showBanner"], :name => "viewbanner"

  create_table "bak_bannerclient", :primary_key => "cid", :force => true do |t|
    t.string  "name",                           :default => "",    :null => false
    t.string  "contact",                        :default => "",    :null => false
    t.string  "email",                          :default => "",    :null => false
    t.text    "extrainfo",                                         :null => false
    t.boolean "checked_out",                    :default => false, :null => false
    t.time    "checked_out_time"
    t.string  "editor",           :limit => 50
  end

  create_table "bak_bannertrack", :id => false, :force => true do |t|
    t.date    "track_date", :null => false
    t.integer "track_type", :null => false
    t.integer "banner_id",  :null => false
  end

  create_table "bak_categories", :force => true do |t|
    t.integer  "parent_id",                      :default => 0,     :null => false
    t.string   "title",                          :default => "",    :null => false
    t.string   "name",                           :default => "",    :null => false
    t.string   "alias",                          :default => "",    :null => false
    t.string   "image",                          :default => "",    :null => false
    t.string   "section",          :limit => 50, :default => "",    :null => false
    t.string   "image_position",   :limit => 30, :default => "",    :null => false
    t.text     "description",                                       :null => false
    t.boolean  "published",                      :default => false, :null => false
    t.integer  "checked_out",                    :default => 0,     :null => false
    t.datetime "checked_out_time",                                  :null => false
    t.string   "editor",           :limit => 50
    t.integer  "ordering",                       :default => 0,     :null => false
    t.integer  "access",           :limit => 1,  :default => 0,     :null => false
    t.integer  "count",                          :default => 0,     :null => false
    t.text     "params",                                            :null => false
  end

  add_index "bak_categories", ["access"], :name => "idx_access"
  add_index "bak_categories", ["checked_out"], :name => "idx_checkout"
  add_index "bak_categories", ["section", "published", "access"], :name => "cat_idx"

  create_table "bak_components", :force => true do |t|
    t.string  "name",            :limit => 50, :default => "", :null => false
    t.string  "link",                          :default => "", :null => false
    t.integer "menuid",                        :default => 0,  :null => false
    t.integer "parent",                        :default => 0,  :null => false
    t.string  "admin_menu_link",               :default => "", :null => false
    t.string  "admin_menu_alt",                :default => "", :null => false
    t.string  "option",          :limit => 50, :default => "", :null => false
    t.integer "ordering",                      :default => 0,  :null => false
    t.string  "admin_menu_img",                :default => "", :null => false
    t.integer "iscore",          :limit => 1,  :default => 0,  :null => false
    t.text    "params",                                        :null => false
    t.integer "enabled",         :limit => 1,  :default => 1,  :null => false
  end

  add_index "bak_components", ["parent", "option"], :name => "parent_option"

  create_table "bak_contact_details", :force => true do |t|
    t.string   "name",                                 :default => "",    :null => false
    t.string   "alias",                                :default => "",    :null => false
    t.string   "con_position"
    t.text     "address"
    t.string   "suburb",           :limit => 100
    t.string   "state",            :limit => 100
    t.string   "country",          :limit => 100
    t.string   "postcode",         :limit => 100
    t.string   "telephone"
    t.string   "fax"
    t.text     "misc",             :limit => 16777215
    t.string   "image"
    t.string   "imagepos",         :limit => 20
    t.string   "email_to"
    t.boolean  "default_con",                          :default => false, :null => false
    t.boolean  "published",                            :default => false, :null => false
    t.integer  "checked_out",                          :default => 0,     :null => false
    t.datetime "checked_out_time",                                        :null => false
    t.integer  "ordering",                             :default => 0,     :null => false
    t.text     "params",                                                  :null => false
    t.integer  "user_id",                              :default => 0,     :null => false
    t.integer  "catid",                                :default => 0,     :null => false
    t.integer  "access",           :limit => 1,        :default => 0,     :null => false
    t.string   "mobile",                               :default => "",    :null => false
    t.string   "webpage",                              :default => "",    :null => false
  end

  add_index "bak_contact_details", ["catid"], :name => "catid"

  create_table "bak_content", :force => true do |t|
    t.string   "title",                                :default => "", :null => false
    t.string   "alias",                                :default => "", :null => false
    t.string   "title_alias",                          :default => "", :null => false
    t.text     "introtext",        :limit => 16777215,                 :null => false
    t.text     "fulltext",         :limit => 16777215,                 :null => false
    t.integer  "state",            :limit => 1,        :default => 0,  :null => false
    t.integer  "sectionid",                            :default => 0,  :null => false
    t.integer  "mask",                                 :default => 0,  :null => false
    t.integer  "catid",                                :default => 0,  :null => false
    t.datetime "created",                                              :null => false
    t.integer  "created_by",                           :default => 0,  :null => false
    t.string   "created_by_alias",                     :default => "", :null => false
    t.datetime "modified",                                             :null => false
    t.integer  "modified_by",                          :default => 0,  :null => false
    t.integer  "checked_out",                          :default => 0,  :null => false
    t.datetime "checked_out_time",                                     :null => false
    t.datetime "publish_up",                                           :null => false
    t.datetime "publish_down",                                         :null => false
    t.text     "images",                                               :null => false
    t.text     "urls",                                                 :null => false
    t.text     "attribs",                                              :null => false
    t.integer  "version",                              :default => 1,  :null => false
    t.integer  "parentid",                             :default => 0,  :null => false
    t.integer  "ordering",                             :default => 0,  :null => false
    t.text     "metakey",                                              :null => false
    t.text     "metadesc",                                             :null => false
    t.integer  "access",                               :default => 0,  :null => false
    t.integer  "hits",                                 :default => 0,  :null => false
    t.text     "metadata",                                             :null => false
  end

  add_index "bak_content", ["access"], :name => "idx_access"
  add_index "bak_content", ["catid"], :name => "idx_catid"
  add_index "bak_content", ["checked_out"], :name => "idx_checkout"
  add_index "bak_content", ["created_by"], :name => "idx_createdby"
  add_index "bak_content", ["sectionid"], :name => "idx_section"
  add_index "bak_content", ["state"], :name => "idx_state"

  create_table "bak_content_frontpage", :primary_key => "content_id", :force => true do |t|
    t.integer "ordering", :default => 0, :null => false
  end

  create_table "bak_content_rating", :primary_key => "content_id", :force => true do |t|
    t.integer "rating_sum",                 :default => 0,  :null => false
    t.integer "rating_count",               :default => 0,  :null => false
    t.string  "lastip",       :limit => 50, :default => "", :null => false
  end

  create_table "bak_core_acl_aro", :force => true do |t|
    t.string  "section_value", :limit => 240, :default => "0", :null => false
    t.string  "value",         :limit => 240, :default => "",  :null => false
    t.integer "order_value",                  :default => 0,   :null => false
    t.string  "name",                         :default => "",  :null => false
    t.integer "hidden",                       :default => 0,   :null => false
  end

  add_index "bak_core_acl_aro", ["hidden"], :name => "jos_gacl_hidden_aro"
  add_index "bak_core_acl_aro", ["section_value", "value"], :name => "jos_section_value_value_aro", :unique => true

  create_table "bak_core_acl_aro_groups", :force => true do |t|
    t.integer "parent_id", :default => 0,  :null => false
    t.string  "name",      :default => "", :null => false
    t.integer "lft",       :default => 0,  :null => false
    t.integer "rgt",       :default => 0,  :null => false
    t.string  "value",     :default => "", :null => false
  end

  add_index "bak_core_acl_aro_groups", ["lft", "rgt"], :name => "jos_gacl_lft_rgt_aro_groups"
  add_index "bak_core_acl_aro_groups", ["parent_id"], :name => "jos_gacl_parent_id_aro_groups"

  create_table "bak_core_acl_aro_map", :id => false, :force => true do |t|
    t.integer "acl_id",                       :default => 0,   :null => false
    t.string  "section_value", :limit => 230, :default => "0", :null => false
    t.string  "value",         :limit => 100,                  :null => false
  end

  create_table "bak_core_acl_aro_sections", :force => true do |t|
    t.string  "value",       :limit => 230, :default => "", :null => false
    t.integer "order_value",                :default => 0,  :null => false
    t.string  "name",        :limit => 230, :default => "", :null => false
    t.integer "hidden",                     :default => 0,  :null => false
  end

  add_index "bak_core_acl_aro_sections", ["hidden"], :name => "jos_gacl_hidden_aro_sections"
  add_index "bak_core_acl_aro_sections", ["value"], :name => "jos_gacl_value_aro_sections", :unique => true

  create_table "bak_core_acl_groups_aro_map", :id => false, :force => true do |t|
    t.integer "group_id",                     :default => 0,  :null => false
    t.string  "section_value", :limit => 240, :default => "", :null => false
    t.integer "aro_id",                       :default => 0,  :null => false
  end

  add_index "bak_core_acl_groups_aro_map", ["group_id", "section_value", "aro_id"], :name => "group_id_aro_id_groups_aro_map", :unique => true

  create_table "bak_core_log_items", :id => false, :force => true do |t|
    t.date    "time_stamp",                               :null => false
    t.string  "item_table", :limit => 50, :default => "", :null => false
    t.integer "item_id",                  :default => 0,  :null => false
    t.integer "hits",                     :default => 0,  :null => false
  end

  create_table "bak_core_log_searches", :id => false, :force => true do |t|
    t.string  "search_term", :limit => 128, :default => "", :null => false
    t.integer "hits",                       :default => 0,  :null => false
  end

  create_table "bak_groups", :force => true do |t|
    t.string "name", :limit => 50, :default => "", :null => false
  end

  create_table "bak_menu", :force => true do |t|
    t.string   "menutype",         :limit => 75
    t.string   "name"
    t.string   "alias",                          :default => "",    :null => false
    t.text     "link"
    t.string   "type",             :limit => 50, :default => "",    :null => false
    t.boolean  "published",                      :default => false, :null => false
    t.integer  "parent",                         :default => 0,     :null => false
    t.integer  "componentid",                    :default => 0,     :null => false
    t.integer  "sublevel",                       :default => 0
    t.integer  "ordering",                       :default => 0
    t.integer  "checked_out",                    :default => 0,     :null => false
    t.datetime "checked_out_time",                                  :null => false
    t.integer  "pollid",                         :default => 0,     :null => false
    t.integer  "browserNav",       :limit => 1,  :default => 0
    t.integer  "access",           :limit => 1,  :default => 0,     :null => false
    t.integer  "utaccess",         :limit => 1,  :default => 0,     :null => false
    t.text     "params",                                            :null => false
    t.integer  "lft",                            :default => 0,     :null => false
    t.integer  "rgt",                            :default => 0,     :null => false
    t.integer  "home",                           :default => 0,     :null => false
  end

  add_index "bak_menu", ["componentid", "menutype", "published", "access"], :name => "componentid"
  add_index "bak_menu", ["menutype"], :name => "menutype"

  create_table "bak_menu_types", :force => true do |t|
    t.string "menutype",    :limit => 75, :default => "", :null => false
    t.string "title",                     :default => "", :null => false
    t.string "description",               :default => "", :null => false
  end

  add_index "bak_menu_types", ["menutype"], :name => "menutype", :unique => true

  create_table "bak_messages", :primary_key => "message_id", :force => true do |t|
    t.integer  "user_id_from", :default => 0, :null => false
    t.integer  "user_id_to",   :default => 0, :null => false
    t.integer  "folder_id",    :default => 0, :null => false
    t.datetime "date_time",                   :null => false
    t.integer  "state",        :default => 0, :null => false
    t.integer  "priority",     :default => 0, :null => false
    t.text     "subject",                     :null => false
    t.text     "message",                     :null => false
  end

  add_index "bak_messages", ["user_id_to", "state"], :name => "useridto_state"

  create_table "bak_messages_cfg", :id => false, :force => true do |t|
    t.integer "user_id",                  :default => 0,  :null => false
    t.string  "cfg_name",  :limit => 100, :default => "", :null => false
    t.string  "cfg_value",                :default => "", :null => false
  end

  add_index "bak_messages_cfg", ["user_id", "cfg_name"], :name => "idx_user_var_name", :unique => true

  create_table "bak_migration_backlinks", :primary_key => "itemid", :force => true do |t|
    t.string "name",   :limit => 100, :null => false
    t.text   "url",                   :null => false
    t.text   "sefurl",                :null => false
    t.text   "newurl",                :null => false
  end

  create_table "bak_modules", :force => true do |t|
    t.text     "title",                                             :null => false
    t.text     "content",                                           :null => false
    t.integer  "ordering",                       :default => 0,     :null => false
    t.string   "position",         :limit => 50
    t.integer  "checked_out",                    :default => 0,     :null => false
    t.datetime "checked_out_time",                                  :null => false
    t.boolean  "published",                      :default => false, :null => false
    t.string   "module",           :limit => 50
    t.integer  "numnews",                        :default => 0,     :null => false
    t.integer  "access",           :limit => 1,  :default => 0,     :null => false
    t.integer  "showtitle",        :limit => 1,  :default => 1,     :null => false
    t.text     "params",                                            :null => false
    t.integer  "iscore",           :limit => 1,  :default => 0,     :null => false
    t.integer  "client_id",        :limit => 1,  :default => 0,     :null => false
    t.text     "control",                                           :null => false
  end

  add_index "bak_modules", ["module", "published"], :name => "newsfeeds"
  add_index "bak_modules", ["published", "access"], :name => "published"

  create_table "bak_modules_menu", :id => false, :force => true do |t|
    t.integer "moduleid", :default => 0, :null => false
    t.integer "menuid",   :default => 0, :null => false
  end

  create_table "bak_newsfeeds", :force => true do |t|
    t.integer  "catid",                           :default => 0,     :null => false
    t.text     "name",                                               :null => false
    t.string   "alias",                           :default => "",    :null => false
    t.text     "link",                                               :null => false
    t.string   "filename",         :limit => 200
    t.boolean  "published",                       :default => false, :null => false
    t.integer  "numarticles",                     :default => 1,     :null => false
    t.integer  "cache_time",                      :default => 3600,  :null => false
    t.integer  "checked_out",      :limit => 1,   :default => 0,     :null => false
    t.datetime "checked_out_time",                                   :null => false
    t.integer  "ordering",                        :default => 0,     :null => false
    t.integer  "rtl",              :limit => 1,   :default => 0,     :null => false
  end

  add_index "bak_newsfeeds", ["catid"], :name => "catid"
  add_index "bak_newsfeeds", ["published"], :name => "published"

  create_table "bak_plugins", :force => true do |t|
    t.string   "name",             :limit => 100, :default => "", :null => false
    t.string   "element",          :limit => 100, :default => "", :null => false
    t.string   "folder",           :limit => 100, :default => "", :null => false
    t.integer  "access",           :limit => 1,   :default => 0,  :null => false
    t.integer  "ordering",                        :default => 0,  :null => false
    t.integer  "published",        :limit => 1,   :default => 0,  :null => false
    t.integer  "iscore",           :limit => 1,   :default => 0,  :null => false
    t.integer  "client_id",        :limit => 1,   :default => 0,  :null => false
    t.integer  "checked_out",                     :default => 0,  :null => false
    t.datetime "checked_out_time",                                :null => false
    t.text     "params",                                          :null => false
  end

  add_index "bak_plugins", ["published", "client_id", "access", "folder"], :name => "idx_folder"

  create_table "bak_poll_data", :force => true do |t|
    t.integer "pollid", :default => 0, :null => false
    t.text    "text",                  :null => false
    t.integer "hits",   :default => 0, :null => false
  end

  add_index "bak_poll_data", ["pollid", "text"], :name => "pollid"

  create_table "bak_poll_date", :force => true do |t|
    t.datetime "date",                   :null => false
    t.integer  "vote_id", :default => 0, :null => false
    t.integer  "poll_id", :default => 0, :null => false
  end

  add_index "bak_poll_date", ["poll_id"], :name => "poll_id"

  create_table "bak_poll_menu", :id => false, :force => true do |t|
    t.integer "pollid", :default => 0, :null => false
    t.integer "menuid", :default => 0, :null => false
  end

  create_table "bak_polls", :force => true do |t|
    t.string   "title",            :default => "",    :null => false
    t.string   "alias",            :default => "",    :null => false
    t.integer  "voters",           :default => 0,     :null => false
    t.integer  "checked_out",      :default => 0,     :null => false
    t.datetime "checked_out_time",                    :null => false
    t.boolean  "published",        :default => false, :null => false
    t.integer  "access",           :default => 0,     :null => false
    t.integer  "lag",              :default => 0,     :null => false
  end

  create_table "bak_sections", :force => true do |t|
    t.string   "title",                          :default => "",    :null => false
    t.string   "name",                           :default => "",    :null => false
    t.string   "alias",                          :default => "",    :null => false
    t.text     "image",                                             :null => false
    t.string   "scope",            :limit => 50, :default => "",    :null => false
    t.string   "image_position",   :limit => 30, :default => "",    :null => false
    t.text     "description",                                       :null => false
    t.boolean  "published",                      :default => false, :null => false
    t.integer  "checked_out",                    :default => 0,     :null => false
    t.datetime "checked_out_time",                                  :null => false
    t.integer  "ordering",                       :default => 0,     :null => false
    t.integer  "access",           :limit => 1,  :default => 0,     :null => false
    t.integer  "count",                          :default => 0,     :null => false
    t.text     "params",                                            :null => false
  end

  add_index "bak_sections", ["scope"], :name => "idx_scope"

  create_table "bak_session", :primary_key => "session_id", :force => true do |t|
    t.string  "username",  :limit => 150,        :default => ""
    t.string  "time",      :limit => 14,         :default => ""
    t.integer "guest",     :limit => 1,          :default => 1
    t.integer "userid",                          :default => 0
    t.string  "usertype",  :limit => 50,         :default => ""
    t.integer "gid",       :limit => 1,          :default => 0,  :null => false
    t.integer "client_id", :limit => 1,          :default => 0,  :null => false
    t.text    "data",      :limit => 2147483647
  end

  add_index "bak_session", ["guest", "usertype"], :name => "whosonline"
  add_index "bak_session", ["time"], :name => "time"
  add_index "bak_session", ["userid"], :name => "userid"

  create_table "bak_stats_agents", :id => false, :force => true do |t|
    t.string  "agent", :default => "",    :null => false
    t.boolean "type",  :default => false, :null => false
    t.integer "hits",  :default => 1,     :null => false
  end

  create_table "bak_templates_menu", :id => false, :force => true do |t|
    t.string  "template",               :default => "", :null => false
    t.integer "menuid",                 :default => 0,  :null => false
    t.integer "client_id", :limit => 1, :default => 0,  :null => false
  end

  create_table "bak_users", :force => true do |t|
    t.string   "name",                         :default => "", :null => false
    t.string   "username",      :limit => 150, :default => "", :null => false
    t.string   "email",         :limit => 100, :default => "", :null => false
    t.string   "password",      :limit => 100, :default => "", :null => false
    t.string   "usertype",      :limit => 25,  :default => "", :null => false
    t.integer  "block",         :limit => 1,   :default => 0,  :null => false
    t.integer  "sendEmail",     :limit => 1,   :default => 0
    t.integer  "gid",           :limit => 1,   :default => 1,  :null => false
    t.datetime "registerDate",                                 :null => false
    t.datetime "lastvisitDate",                                :null => false
    t.string   "activation",    :limit => 100, :default => "", :null => false
    t.text     "params",                                       :null => false
  end

  add_index "bak_users", ["email"], :name => "email"
  add_index "bak_users", ["gid", "block"], :name => "gid_block"
  add_index "bak_users", ["name"], :name => "idx_name"
  add_index "bak_users", ["username"], :name => "username"
  add_index "bak_users", ["usertype"], :name => "usertype"

  create_table "bak_weblinks", :force => true do |t|
    t.integer  "catid",                           :default => 0,     :null => false
    t.integer  "sid",                             :default => 0,     :null => false
    t.string   "title",            :limit => 250, :default => "",    :null => false
    t.string   "alias",                           :default => "",    :null => false
    t.string   "url",              :limit => 250, :default => "",    :null => false
    t.text     "description",                                        :null => false
    t.datetime "date",                                               :null => false
    t.integer  "hits",                            :default => 0,     :null => false
    t.boolean  "published",                       :default => false, :null => false
    t.integer  "checked_out",                     :default => 0,     :null => false
    t.datetime "checked_out_time",                                   :null => false
    t.integer  "ordering",                        :default => 0,     :null => false
    t.boolean  "archived",                        :default => false, :null => false
    t.boolean  "approved",                        :default => true,  :null => false
    t.text     "params",                                             :null => false
  end

  add_index "bak_weblinks", ["catid", "published", "archived"], :name => "catid"

  create_table "challenge_activities", :force => true do |t|
    t.integer  "challenge_id",   :null => false
    t.integer  "activity_id",    :null => false
    t.string   "activity_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenge_activities", ["activity_id"], :name => "fk_challenge_actions_action_id"
  add_index "challenge_activities", ["challenge_id"], :name => "fk_challenge_actions_challenge_id"

  create_table "challenge_charities", :force => true do |t|
    t.integer  "challenge_id", :null => false
    t.integer  "charity_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenge_sponsors", :force => true do |t|
    t.integer  "challenge_id", :null => false
    t.integer  "sponsor_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenge_tags", :force => true do |t|
    t.integer  "challenge_id", :null => false
    t.integer  "tag_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenge_tags", ["challenge_id"], :name => "fk_challenge_tags_challenge_id"
  add_index "challenge_tags", ["tag_id"], :name => "fk_challenge_tags_tag_id"

  create_table "challenge_types", :force => true do |t|
    t.string   "name",        :limit => 50, :null => false
    t.string   "description",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenge_users", :force => true do |t|
    t.integer  "challenge_id", :null => false
    t.integer  "user_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenge_users", ["challenge_id"], :name => "fk_challenge_users_challenge_id"

  create_table "challenges", :force => true do |t|
    t.string   "name",               :limit => 50,                                                    :null => false
    t.string   "description",                                                                         :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "challenge_img",      :limit => 512
    t.decimal  "total_offer",                       :precision => 10, :scale => 2
    t.decimal  "amount_raised",                     :precision => 10, :scale => 2
    t.string   "sponsor_blurb",      :limit => 512
    t.string   "charity_blurb",      :limit => 512
    t.boolean  "enabled",                                                          :default => false
    t.integer  "created_by_user_id",                                               :default => 1
    t.string   "seo_name"
    t.string   "img_thumb_url",      :limit => 256
  end

  add_index "challenges", ["created_by_user_id"], :name => "fk_challenges_created_by_user_id"

  create_table "charities", :force => true do |t|
    t.string   "email",              :limit => 100,                    :null => false
    t.boolean  "enabled",                           :default => false
    t.string   "name",               :limit => 50
    t.string   "address1",           :limit => 50
    t.string   "address2",           :limit => 50
    t.string   "city",               :limit => 100
    t.string   "state",              :limit => 2
    t.string   "province",           :limit => 50
    t.string   "postal_code",        :limit => 10
    t.string   "country",            :limit => 3
    t.string   "phone_number",       :limit => 15
    t.string   "image_url"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_user_id",                :default => 1
    t.string   "seo_name"
    t.string   "img_thumb_url",      :limit => 256
  end

  add_index "charities", ["created_by_user_id"], :name => "fk_charities_created_by_user_id"

  create_table "charity_question_answers", :force => true do |t|
    t.integer  "charity_id",                 :null => false
    t.integer  "charity_question_id",        :null => false
    t.integer  "charity_question_choice_id"
    t.string   "text_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "charity_question_answers", ["charity_id"], :name => "fk_charity_question_answers_charity_id"
  add_index "charity_question_answers", ["charity_question_choice_id"], :name => "fk_charity_question_answers_charity_question_choice_id"
  add_index "charity_question_answers", ["charity_question_id"], :name => "fk_charity_question_answers_charity_question_id"

  create_table "charity_question_choices", :force => true do |t|
    t.integer "charity_question_id", :null => false
    t.string  "choice",              :null => false
    t.integer "sort_order"
  end

  add_index "charity_question_choices", ["charity_question_id"], :name => "fk_charity_question_choices_charity_question_id"

  create_table "charity_questions", :force => true do |t|
    t.string  "question",                                       :null => false
    t.string  "question_type", :limit => 10,                    :null => false
    t.boolean "active",                      :default => false
  end

  create_table "charity_tags", :force => true do |t|
    t.integer  "charity_id", :null => false
    t.integer  "tag_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "charity_tags", ["charity_id"], :name => "fk_charity_tags_charity_id"
  add_index "charity_tags", ["tag_id"], :name => "fk_charity_tags_tag_id"

  create_table "countries", :force => true do |t|
    t.string "iso",            :limit => 3,  :null => false
    t.string "name",           :limit => 80, :null => false
    t.string "printable_name", :limit => 80, :null => false
    t.string "iso3",           :limit => 3
    t.string "numcode",        :limit => 3
  end

  create_table "group_users", :force => true do |t|
    t.integer  "group_id",                         :null => false
    t.integer  "user_id",                          :null => false
    t.boolean  "administrator", :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_users", ["group_id"], :name => "fk_group_users_group_id"
  add_index "group_users", ["user_id", "group_id"], :name => "index_group_users_on_user_id_and_group_id", :unique => true

  create_table "groups", :force => true do |t|
    t.string   "name",            :limit => 100, :null => false
    t.integer  "creator_user_id",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["creator_user_id"], :name => "fk_groups_creator_user_id"

  create_table "jos_banner", :primary_key => "bid", :force => true do |t|
    t.integer  "cid",                             :default => 0,        :null => false
    t.string   "type",             :limit => 30,  :default => "banner", :null => false
    t.string   "name",                            :default => "",       :null => false
    t.string   "alias",                           :default => "",       :null => false
    t.integer  "imptotal",                        :default => 0,        :null => false
    t.integer  "impmade",                         :default => 0,        :null => false
    t.integer  "clicks",                          :default => 0,        :null => false
    t.string   "imageurl",         :limit => 100, :default => "",       :null => false
    t.string   "clickurl",         :limit => 200, :default => "",       :null => false
    t.datetime "date"
    t.boolean  "showBanner",                      :default => false,    :null => false
    t.boolean  "checked_out",                     :default => false,    :null => false
    t.datetime "checked_out_time",                                      :null => false
    t.string   "editor",           :limit => 50
    t.text     "custombannercode"
    t.integer  "catid",                           :default => 0,        :null => false
    t.text     "description",                                           :null => false
    t.boolean  "sticky",                          :default => false,    :null => false
    t.integer  "ordering",                        :default => 0,        :null => false
    t.datetime "publish_up",                                            :null => false
    t.datetime "publish_down",                                          :null => false
    t.text     "tags",                                                  :null => false
    t.text     "params",                                                :null => false
  end

  add_index "jos_banner", ["catid"], :name => "idx_banner_catid"
  add_index "jos_banner", ["showBanner"], :name => "viewbanner"

  create_table "jos_bannerclient", :primary_key => "cid", :force => true do |t|
    t.string  "name",                           :default => "",    :null => false
    t.string  "contact",                        :default => "",    :null => false
    t.string  "email",                          :default => "",    :null => false
    t.text    "extrainfo",                                         :null => false
    t.boolean "checked_out",                    :default => false, :null => false
    t.time    "checked_out_time"
    t.string  "editor",           :limit => 50
  end

  create_table "jos_bannertrack", :id => false, :force => true do |t|
    t.date    "track_date", :null => false
    t.integer "track_type", :null => false
    t.integer "banner_id",  :null => false
  end

  create_table "jos_categories", :force => true do |t|
    t.integer  "parent_id",                      :default => 0,     :null => false
    t.string   "title",                          :default => "",    :null => false
    t.string   "name",                           :default => "",    :null => false
    t.string   "alias",                          :default => "",    :null => false
    t.string   "image",                          :default => "",    :null => false
    t.string   "section",          :limit => 50, :default => "",    :null => false
    t.string   "image_position",   :limit => 30, :default => "",    :null => false
    t.text     "description",                                       :null => false
    t.boolean  "published",                      :default => false, :null => false
    t.integer  "checked_out",                    :default => 0,     :null => false
    t.datetime "checked_out_time",                                  :null => false
    t.string   "editor",           :limit => 50
    t.integer  "ordering",                       :default => 0,     :null => false
    t.integer  "access",           :limit => 1,  :default => 0,     :null => false
    t.integer  "count",                          :default => 0,     :null => false
    t.text     "params",                                            :null => false
  end

  add_index "jos_categories", ["access"], :name => "idx_access"
  add_index "jos_categories", ["checked_out"], :name => "idx_checkout"
  add_index "jos_categories", ["section", "published", "access"], :name => "cat_idx"

  create_table "jos_community_activities", :force => true do |t|
    t.integer  "actor",                                  :null => false
    t.integer  "target",                                 :null => false
    t.text     "title"
    t.text     "content",                                :null => false
    t.string   "app",      :limit => 200,                :null => false
    t.integer  "cid",                                    :null => false
    t.datetime "created",                                :null => false
    t.integer  "access",   :limit => 1,                  :null => false
    t.text     "params",                                 :null => false
    t.integer  "points",                  :default => 1, :null => false
    t.integer  "archived", :limit => 1,                  :null => false
  end

  add_index "jos_community_activities", ["actor"], :name => "actor"
  add_index "jos_community_activities", ["app"], :name => "app"
  add_index "jos_community_activities", ["archived"], :name => "archived"
  add_index "jos_community_activities", ["created"], :name => "created"
  add_index "jos_community_activities", ["target"], :name => "target"

  create_table "jos_community_activities_hide", :id => false, :force => true do |t|
    t.integer "activity_id", :null => false
    t.integer "user_id",     :null => false
  end

  add_index "jos_community_activities_hide", ["user_id"], :name => "user_id"

  create_table "jos_community_apps", :force => true do |t|
    t.integer "userid",                                         :null => false
    t.string  "apps",     :limit => 200,                        :null => false
    t.integer "ordering",                                       :null => false
    t.string  "position", :limit => 50,  :default => "content", :null => false
    t.text    "params",                                         :null => false
    t.string  "privacy",  :limit => 200,                        :null => false
  end

  add_index "jos_community_apps", ["userid", "apps"], :name => "idx_user_apps"
  add_index "jos_community_apps", ["userid"], :name => "idx_userid"

  create_table "jos_community_avatar", :id => false, :force => true do |t|
    t.integer "id",                   :null => false
    t.string  "apptype",              :null => false
    t.text    "path",                 :null => false
    t.integer "type",    :limit => 1, :null => false
  end

  add_index "jos_community_avatar", ["id", "apptype", "type"], :name => "id", :unique => true

  create_table "jos_community_blocklist", :force => true do |t|
    t.integer "userid",         :null => false
    t.integer "blocked_userid", :null => false
  end

  add_index "jos_community_blocklist", ["blocked_userid"], :name => "blocked_userid"
  add_index "jos_community_blocklist", ["userid"], :name => "userid"

  create_table "jos_community_config", :id => false, :force => true do |t|
    t.string "name",   :limit => 64,         :null => false
    t.text   "params", :limit => 2147483647, :null => false
  end

  create_table "jos_community_connect_users", :id => false, :force => true do |t|
    t.integer "connectid", :limit => 8, :null => false
    t.string  "type",                   :null => false
    t.integer "userid",                 :null => false
  end

  add_index "jos_community_connect_users", ["type"], :name => "type"

  create_table "jos_community_connection", :primary_key => "connection_id", :force => true do |t|
    t.integer  "connect_from",              :null => false
    t.integer  "connect_to",                :null => false
    t.integer  "status",       :limit => 1, :null => false
    t.integer  "group",                     :null => false
    t.text     "msg",                       :null => false
    t.datetime "created"
  end

  add_index "jos_community_connection", ["connect_from", "connect_to", "status", "group"], :name => "connect_from"
  add_index "jos_community_connection", ["connect_from"], :name => "idx_connect_from"
  add_index "jos_community_connection", ["connect_to", "connect_from"], :name => "idx_connect_tofrom"
  add_index "jos_community_connection", ["connect_to"], :name => "idx_connect_to"

  create_table "jos_community_events", :force => true do |t|
    t.integer  "catid",                                              :null => false
    t.integer  "contentid",                   :default => 0
    t.string   "type",                        :default => "profile", :null => false
    t.string   "title",                                              :null => false
    t.text     "location",                                           :null => false
    t.text     "description"
    t.integer  "creator",                                            :null => false
    t.datetime "startdate",                                          :null => false
    t.datetime "enddate",                                            :null => false
    t.integer  "permission",     :limit => 1, :default => 0,         :null => false
    t.string   "avatar"
    t.string   "thumb"
    t.integer  "invitedcount",                :default => 0
    t.integer  "confirmedcount",              :default => 0
    t.integer  "declinedcount",               :default => 0
    t.integer  "maybecount",                  :default => 0
    t.integer  "wallcount",                   :default => 0
    t.integer  "ticket",                      :default => 0
    t.boolean  "allowinvite",                 :default => true
    t.datetime "created"
    t.integer  "hits",                        :default => 0
    t.integer  "published",                   :default => 1
    t.float    "latitude",                    :default => 255.0,     :null => false
    t.float    "longitude",                   :default => 255.0,     :null => false
    t.string   "offset",         :limit => 5
  end

  add_index "jos_community_events", ["creator"], :name => "idx_creator"
  add_index "jos_community_events", ["startdate", "enddate"], :name => "idx_period"
  add_index "jos_community_events", ["type"], :name => "idx_type"

  create_table "jos_community_events_category", :force => true do |t|
    t.integer "parent",      :default => 0, :null => false
    t.string  "name",                       :null => false
    t.text    "description",                :null => false
  end

  create_table "jos_community_events_location", :force => true do |t|
    t.integer "eventid",               :null => false
    t.text    "street"
    t.string  "zipcode", :limit => 15
    t.string  "city"
    t.string  "state"
    t.string  "country"
  end

  add_index "jos_community_events_location", ["eventid"], :name => "idx_eventid"

  create_table "jos_community_events_members", :force => true do |t|
    t.integer  "eventid",                       :null => false
    t.integer  "memberid",                      :null => false
    t.boolean  "status",     :default => false, :null => false
    t.boolean  "permission", :default => false, :null => false
    t.integer  "invited_by", :default => 0
    t.boolean  "approval",   :default => false
    t.datetime "created"
  end

  add_index "jos_community_events_members", ["eventid", "memberid"], :name => "idx_member_event"
  add_index "jos_community_events_members", ["eventid", "permission"], :name => "idx_permission"
  add_index "jos_community_events_members", ["eventid"], :name => "idx_eventid"
  add_index "jos_community_events_members", ["invited_by"], :name => "idx_invitedby"
  add_index "jos_community_events_members", ["status"], :name => "idx_status"

  create_table "jos_community_featured", :force => true do |t|
    t.integer  "cid",        :null => false
    t.integer  "created_by", :null => false
    t.string   "type",       :null => false
    t.datetime "created",    :null => false
  end

  add_index "jos_community_featured", ["type"], :name => "type"

  create_table "jos_community_fields", :force => true do |t|
    t.string  "type",                            :null => false
    t.integer "ordering",     :default => 0
    t.boolean "published",    :default => false, :null => false
    t.integer "min",                             :null => false
    t.integer "max",                             :null => false
    t.string  "name",                            :null => false
    t.text    "tips",                            :null => false
    t.boolean "visible",      :default => false
    t.boolean "required",     :default => false
    t.boolean "searchable",   :default => true
    t.boolean "registration", :default => true
    t.text    "options"
    t.string  "fieldcode",                       :null => false
    t.text    "params",                          :null => false
  end

  add_index "jos_community_fields", ["fieldcode"], :name => "fieldcode"

  create_table "jos_community_fields_values", :force => true do |t|
    t.integer "user_id",  :null => false
    t.integer "field_id", :null => false
    t.text    "value",    :null => false
  end

  add_index "jos_community_fields_values", ["field_id"], :name => "field_id"
  add_index "jos_community_fields_values", ["user_id", "field_id"], :name => "idx_user_fieldid"
  add_index "jos_community_fields_values", ["user_id"], :name => "user_id"

  create_table "jos_community_files", :force => true do |t|
    t.integer  "creator",     :null => false
    t.text     "name",        :null => false
    t.text     "caption",     :null => false
    t.datetime "created",     :null => false
    t.boolean  "published",   :null => false
    t.string   "permissions", :null => false
    t.string   "thumbnail",   :null => false
    t.string   "source",      :null => false
    t.string   "type",        :null => false
  end

  create_table "jos_community_friendgroup", :id => false, :force => true do |t|
    t.integer "group_id", :null => false
    t.integer "user_id",  :null => false
  end

  create_table "jos_community_friendlist", :primary_key => "group_id", :force => true do |t|
    t.string  "group_name", :limit => 45, :null => false
    t.integer "user_id",                  :null => false
  end

  create_table "jos_community_groups", :force => true do |t|
    t.boolean  "published",                   :null => false
    t.integer  "ownerid",                     :null => false
    t.integer  "categoryid",                  :null => false
    t.string   "name",                        :null => false
    t.text     "description",                 :null => false
    t.string   "email",                       :null => false
    t.string   "website",                     :null => false
    t.boolean  "approvals",                   :null => false
    t.datetime "created",                     :null => false
    t.text     "avatar",                      :null => false
    t.text     "thumb",                       :null => false
    t.integer  "discusscount", :default => 0, :null => false
    t.integer  "wallcount",    :default => 0, :null => false
    t.integer  "membercount",  :default => 0, :null => false
    t.text     "params",                      :null => false
  end

  create_table "jos_community_groups_bulletins", :force => true do |t|
    t.integer  "groupid",    :null => false
    t.integer  "created_by", :null => false
    t.boolean  "published",  :null => false
    t.string   "title",      :null => false
    t.text     "message",    :null => false
    t.datetime "date",       :null => false
  end

  add_index "jos_community_groups_bulletins", ["groupid"], :name => "groupid"

  create_table "jos_community_groups_category", :force => true do |t|
    t.integer "parent",      :default => 0, :null => false
    t.string  "name",                       :null => false
    t.text    "description",                :null => false
  end

  create_table "jos_community_groups_discuss", :force => true do |t|
    t.integer  "parentid",    :default => 0,     :null => false
    t.integer  "groupid",                        :null => false
    t.integer  "creator",                        :null => false
    t.datetime "created",                        :null => false
    t.text     "title",                          :null => false
    t.text     "message",                        :null => false
    t.datetime "lastreplied",                    :null => false
    t.boolean  "lock",        :default => false
  end

  add_index "jos_community_groups_discuss", ["groupid"], :name => "groupid"
  add_index "jos_community_groups_discuss", ["parentid"], :name => "parentid"

  create_table "jos_community_groups_invite", :id => false, :force => true do |t|
    t.integer "groupid", :null => false
    t.integer "userid",  :null => false
    t.integer "creator", :null => false
  end

  create_table "jos_community_groups_members", :id => false, :force => true do |t|
    t.integer "groupid",     :null => false
    t.integer "memberid",    :null => false
    t.integer "approved",    :null => false
    t.integer "permissions", :null => false
  end

  add_index "jos_community_groups_members", ["groupid"], :name => "groupid"
  add_index "jos_community_groups_members", ["memberid"], :name => "idx_memberid"

  create_table "jos_community_invitations", :force => true do |t|
    t.string  "callback", :null => false
    t.integer "cid",      :null => false
    t.text    "users",    :null => false
  end

  create_table "jos_community_likes", :force => true do |t|
    t.string "element", :null => false
    t.string "uid",     :null => false
    t.text   "like",    :null => false
    t.text   "dislike", :null => false
  end

  create_table "jos_community_location_cache", :id => false, :force => true do |t|
    t.string   "address",                                   :null => false
    t.float    "latitude",               :default => 255.0, :null => false
    t.float    "longitude",              :default => 255.0, :null => false
    t.text     "data",                                      :null => false
    t.string   "status",    :limit => 2,                    :null => false
    t.datetime "created",                                   :null => false
  end

  create_table "jos_community_mailq", :force => true do |t|
    t.text     "recipient",               :null => false
    t.text     "subject",                 :null => false
    t.text     "body",                    :null => false
    t.integer  "status",    :limit => 1,  :null => false
    t.datetime "created",                 :null => false
    t.string   "template",  :limit => 64, :null => false
    t.text     "params",                  :null => false
  end

  add_index "jos_community_mailq", ["status"], :name => "status"

  create_table "jos_community_memberlist", :force => true do |t|
    t.text     "title",       :null => false
    t.text     "description", :null => false
    t.string   "condition",   :null => false
    t.integer  "avataronly",  :null => false
    t.datetime "created",     :null => false
  end

  create_table "jos_community_memberlist_criteria", :force => true do |t|
    t.integer "listid",    :null => false
    t.string  "field",     :null => false
    t.string  "condition", :null => false
    t.string  "value",     :null => false
    t.string  "type",      :null => false
  end

  add_index "jos_community_memberlist_criteria", ["listid"], :name => "listid"

  create_table "jos_community_msg", :force => true do |t|
    t.integer  "from",                                    :null => false
    t.integer  "parent",                                  :null => false
    t.integer  "deleted",   :limit => 1,   :default => 0
    t.string   "from_name", :limit => 45,                 :null => false
    t.datetime "posted_on"
    t.text     "subject",   :limit => 255,                :null => false
    t.text     "body",                                    :null => false
  end

  create_table "jos_community_msg_recepient", :id => false, :force => true do |t|
    t.integer "msg_id",                                 :null => false
    t.integer "msg_parent",              :default => 0, :null => false
    t.integer "msg_from",                               :null => false
    t.integer "to",                                     :null => false
    t.integer "bcc",        :limit => 1, :default => 0
    t.integer "is_read",    :limit => 1, :default => 0
    t.integer "deleted",    :limit => 1, :default => 0
  end

  add_index "jos_community_msg_recepient", ["is_read", "to", "deleted"], :name => "idx_isread_to_deleted"
  add_index "jos_community_msg_recepient", ["msg_id", "to"], :name => "un", :unique => true
  add_index "jos_community_msg_recepient", ["msg_id"], :name => "msg_id"
  add_index "jos_community_msg_recepient", ["to"], :name => "to"

  create_table "jos_community_oauth", :primary_key => "userid", :force => true do |t|
    t.text   "requesttoken", :null => false
    t.text   "accesstoken",  :null => false
    t.string "app",          :null => false
  end

  create_table "jos_community_photos", :force => true do |t|
    t.integer  "albumid",                                       :null => false
    t.text     "caption",                                       :null => false
    t.boolean  "published",                                     :null => false
    t.integer  "creator",                                       :null => false
    t.string   "permissions",                                   :null => false
    t.string   "image",                                         :null => false
    t.string   "thumbnail",                                     :null => false
    t.string   "original",                                      :null => false
    t.integer  "filesize",                  :default => 0,      :null => false
    t.string   "storage",     :limit => 64, :default => "file", :null => false
    t.datetime "created",                                       :null => false
    t.integer  "ordering",                  :default => 0,      :null => false
    t.integer  "hits",                      :default => 0,      :null => false
  end

  add_index "jos_community_photos", ["albumid"], :name => "albumid"
  add_index "jos_community_photos", ["storage"], :name => "idx_storage"

  create_table "jos_community_photos_albums", :force => true do |t|
    t.integer  "photoid",                    :null => false
    t.integer  "creator",                    :null => false
    t.string   "name",                       :null => false
    t.text     "description",                :null => false
    t.string   "permissions",                :null => false
    t.datetime "created",                    :null => false
    t.string   "path",                       :null => false
    t.string   "type",                       :null => false
    t.integer  "groupid",     :default => 0, :null => false
    t.integer  "hits",        :default => 0, :null => false
  end

  add_index "jos_community_photos_albums", ["creator", "type"], :name => "idx_creatortype"
  add_index "jos_community_photos_albums", ["creator"], :name => "creator"
  add_index "jos_community_photos_albums", ["groupid"], :name => "idx_groupid"
  add_index "jos_community_photos_albums", ["id", "type"], :name => "idx_albumtype"
  add_index "jos_community_photos_albums", ["type"], :name => "idx_type"

  create_table "jos_community_photos_tag", :force => true do |t|
    t.integer  "photoid",                  :null => false
    t.integer  "userid",                   :null => false
    t.string   "position",   :limit => 50, :null => false
    t.integer  "created_by",               :null => false
    t.datetime "created",                  :null => false
  end

  add_index "jos_community_photos_tag", ["created_by"], :name => "idx_created_by"
  add_index "jos_community_photos_tag", ["photoid", "userid"], :name => "idx_photo_user"
  add_index "jos_community_photos_tag", ["photoid"], :name => "idx_photoid"
  add_index "jos_community_photos_tag", ["userid"], :name => "idx_userid"

  create_table "jos_community_photos_tokens", :id => false, :force => true do |t|
    t.integer  "userid",                  :null => false
    t.string   "token",    :limit => 200, :null => false
    t.datetime "datetime",                :null => false
  end

  create_table "jos_community_profiles", :force => true do |t|
    t.string   "name",                                              :null => false
    t.text     "description",                                       :null => false
    t.integer  "approvals",          :limit => 1,                   :null => false
    t.integer  "published",          :limit => 1,                   :null => false
    t.text     "avatar",                                            :null => false
    t.text     "watermark",                                         :null => false
    t.string   "watermark_hash",                                    :null => false
    t.text     "watermark_location",                                :null => false
    t.text     "thumb",                                             :null => false
    t.datetime "created",                                           :null => false
    t.boolean  "create_groups",                   :default => true
  end

  add_index "jos_community_profiles", ["approvals", "published"], :name => "approvals"

  create_table "jos_community_profiles_fields", :force => true do |t|
    t.integer "parent",   :null => false
    t.integer "field_id", :null => false
  end

  add_index "jos_community_profiles_fields", ["field_id"], :name => "field_id"
  add_index "jos_community_profiles_fields", ["parent"], :name => "multiprofile_id"

  create_table "jos_community_register", :force => true do |t|
    t.string   "token",     :limit => 200, :null => false
    t.string   "name",                     :null => false
    t.string   "firstname", :limit => 180, :null => false
    t.string   "lastname",  :limit => 180, :null => false
    t.string   "username",  :limit => 150, :null => false
    t.string   "email",     :limit => 100, :null => false
    t.string   "password",  :limit => 100, :null => false
    t.datetime "created"
    t.string   "ip",        :limit => 25,  :null => false
  end

  create_table "jos_community_register_auth_token", :primary_key => "token", :force => true do |t|
    t.string   "ip",       :limit => 25,  :null => false
    t.string   "auth_key", :limit => 200, :null => false
    t.datetime "created",                 :null => false
  end

  add_index "jos_community_register_auth_token", ["ip"], :name => "ip"

  create_table "jos_community_reports", :force => true do |t|
    t.string   "uniquestring", :limit => 200, :null => false
    t.string   "link",                        :null => false
    t.integer  "status",                      :null => false
    t.datetime "created",                     :null => false
  end

  create_table "jos_community_reports_actions", :force => true do |t|
    t.integer "reportid",      :null => false
    t.string  "label",         :null => false
    t.string  "method",        :null => false
    t.string  "parameters",    :null => false
    t.boolean "defaultaction", :null => false
  end

  create_table "jos_community_reports_reporter", :id => false, :force => true do |t|
    t.integer  "reportid",   :null => false
    t.text     "message",    :null => false
    t.integer  "created_by", :null => false
    t.datetime "created",    :null => false
    t.string   "ip",         :null => false
  end

  create_table "jos_community_storage_s3", :primary_key => "storageid", :force => true do |t|
    t.string "resource_path", :null => false
  end

  add_index "jos_community_storage_s3", ["storageid"], :name => "storageid", :unique => true

  create_table "jos_community_userpoints", :force => true do |t|
    t.string  "rule_name",        :default => "",    :null => false
    t.text    "rule_description",                    :null => false
    t.string  "rule_plugin",      :default => "",    :null => false
    t.string  "action_string",    :default => "",    :null => false
    t.string  "component",        :default => "",    :null => false
    t.boolean "access",           :default => true,  :null => false
    t.integer "points",           :default => 0,     :null => false
    t.boolean "published",        :default => false, :null => false
    t.boolean "system",           :default => false, :null => false
  end

  create_table "jos_community_userpref", :id => false, :force => true do |t|
    t.integer "id",     :null => false
    t.text    "params", :null => false
  end

  create_table "jos_community_users", :primary_key => "userid", :force => true do |t|
    t.text     "status",                                           :null => false
    t.integer  "points",                                           :null => false
    t.datetime "posted_on",                                        :null => false
    t.text     "avatar",                                           :null => false
    t.text     "thumb",                                            :null => false
    t.integer  "invite",                       :default => 0,      :null => false
    t.text     "params",                                           :null => false
    t.integer  "view",                         :default => 0,      :null => false
    t.integer  "friendcount",                  :default => 0,      :null => false
    t.string   "alias",                                            :null => false
    t.float    "latitude",                     :default => 255.0,  :null => false
    t.float    "longitude",                    :default => 255.0,  :null => false
    t.integer  "profile_id",                   :default => 0,      :null => false
    t.string   "watermark_hash",                                   :null => false
    t.string   "storage",        :limit => 64, :default => "file", :null => false
  end

  create_table "jos_community_videos", :force => true do |t|
    t.string   "title",        :limit => 200,                        :null => false
    t.string   "type",         :limit => 200, :default => "file",    :null => false
    t.string   "video_id",     :limit => 200
    t.text     "description",                                        :null => false
    t.integer  "creator",                                            :null => false
    t.string   "creator_type", :limit => 200, :default => "user",    :null => false
    t.datetime "created",                                            :null => false
    t.string   "permissions",                 :default => "0",       :null => false
    t.integer  "category_id",                                        :null => false
    t.integer  "hits",                        :default => 0,         :null => false
    t.integer  "published",    :limit => 1,   :default => 1,         :null => false
    t.integer  "featured",     :limit => 1,   :default => 0,         :null => false
    t.float    "duration",                    :default => 0.0
    t.string   "status",       :limit => 200, :default => "pending", :null => false
    t.string   "thumb"
    t.string   "path"
    t.integer  "groupid",                     :default => 0,         :null => false
    t.integer  "filesize",                    :default => 0,         :null => false
    t.string   "storage",      :limit => 64,  :default => "file",    :null => false
  end

  add_index "jos_community_videos", ["creator"], :name => "creator"
  add_index "jos_community_videos", ["groupid"], :name => "idx_groupid"
  add_index "jos_community_videos", ["storage"], :name => "idx_storage"

  create_table "jos_community_videos_category", :force => true do |t|
    t.string  "name",                                    :null => false
    t.text    "description",                             :null => false
    t.integer "published",   :limit => 1, :default => 1, :null => false
  end

  create_table "jos_community_wall", :force => true do |t|
    t.integer "contentid",                :default => 0, :null => false
    t.integer "post_by",                  :default => 0, :null => false
    t.string  "ip",        :limit => 45,                 :null => false
    t.text    "comment",                                 :null => false
    t.string  "date",      :limit => 45,                 :null => false
    t.boolean "published",                               :null => false
    t.string  "type",      :limit => 200,                :null => false
  end

  add_index "jos_community_wall", ["contentid"], :name => "contentid"
  add_index "jos_community_wall", ["type"], :name => "type"

  create_table "jos_components", :force => true do |t|
    t.string  "name",            :limit => 50, :default => "", :null => false
    t.string  "link",                          :default => "", :null => false
    t.integer "menuid",                        :default => 0,  :null => false
    t.integer "parent",                        :default => 0,  :null => false
    t.string  "admin_menu_link",               :default => "", :null => false
    t.string  "admin_menu_alt",                :default => "", :null => false
    t.string  "option",          :limit => 50, :default => "", :null => false
    t.integer "ordering",                      :default => 0,  :null => false
    t.string  "admin_menu_img",                :default => "", :null => false
    t.integer "iscore",          :limit => 1,  :default => 0,  :null => false
    t.text    "params",                                        :null => false
    t.integer "enabled",         :limit => 1,  :default => 1,  :null => false
  end

  add_index "jos_components", ["parent", "option"], :name => "parent_option"

  create_table "jos_contact_details", :force => true do |t|
    t.string   "name",                                 :default => "",    :null => false
    t.string   "alias",                                :default => "",    :null => false
    t.string   "con_position"
    t.text     "address"
    t.string   "suburb",           :limit => 100
    t.string   "state",            :limit => 100
    t.string   "country",          :limit => 100
    t.string   "postcode",         :limit => 100
    t.string   "telephone"
    t.string   "fax"
    t.text     "misc",             :limit => 16777215
    t.string   "image"
    t.string   "imagepos",         :limit => 20
    t.string   "email_to"
    t.boolean  "default_con",                          :default => false, :null => false
    t.boolean  "published",                            :default => false, :null => false
    t.integer  "checked_out",                          :default => 0,     :null => false
    t.datetime "checked_out_time",                                        :null => false
    t.integer  "ordering",                             :default => 0,     :null => false
    t.text     "params",                                                  :null => false
    t.integer  "user_id",                              :default => 0,     :null => false
    t.integer  "catid",                                :default => 0,     :null => false
    t.integer  "access",           :limit => 1,        :default => 0,     :null => false
    t.string   "mobile",                               :default => "",    :null => false
    t.string   "webpage",                              :default => "",    :null => false
  end

  add_index "jos_contact_details", ["catid"], :name => "catid"

  create_table "jos_content", :force => true do |t|
    t.string   "title",                                :default => "", :null => false
    t.string   "alias",                                :default => "", :null => false
    t.string   "title_alias",                          :default => "", :null => false
    t.text     "introtext",        :limit => 16777215,                 :null => false
    t.text     "fulltext",         :limit => 16777215,                 :null => false
    t.integer  "state",            :limit => 1,        :default => 0,  :null => false
    t.integer  "sectionid",                            :default => 0,  :null => false
    t.integer  "mask",                                 :default => 0,  :null => false
    t.integer  "catid",                                :default => 0,  :null => false
    t.datetime "created",                                              :null => false
    t.integer  "created_by",                           :default => 0,  :null => false
    t.string   "created_by_alias",                     :default => "", :null => false
    t.datetime "modified",                                             :null => false
    t.integer  "modified_by",                          :default => 0,  :null => false
    t.integer  "checked_out",                          :default => 0,  :null => false
    t.datetime "checked_out_time",                                     :null => false
    t.datetime "publish_up",                                           :null => false
    t.datetime "publish_down",                                         :null => false
    t.text     "images",                                               :null => false
    t.text     "urls",                                                 :null => false
    t.text     "attribs",                                              :null => false
    t.integer  "version",                              :default => 1,  :null => false
    t.integer  "parentid",                             :default => 0,  :null => false
    t.integer  "ordering",                             :default => 0,  :null => false
    t.text     "metakey",                                              :null => false
    t.text     "metadesc",                                             :null => false
    t.integer  "access",                               :default => 0,  :null => false
    t.integer  "hits",                                 :default => 0,  :null => false
    t.text     "metadata",                                             :null => false
  end

  add_index "jos_content", ["access"], :name => "idx_access"
  add_index "jos_content", ["catid"], :name => "idx_catid"
  add_index "jos_content", ["checked_out"], :name => "idx_checkout"
  add_index "jos_content", ["created_by"], :name => "idx_createdby"
  add_index "jos_content", ["sectionid"], :name => "idx_section"
  add_index "jos_content", ["state"], :name => "idx_state"

  create_table "jos_content_frontpage", :primary_key => "content_id", :force => true do |t|
    t.integer "ordering", :default => 0, :null => false
  end

  create_table "jos_content_rating", :primary_key => "content_id", :force => true do |t|
    t.integer "rating_sum",                 :default => 0,  :null => false
    t.integer "rating_count",               :default => 0,  :null => false
    t.string  "lastip",       :limit => 50, :default => "", :null => false
  end

  create_table "jos_core_acl_aro", :force => true do |t|
    t.string  "section_value", :limit => 240, :default => "0", :null => false
    t.string  "value",         :limit => 240, :default => "",  :null => false
    t.integer "order_value",                  :default => 0,   :null => false
    t.string  "name",                         :default => "",  :null => false
    t.integer "hidden",                       :default => 0,   :null => false
  end

  add_index "jos_core_acl_aro", ["hidden"], :name => "jos_gacl_hidden_aro"
  add_index "jos_core_acl_aro", ["section_value", "value"], :name => "jos_section_value_value_aro", :unique => true

  create_table "jos_core_acl_aro_groups", :force => true do |t|
    t.integer "parent_id", :default => 0,  :null => false
    t.string  "name",      :default => "", :null => false
    t.integer "lft",       :default => 0,  :null => false
    t.integer "rgt",       :default => 0,  :null => false
    t.string  "value",     :default => "", :null => false
  end

  add_index "jos_core_acl_aro_groups", ["lft", "rgt"], :name => "jos_gacl_lft_rgt_aro_groups"
  add_index "jos_core_acl_aro_groups", ["parent_id"], :name => "jos_gacl_parent_id_aro_groups"

  create_table "jos_core_acl_aro_map", :id => false, :force => true do |t|
    t.integer "acl_id",                       :default => 0,   :null => false
    t.string  "section_value", :limit => 230, :default => "0", :null => false
    t.string  "value",         :limit => 100,                  :null => false
  end

  create_table "jos_core_acl_aro_sections", :force => true do |t|
    t.string  "value",       :limit => 230, :default => "", :null => false
    t.integer "order_value",                :default => 0,  :null => false
    t.string  "name",        :limit => 230, :default => "", :null => false
    t.integer "hidden",                     :default => 0,  :null => false
  end

  add_index "jos_core_acl_aro_sections", ["hidden"], :name => "jos_gacl_hidden_aro_sections"
  add_index "jos_core_acl_aro_sections", ["value"], :name => "jos_gacl_value_aro_sections", :unique => true

  create_table "jos_core_acl_groups_aro_map", :id => false, :force => true do |t|
    t.integer "group_id",                     :default => 0,  :null => false
    t.string  "section_value", :limit => 240, :default => "", :null => false
    t.integer "aro_id",                       :default => 0,  :null => false
  end

  add_index "jos_core_acl_groups_aro_map", ["group_id", "section_value", "aro_id"], :name => "group_id_aro_id_groups_aro_map", :unique => true

  create_table "jos_core_log_items", :id => false, :force => true do |t|
    t.date    "time_stamp",                               :null => false
    t.string  "item_table", :limit => 50, :default => "", :null => false
    t.integer "item_id",                  :default => 0,  :null => false
    t.integer "hits",                     :default => 0,  :null => false
  end

  create_table "jos_core_log_searches", :id => false, :force => true do |t|
    t.string  "search_term", :limit => 128, :default => "", :null => false
    t.integer "hits",                       :default => 0,  :null => false
  end

  create_table "jos_groups", :force => true do |t|
    t.string "name", :limit => 50, :default => "", :null => false
  end

  create_table "jos_menu", :force => true do |t|
    t.string   "menutype",         :limit => 75
    t.string   "name"
    t.string   "alias",                          :default => "",    :null => false
    t.text     "link"
    t.string   "type",             :limit => 50, :default => "",    :null => false
    t.boolean  "published",                      :default => false, :null => false
    t.integer  "parent",                         :default => 0,     :null => false
    t.integer  "componentid",                    :default => 0,     :null => false
    t.integer  "sublevel",                       :default => 0
    t.integer  "ordering",                       :default => 0
    t.integer  "checked_out",                    :default => 0,     :null => false
    t.datetime "checked_out_time",                                  :null => false
    t.integer  "pollid",                         :default => 0,     :null => false
    t.integer  "browserNav",       :limit => 1,  :default => 0
    t.integer  "access",           :limit => 1,  :default => 0,     :null => false
    t.integer  "utaccess",         :limit => 1,  :default => 0,     :null => false
    t.text     "params",                                            :null => false
    t.integer  "lft",                            :default => 0,     :null => false
    t.integer  "rgt",                            :default => 0,     :null => false
    t.integer  "home",                           :default => 0,     :null => false
  end

  add_index "jos_menu", ["componentid", "menutype", "published", "access"], :name => "componentid"
  add_index "jos_menu", ["menutype"], :name => "menutype"

  create_table "jos_menu_types", :force => true do |t|
    t.string "menutype",    :limit => 75, :default => "", :null => false
    t.string "title",                     :default => "", :null => false
    t.string "description",               :default => "", :null => false
  end

  add_index "jos_menu_types", ["menutype"], :name => "menutype", :unique => true

  create_table "jos_messages", :primary_key => "message_id", :force => true do |t|
    t.integer  "user_id_from", :default => 0, :null => false
    t.integer  "user_id_to",   :default => 0, :null => false
    t.integer  "folder_id",    :default => 0, :null => false
    t.datetime "date_time",                   :null => false
    t.integer  "state",        :default => 0, :null => false
    t.integer  "priority",     :default => 0, :null => false
    t.text     "subject",                     :null => false
    t.text     "message",                     :null => false
  end

  add_index "jos_messages", ["user_id_to", "state"], :name => "useridto_state"

  create_table "jos_messages_cfg", :id => false, :force => true do |t|
    t.integer "user_id",                  :default => 0,  :null => false
    t.string  "cfg_name",  :limit => 100, :default => "", :null => false
    t.string  "cfg_value",                :default => "", :null => false
  end

  add_index "jos_messages_cfg", ["user_id", "cfg_name"], :name => "idx_user_var_name", :unique => true

  create_table "jos_migration_backlinks", :primary_key => "itemid", :force => true do |t|
    t.string "name",   :limit => 100, :null => false
    t.text   "url",                   :null => false
    t.text   "sefurl",                :null => false
    t.text   "newurl",                :null => false
  end

  create_table "jos_modules", :force => true do |t|
    t.text     "title",                                             :null => false
    t.text     "content",                                           :null => false
    t.integer  "ordering",                       :default => 0,     :null => false
    t.string   "position",         :limit => 50
    t.integer  "checked_out",                    :default => 0,     :null => false
    t.datetime "checked_out_time",                                  :null => false
    t.boolean  "published",                      :default => false, :null => false
    t.string   "module",           :limit => 50
    t.integer  "numnews",                        :default => 0,     :null => false
    t.integer  "access",           :limit => 1,  :default => 0,     :null => false
    t.integer  "showtitle",        :limit => 1,  :default => 1,     :null => false
    t.text     "params",                                            :null => false
    t.integer  "iscore",           :limit => 1,  :default => 0,     :null => false
    t.integer  "client_id",        :limit => 1,  :default => 0,     :null => false
    t.text     "control",                                           :null => false
  end

  add_index "jos_modules", ["module", "published"], :name => "newsfeeds"
  add_index "jos_modules", ["published", "access"], :name => "published"

  create_table "jos_modules_menu", :id => false, :force => true do |t|
    t.integer "moduleid", :default => 0, :null => false
    t.integer "menuid",   :default => 0, :null => false
  end

  create_table "jos_newsfeeds", :force => true do |t|
    t.integer  "catid",                           :default => 0,     :null => false
    t.text     "name",                                               :null => false
    t.string   "alias",                           :default => "",    :null => false
    t.text     "link",                                               :null => false
    t.string   "filename",         :limit => 200
    t.boolean  "published",                       :default => false, :null => false
    t.integer  "numarticles",                     :default => 1,     :null => false
    t.integer  "cache_time",                      :default => 3600,  :null => false
    t.integer  "checked_out",      :limit => 1,   :default => 0,     :null => false
    t.datetime "checked_out_time",                                   :null => false
    t.integer  "ordering",                        :default => 0,     :null => false
    t.integer  "rtl",              :limit => 1,   :default => 0,     :null => false
  end

  add_index "jos_newsfeeds", ["catid"], :name => "catid"
  add_index "jos_newsfeeds", ["published"], :name => "published"

  create_table "jos_plugins", :force => true do |t|
    t.string   "name",             :limit => 100, :default => "", :null => false
    t.string   "element",          :limit => 100, :default => "", :null => false
    t.string   "folder",           :limit => 100, :default => "", :null => false
    t.integer  "access",           :limit => 1,   :default => 0,  :null => false
    t.integer  "ordering",                        :default => 0,  :null => false
    t.integer  "published",        :limit => 1,   :default => 0,  :null => false
    t.integer  "iscore",           :limit => 1,   :default => 0,  :null => false
    t.integer  "client_id",        :limit => 1,   :default => 0,  :null => false
    t.integer  "checked_out",                     :default => 0,  :null => false
    t.datetime "checked_out_time",                                :null => false
    t.text     "params",                                          :null => false
  end

  add_index "jos_plugins", ["published", "client_id", "access", "folder"], :name => "idx_folder"

  create_table "jos_poll_data", :force => true do |t|
    t.integer "pollid", :default => 0, :null => false
    t.text    "text",                  :null => false
    t.integer "hits",   :default => 0, :null => false
  end

  add_index "jos_poll_data", ["pollid", "text"], :name => "pollid"

  create_table "jos_poll_date", :force => true do |t|
    t.datetime "date",                   :null => false
    t.integer  "vote_id", :default => 0, :null => false
    t.integer  "poll_id", :default => 0, :null => false
  end

  add_index "jos_poll_date", ["poll_id"], :name => "poll_id"

  create_table "jos_poll_menu", :id => false, :force => true do |t|
    t.integer "pollid", :default => 0, :null => false
    t.integer "menuid", :default => 0, :null => false
  end

  create_table "jos_polls", :force => true do |t|
    t.string   "title",            :default => "",    :null => false
    t.string   "alias",            :default => "",    :null => false
    t.integer  "voters",           :default => 0,     :null => false
    t.integer  "checked_out",      :default => 0,     :null => false
    t.datetime "checked_out_time",                    :null => false
    t.boolean  "published",        :default => false, :null => false
    t.integer  "access",           :default => 0,     :null => false
    t.integer  "lag",              :default => 0,     :null => false
  end

  create_table "jos_sections", :force => true do |t|
    t.string   "title",                          :default => "",    :null => false
    t.string   "name",                           :default => "",    :null => false
    t.string   "alias",                          :default => "",    :null => false
    t.text     "image",                                             :null => false
    t.string   "scope",            :limit => 50, :default => "",    :null => false
    t.string   "image_position",   :limit => 30, :default => "",    :null => false
    t.text     "description",                                       :null => false
    t.boolean  "published",                      :default => false, :null => false
    t.integer  "checked_out",                    :default => 0,     :null => false
    t.datetime "checked_out_time",                                  :null => false
    t.integer  "ordering",                       :default => 0,     :null => false
    t.integer  "access",           :limit => 1,  :default => 0,     :null => false
    t.integer  "count",                          :default => 0,     :null => false
    t.text     "params",                                            :null => false
  end

  add_index "jos_sections", ["scope"], :name => "idx_scope"

  create_table "jos_session", :primary_key => "session_id", :force => true do |t|
    t.string  "username",  :limit => 150,        :default => ""
    t.string  "time",      :limit => 14,         :default => ""
    t.integer "guest",     :limit => 1,          :default => 1
    t.integer "userid",                          :default => 0
    t.string  "usertype",  :limit => 50,         :default => ""
    t.integer "gid",       :limit => 1,          :default => 0,  :null => false
    t.integer "client_id", :limit => 1,          :default => 0,  :null => false
    t.text    "data",      :limit => 2147483647
  end

  add_index "jos_session", ["guest", "usertype"], :name => "whosonline"
  add_index "jos_session", ["time"], :name => "time"
  add_index "jos_session", ["userid"], :name => "userid"

  create_table "jos_stats_agents", :id => false, :force => true do |t|
    t.string  "agent", :default => "",    :null => false
    t.boolean "type",  :default => false, :null => false
    t.integer "hits",  :default => 1,     :null => false
  end

  create_table "jos_templates_menu", :id => false, :force => true do |t|
    t.string  "template",               :default => "", :null => false
    t.integer "menuid",                 :default => 0,  :null => false
    t.integer "client_id", :limit => 1, :default => 0,  :null => false
  end

  create_table "jos_users", :force => true do |t|
    t.string   "name",                         :default => "", :null => false
    t.string   "username",      :limit => 150, :default => "", :null => false
    t.string   "email",         :limit => 100, :default => "", :null => false
    t.string   "password",      :limit => 100, :default => "", :null => false
    t.string   "usertype",      :limit => 25,  :default => "", :null => false
    t.integer  "block",         :limit => 1,   :default => 0,  :null => false
    t.integer  "sendEmail",     :limit => 1,   :default => 0
    t.integer  "gid",           :limit => 1,   :default => 1,  :null => false
    t.datetime "registerDate",                                 :null => false
    t.datetime "lastvisitDate",                                :null => false
    t.string   "activation",    :limit => 100, :default => "", :null => false
    t.text     "params",                                       :null => false
  end

  add_index "jos_users", ["email"], :name => "email"
  add_index "jos_users", ["gid", "block"], :name => "gid_block"
  add_index "jos_users", ["name"], :name => "idx_name"
  add_index "jos_users", ["username"], :name => "username"
  add_index "jos_users", ["usertype"], :name => "usertype"

  create_table "jos_weblinks", :force => true do |t|
    t.integer  "catid",                           :default => 0,     :null => false
    t.integer  "sid",                             :default => 0,     :null => false
    t.string   "title",            :limit => 250, :default => "",    :null => false
    t.string   "alias",                           :default => "",    :null => false
    t.string   "url",              :limit => 250, :default => "",    :null => false
    t.text     "description",                                        :null => false
    t.datetime "date",                                               :null => false
    t.integer  "hits",                            :default => 0,     :null => false
    t.boolean  "published",                       :default => false, :null => false
    t.integer  "checked_out",                     :default => 0,     :null => false
    t.datetime "checked_out_time",                                   :null => false
    t.integer  "ordering",                        :default => 0,     :null => false
    t.boolean  "archived",                        :default => false, :null => false
    t.boolean  "approved",                        :default => true,  :null => false
    t.text     "params",                                             :null => false
  end

  add_index "jos_weblinks", ["catid", "published", "archived"], :name => "catid"

  create_table "newsletter_subscribers", :force => true do |t|
    t.string   "email",           :limit => 100, :null => false
    t.string   "first_name",      :limit => 50
    t.string   "last_name",       :limit => 50
    t.string   "address1",        :limit => 50
    t.string   "address2",        :limit => 50
    t.string   "city",            :limit => 100
    t.string   "state",           :limit => 2
    t.string   "province",        :limit => 50
    t.string   "postal_code",     :limit => 10
    t.string   "country",         :limit => 3
    t.string   "subscriber_type", :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name", :limit => 50, :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sponsor_question_answers", :force => true do |t|
    t.integer  "sponsor_id",                 :null => false
    t.integer  "sponsor_question_id",        :null => false
    t.integer  "sponsor_question_choice_id"
    t.string   "text_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsor_question_answers", ["sponsor_id"], :name => "fk_sponsor_question_answers_sponsor_id"
  add_index "sponsor_question_answers", ["sponsor_question_choice_id"], :name => "fk_sponsor_question_answers_sponsor_question_choice_id"
  add_index "sponsor_question_answers", ["sponsor_question_id"], :name => "fk_sponsor_question_answers_sponsor_question_id"

  create_table "sponsor_question_choices", :force => true do |t|
    t.integer "sponsor_question_id", :null => false
    t.string  "choice",              :null => false
    t.integer "sort_order"
  end

  add_index "sponsor_question_choices", ["sponsor_question_id"], :name => "fk_sponsor_question_choices_sponsor_question_id"

  create_table "sponsor_questions", :force => true do |t|
    t.string  "question",                                       :null => false
    t.string  "question_type", :limit => 10,                    :null => false
    t.boolean "active",                      :default => false
  end

  create_table "sponsor_tags", :force => true do |t|
    t.integer  "sponsor_id", :null => false
    t.integer  "tag_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsor_tags", ["sponsor_id"], :name => "fk_sponsor_tags_sponsor_id"
  add_index "sponsor_tags", ["tag_id"], :name => "fk_sponsor_tags_tag_id"

  create_table "sponsors", :force => true do |t|
    t.string   "email",              :limit => 100,                    :null => false
    t.boolean  "enabled",                           :default => false
    t.string   "name",               :limit => 50,                     :null => false
    t.string   "address1",           :limit => 50
    t.string   "address2",           :limit => 50
    t.string   "city",               :limit => 100
    t.string   "state",              :limit => 2
    t.string   "province",           :limit => 50
    t.string   "postal_code",        :limit => 10
    t.string   "country",            :limit => 3
    t.string   "phone_number",       :limit => 15
    t.string   "image_url"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_user_id",                :default => 1
    t.string   "seo_name"
    t.string   "img_thumb_url",      :limit => 256
  end

  add_index "sponsors", ["created_by_user_id"], :name => "fk_sponsors_created_by_user_id"

  create_table "states", :force => true do |t|
    t.string  "name",   :limit => 40, :null => false
    t.string  "abbrev", :limit => 2,  :null => false
    t.boolean "usual",                :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_activities", :force => true do |t|
    t.integer  "user_id",               :null => false
    t.integer  "challenge_activity_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "activity_data"
  end

  add_index "user_activities", ["challenge_activity_id"], :name => "fk_user_actions_challenge_action_id"
  add_index "user_activities", ["user_id"], :name => "fk_user_actions_user_id"

  create_table "user_activity_tracking", :force => true do |t|
    t.integer   "activity_id",                                :null => false
    t.integer   "user_id",                                    :null => false
    t.timestamp "tstamp",                                     :null => false
    t.text      "extra_info",                                 :null => false
    t.decimal   "amt",         :precision => 10, :scale => 2, :null => false
  end

  create_table "user_question_answers", :force => true do |t|
    t.integer  "user_id",                 :null => false
    t.integer  "user_question_id",        :null => false
    t.integer  "user_question_choice_id"
    t.string   "text_answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_question_answers", ["user_id"], :name => "fk_user_question_answers_user_id"
  add_index "user_question_answers", ["user_question_choice_id"], :name => "fk_user_question_answers_user_question_choice_id"
  add_index "user_question_answers", ["user_question_id"], :name => "fk_user_question_answers_user_question_id"

  create_table "user_question_choices", :force => true do |t|
    t.integer "user_question_id", :null => false
    t.string  "choice",           :null => false
    t.integer "sort_order"
  end

  add_index "user_question_choices", ["user_question_id"], :name => "fk_user_question_choices_user_question_id"

  create_table "user_questions", :force => true do |t|
    t.string  "question",                                       :null => false
    t.string  "question_type", :limit => 10,                    :null => false
    t.boolean "active",                      :default => false
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["role_id"], :name => "fk_user_roles_role_id"
  add_index "user_roles", ["user_id"], :name => "fk_user_roles_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",           :limit => 100,                    :null => false
    t.string   "password",        :limit => 50
    t.boolean  "enabled",                        :default => false
    t.string   "first_name",      :limit => 50
    t.string   "middle_name",     :limit => 50
    t.string   "last_name",       :limit => 50
    t.string   "nickname",        :limit => 50
    t.date     "date_of_birth"
    t.string   "address1",        :limit => 50
    t.string   "address2",        :limit => 50
    t.string   "city",            :limit => 100
    t.string   "state",           :limit => 2
    t.string   "province",        :limit => 50
    t.string   "postal_code",     :limit => 10
    t.string   "country",         :limit => 100
    t.string   "gender",          :limit => 1
    t.string   "phone_number",    :limit => 15
    t.string   "image_url"
    t.string   "ip_address",      :limit => 16
    t.datetime "last_login",                                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hashed_password"
    t.string   "salt"
  end

end
