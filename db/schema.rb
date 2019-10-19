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

ActiveRecord::Schema.define(version: 2019_10_19_174645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentication_users", force: :cascade do |t|
    t.string "api_auth_token"
    t.datetime "last_requested"
    t.integer "requested_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_twitter_vibes", force: :cascade do |t|
    t.bigint "match_id"
    t.text "twitter_full_text"
    t.float "score"
    t.string "label"
    t.datetime "twitter_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "external_analyzer_response"
    t.bigint "twitter_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "league_id"
    t.jsonb "data"
    t.integer "external_match_id"
    t.text "twitter_hashtag"
    t.text "winner_side"
    t.integer "winner_external_id"
    t.integer "away_team_external_id"
    t.text "away_team"
    t.integer "home_team_external_id"
    t.text "home_team"
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.index ["away_team_external_id"], name: "index_matches_on_away_team_external_id"
    t.index ["external_match_id"], name: "index_matches_on_external_match_id"
    t.index ["home_team_external_id"], name: "index_matches_on_home_team_external_id"
    t.index ["winner_external_id"], name: "index_matches_on_winner_external_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "tla"
    t.text "name"
    t.text "short_name"
    t.text "crest_url"
    t.text "address"
    t.text "phone"
    t.text "website"
    t.text "email"
    t.text "founded"
    t.text "club_colors"
    t.text "venue"
    t.datetime "external_last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "external_id"
  end

  create_table "twitter_match_trackers", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "twitter_since_id"
    t.text "twitter_result_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
