# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_260_418_231_759) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'chunks', force: :cascade do |t|
    t.bigint 'document_id', null: false
    t.text 'content'
    t.jsonb 'vector_sim'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['document_id'], name: 'index_chunks_on_document_id'
    t.index ['vector_sim'], name: 'index_chunks_on_vector_sim', using: :gin
  end

  create_table 'documents', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'questions', force: :cascade do |t|
    t.text 'user_query'
    t.text 'ai_response'
    t.jsonb 'metadata'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'chunks', 'documents'
end
