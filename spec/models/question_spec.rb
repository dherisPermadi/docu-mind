# frozen_string_literal: true

# spec/models/question_spec.rb
require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_query) }
    it { should validate_presence_of(:ai_response) }
  end

  describe 'metadata' do
    it 'correctly stores source document names in metadata' do
      sources = ['Manual.pdf', 'Guide.docx']
      question = Question.create(
        user_query: 'Test query?',
        ai_response: 'Test response',
        metadata: { source_document_names: sources }
      )

      expect(question.metadata['source_document_names']).to eq(sources)
    end
  end
end
