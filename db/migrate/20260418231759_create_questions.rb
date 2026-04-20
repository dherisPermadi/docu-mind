# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :user_query
      t.text :ai_response
      t.jsonb :metadata

      t.timestamps
    end
  end
end
