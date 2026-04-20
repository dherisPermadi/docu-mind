# frozen_string_literal: true

# spec/models/document_spec.rb
require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'associations' do
    it { should have_many(:chunks).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
