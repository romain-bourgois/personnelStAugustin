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

ActiveRecord::Schema.define(:version => 20110324223349) do

  create_table "user_droits", :force => true do |t|
    t.string   "intitule"
    t.string   "code_inchangeable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count",        :default => 0
    t.integer  "failed_login_count", :default => 0
    t.datetime "last_login_at"
    t.string   "last_login_ip"
    t.string   "nom"
    t.string   "prenom"
    t.date     "date_de_naissance"
    t.string   "lieu_de_naissance"
    t.string   "nationalite"
    t.text     "adresse"
    t.string   "ville"
    t.integer  "code_postal"
    t.string   "pays"
    t.string   "tel_portable"
    t.string   "tel_fixe"
    t.integer  "user_droit_id"
  end

end
