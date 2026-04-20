# frozen_string_literal: true

# spec/services/knowledge/processor_spec.rb
require 'rails_helper'

RSpec.describe Knowledge::Processor do
  let(:document) { Document.create!(name: 'Test Doc') }
  let(:file_path) { Rails.root.join('spec/fixtures/files/test.txt') }

  let(:file_data) do
    double('file',
           path: file_path,
           content_type: 'text/plain')
  end

  before do
    File.write(file_path, "Paragraph one.\n\nParagraph two.")
  end

  describe '.call' do
    it 'splits the document into chunks based on paragraphs' do
      expect do
        described_class.call(document, file_data)
      end.to change(Chunk, :count).by(2)

      expect(document.chunks.first.content).to eq('Paragraph one.')
    end

    it 'generates a word tally in vector_sim' do
      described_class.call(document, file_data)
      chunk = document.chunks.first
      expect(chunk.vector_sim).to include('paragraph' => 1, 'one' => 1)
    end
  end
end
