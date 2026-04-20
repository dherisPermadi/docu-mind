# frozen_string_literal: true

class CreateChunks < ActiveRecord::Migration[7.0]
  def change
    create_table :chunks do |t|
      t.references :document, null: false, foreign_key: true
      t.text :content
      t.jsonb :vector_sim

      t.timestamps
    end

    add_index :chunks, :vector_sim, using: :gin
  end
end
