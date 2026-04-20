# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Knowledge::Synthesizer do
  let(:doc) { Document.create!(name: 'Secret_Guide.pdf') }
  let(:chunk) { Chunk.create!(document: doc, content: 'The password is 1234.') }

  describe '.generate_answer' do
    context 'with relevant chunks' do
      it 'formats the answer with a professional intro and source footer' do
        result = described_class.generate_answer([chunk])

        expect(result).to include('Based on the analyzed documents')
        expect(result).to include('The password is 1234.')
        expect(result).to include('Source: Secret_Guide.pdf')
      end
    end

    context 'with no chunks' do
      it "returns a friendly 'not found' message" do
        result = described_class.generate_answer([])
        expect(result).to eq('No relevant information found in the documents.')
      end
    end
  end
end
