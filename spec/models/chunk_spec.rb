# frozen_string_literal: true

# spec/models/chunk_spec.rb
require 'rails_helper'

RSpec.describe Chunk, type: :model do
  describe 'associations' do
    it { should belong_to(:document) }
  end

  describe 'data integrity' do
    it 'stores vector_sim as a hash' do
      chunk = Chunk.create(
        content: 'Hello world',
        vector_sim: { 'hello' => 1, 'world' => 1 },
        document: Document.create(name: 'Test')
      )

      expect(chunk.vector_sim).to be_a(Hash)
      expect(chunk.vector_sim['hello']).to eq(1)
    end
  end
end
