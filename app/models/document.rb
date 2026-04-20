# frozen_string_literal: true

class Document < ApplicationRecord
  has_many :chunks, dependent: :destroy
  validates :name, presence: true
end
