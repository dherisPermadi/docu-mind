# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Knowledge::Searcher do
  let!(:doc) { Document.create!(name: 'Manual') }
  let!(:chunk_apple) do
    Chunk.create!(document: doc, content: 'Red apples are sweet',
                  vector_sim: { 'red' => 1, 'apples' => 1, 'sweet' => 1 })
  end
  let!(:chunk_car) do
    Chunk.create!(document: doc, content: 'Fast cars are loud', vector_sim: { 'fast' => 1, 'cars' => 1, 'loud' => 1 })
  end

  describe '.call' do
    it 'returns the chunk with the highest word overlap' do
      results = described_class.call('I want sweet apples')

      expect(results.first).to eq(chunk_apple)
      expect(results).not_to include(chunk_car)
    end

    it 'returns multiple chunks if they share keywords' do
      Chunk.create!(document: doc, content: 'Apples are fruit', vector_sim: { 'apples' => 1 })

      results = described_class.call('Tell me about apples')
      expect(results.size).to eq(2)
    end
  end
end
