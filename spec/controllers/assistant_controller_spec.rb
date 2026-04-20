# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AssistantController, type: :controller do # rubocop:disable Metrics/BlockLength
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @documents and @previous_questions' do
      doc = Document.create!(name: 'Test Doc')
      get :index
      expect(assigns(:documents)).to include(doc)
      expect(assigns(:question)).to be_a_new(Question)
    end
  end

  describe 'POST #upload_document' do
    let(:name) { 'My Manual' }
    let(:file) { fixture_file_upload('test.txt', 'text/plain') }

    context 'with valid file and name' do
      it 'creates a document and calls Knowledge::Processor' do
        expect(Knowledge::Processor).to receive(:call).once

        post :upload_document, params: {
          document: { name: 'My Manual', file: file }
        }

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Knowledge base updated successfully!')
        expect(Document.last.name).to eq('My Manual')
      end
    end

    context 'with invalid file type' do
      let(:invalid_file) { fixture_file_upload('test.exe', 'application/x-msdownload') }

      it 'rejects the file and redirects with alert' do
        post :upload_document, params: {
          document: { name: 'Virus', file: invalid_file }
        }
        expect(flash[:alert]).to include('Invalid file!')
      end
    end
  end

  describe 'POST #ask' do
    let!(:document) { Document.create!(name: 'Reference') }
    let(:query) { 'How to reset?' }

    context 'when documents exist' do
      it 'calls Knowledge::Searcher and creates a question' do
        fake_chunk = double('Chunk', content: 'Reset by holding button', document: document)
        allow(Knowledge::Searcher).to receive(:call).with(query).and_return([fake_chunk])

        allow(Knowledge::Synthesizer).to receive(:generate_answer).and_return('Synthetic Answer')

        expect do
          post :ask, params: { question: { user_query: query } }, format: :turbo_stream
        end.to change(Question, :count).by(1)

        expect(assigns(:question).ai_response).to eq('Synthetic Answer')
        expect(response.media_type).to eq('text/vnd.turbo-stream.html')
      end
    end

    context 'when no documents exist' do
      it 'sets an error message' do
        Document.destroy_all
        post :ask, params: { question: { user_query: query } }
        expect(assigns(:error)).to eq('Please upload a document first!')
      end
    end
  end
end
